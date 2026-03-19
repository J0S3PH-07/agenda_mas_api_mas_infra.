#!/usr/bin/env bash
set -euo pipefail

# Reload frontend assets to S3 and force ECS frontend redeploy.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

REGION="${AWS_REGION:-us-east-1}"
CLUSTER="${ECS_CLUSTER:-restricted-ecs-project-cluster}"
SERVICE="${ECS_FRONTEND_SERVICE:-restricted-ecs-project-fe-service}"
FRONTEND_DIR="${FRONTEND_DIR:-web_projecte/web projecte}"

if ! command -v terraform >/dev/null 2>&1; then
  echo "Error: terraform no esta instalado o no esta en PATH." >&2
  exit 1
fi

if ! command -v aws >/dev/null 2>&1; then
  echo "Error: aws cli no esta instalado o no esta en PATH." >&2
  exit 1
fi

if [ ! -d "$FRONTEND_DIR" ]; then
  echo "Error: no existe el directorio frontend '$FRONTEND_DIR'." >&2
  exit 1
fi

BUCKET="$(terraform output -json frontend_bucket_name | tr -d '"\n\r')"
if [ -z "$BUCKET" ]; then
  echo "Error: frontend_bucket_name esta vacio. Ejecuta 'terraform output' y revisa el estado." >&2
  exit 1
fi

echo "[1/3] Subiendo frontend a s3://$BUCKET ..."
aws s3 sync "$FRONTEND_DIR/" "s3://$BUCKET/" \
  --delete \
  --exclude ".git/*" \
  --exclude "Dockerfile"

echo "[2/3] Forzando nuevo deployment en ECS ..."
aws ecs update-service \
  --region "$REGION" \
  --cluster "$CLUSTER" \
  --service "$SERVICE" \
  --force-new-deployment >/dev/null

echo "[3/3] Esperando a que el servicio quede estable ..."
AWS_PAGER="" aws ecs wait services-stable \
  --region "$REGION" \
  --cluster "$CLUSTER" \
  --services "$SERVICE"

AWS_PAGER="" aws ecs describe-services \
  --region "$REGION" \
  --cluster "$CLUSTER" \
  --services "$SERVICE" \
  --query 'services[0].{status:status,desired:desiredCount,running:runningCount,pending:pendingCount,taskDefinition:taskDefinition}' \
  --output table

echo "Frontend recargado correctamente."
