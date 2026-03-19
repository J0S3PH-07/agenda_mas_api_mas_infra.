#!/usr/bin/env bash
set -euo pipefail

# Deploy backend API changes to ECS by building and pushing a fresh image to ECR.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

AWS_REGION="${AWS_REGION:-us-east-1}"
PROJECT_NAME="${PROJECT_NAME:-restricted-ecs-project}"
CLUSTER="${ECS_CLUSTER:-${PROJECT_NAME}-cluster}"
SERVICE="${ECS_BACKEND_SERVICE:-${PROJECT_NAME}-service}"
REPOSITORY_NAME="${ECR_REPOSITORY_NAME:-${PROJECT_NAME}-repo}"
API_DIR="${API_DIR:-../AGENDA_API}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

if ! command -v aws >/dev/null 2>&1; then
  echo "Error: aws cli no esta instalado o no esta en PATH." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker no esta instalado o no esta en PATH." >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Error: docker daemon no esta activo. Inicia Docker y vuelve a ejecutar el script." >&2
  exit 1
fi

if [ ! -d "$API_DIR" ]; then
  echo "Error: no existe el directorio API '$API_DIR'." >&2
  exit 1
fi

if [ ! -f "$API_DIR/Dockerfile" ]; then
  echo "Error: no se encontro Dockerfile en '$API_DIR'." >&2
  exit 1
fi

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
ECR_REGISTRY="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
ECR_REPO_URL="${ECR_REPO_URL:-${ECR_REGISTRY}/${REPOSITORY_NAME}}"

echo "[1/6] Verificando repositorio ECR..."
aws ecr describe-repositories \
  --region "$AWS_REGION" \
  --repository-names "$REPOSITORY_NAME" >/dev/null

echo "[2/6] Login en ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY" >/dev/null

LOCAL_IMAGE="${PROJECT_NAME}-api:${IMAGE_TAG}"
REMOTE_IMAGE="${ECR_REPO_URL}:${IMAGE_TAG}"

echo "[3/6] Construyendo imagen de backend desde '$API_DIR'..."
docker build -t "$LOCAL_IMAGE" "$API_DIR"

echo "[4/6] Etiquetando y subiendo imagen a ECR..."
docker tag "$LOCAL_IMAGE" "$REMOTE_IMAGE"
docker push "$REMOTE_IMAGE"

if [ "$IMAGE_TAG" != "latest" ]; then
  docker tag "$LOCAL_IMAGE" "${ECR_REPO_URL}:latest"
  docker push "${ECR_REPO_URL}:latest"
fi

echo "[5/6] Forzando nuevo deployment en ECS..."
aws ecs update-service \
  --region "$AWS_REGION" \
  --cluster "$CLUSTER" \
  --service "$SERVICE" \
  --force-new-deployment >/dev/null

echo "[6/6] Esperando a que el servicio quede estable..."
AWS_PAGER="" aws ecs wait services-stable \
  --region "$AWS_REGION" \
  --cluster "$CLUSTER" \
  --services "$SERVICE"

AWS_PAGER="" aws ecs describe-services \
  --region "$AWS_REGION" \
  --cluster "$CLUSTER" \
  --services "$SERVICE" \
  --query 'services[0].{status:status,desired:desiredCount,running:runningCount,pending:pendingCount,taskDefinition:taskDefinition}' \
  --output table

echo "Backend desplegado correctamente con imagen: $REMOTE_IMAGE"