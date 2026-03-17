moved {
  from = aws_vpc.main
  to   = module.networking.aws_vpc.main
}

moved {
  from = aws_subnet.public_a
  to   = module.networking.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.networking.aws_subnet.public_b
}

moved {
  from = aws_subnet.private_a
  to   = module.networking.aws_subnet.private_a
}

moved {
  from = aws_subnet.private_b
  to   = module.networking.aws_subnet.private_b
}

moved {
  from = aws_internet_gateway.main
  to   = module.networking.aws_internet_gateway.main
}

moved {
  from = aws_route_table.public
  to   = module.networking.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.networking.aws_route_table.private
}

moved {
  from = aws_route_table_association.public_a
  to   = module.networking.aws_route_table_association.public_a
}

moved {
  from = aws_route_table_association.public_b
  to   = module.networking.aws_route_table_association.public_b
}

moved {
  from = aws_route_table_association.private_a
  to   = module.networking.aws_route_table_association.private_a
}

moved {
  from = aws_route_table_association.private_b
  to   = module.networking.aws_route_table_association.private_b
}

moved {
  from = aws_security_group.alb
  to   = module.security.aws_security_group.alb
}

moved {
  from = aws_security_group.ecs_tasks
  to   = module.security.aws_security_group.ecs_tasks
}

moved {
  from = aws_security_group.rds
  to   = module.security.aws_security_group.rds
}

moved {
  from = aws_ecr_repository.main
  to   = module.ecr.aws_ecr_repository.main
}

moved {
  from = aws_ecr_repository.frontend
  to   = module.ecr.aws_ecr_repository.frontend
}

moved {
  from = aws_lb.main
  to   = module.alb.aws_lb.main
}

moved {
  from = aws_lb_target_group.main
  to   = module.alb.aws_lb_target_group.main
}

moved {
  from = aws_lb_target_group.frontend
  to   = module.alb.aws_lb_target_group.frontend
}

moved {
  from = aws_lb_listener.http
  to   = module.alb.aws_lb_listener.http
}

moved {
  from = aws_lb_listener.https
  to   = module.alb.aws_lb_listener.https
}

moved {
  from = aws_lb_listener_rule.api
  to   = module.alb.aws_lb_listener_rule.api
}

moved {
  from = aws_lb_listener_rule.frontend
  to   = module.alb.aws_lb_listener_rule.frontend
}

moved {
  from = aws_db_instance.main
  to   = module.rds.aws_db_instance.main
}

moved {
  from = aws_db_subnet_group.main
  to   = module.rds.aws_db_subnet_group.main
}

moved {
  from = random_password.db_password
  to   = module.rds.random_password.db_password
}

moved {
  from = aws_ssm_parameter.db_password
  to   = module.rds.aws_ssm_parameter.db_password
}

moved {
  from = aws_route53_zone.main
  to   = module.dns.aws_route53_zone.main
}

moved {
  from = aws_acm_certificate.main
  to   = module.dns.aws_acm_certificate.main
}

moved {
  from = aws_acm_certificate_validation.main
  to   = module.dns.aws_acm_certificate_validation.main
}

moved {
  from = aws_route53_record.validation
  to   = module.dns.aws_route53_record.validation
}

moved {
  from = aws_route53_record.alb_alias
  to   = module.dns.aws_route53_record.alb_alias
}

moved {
  from = aws_route53_record.api_alias
  to   = module.dns.aws_route53_record.api_alias
}

moved {
  from = aws_ecs_cluster.main
  to   = module.ecs.aws_ecs_cluster.main
}

moved {
  from = aws_cloudwatch_log_group.ecs
  to   = module.ecs.aws_cloudwatch_log_group.ecs
}

moved {
  from = aws_ecs_task_definition.main
  to   = module.ecs.aws_ecs_task_definition.main
}

moved {
  from = aws_ecs_service.main
  to   = module.ecs.aws_ecs_service.main
}

moved {
  from = aws_ecs_task_definition.frontend
  to   = module.ecs.aws_ecs_task_definition.frontend
}

moved {
  from = aws_ecs_service.frontend
  to   = module.ecs.aws_ecs_service.frontend
}
