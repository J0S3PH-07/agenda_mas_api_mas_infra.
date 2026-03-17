output "certificate_arn" { value = aws_acm_certificate_validation.main.certificate_arn }
output "route53_zone_id" { value = aws_route53_zone.main.zone_id }
