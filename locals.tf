locals {
  ami_id = data.aws_ami.joindevops
  sg_id = local.sg_id
  private_subnet_id = spilt (",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  common_name = "${var.project}-${var.environment}-$(var.component)"
  vpc_id = data.aws_ssm_parameter.vpc_id
  frontend_alb_listener_arn =  data.frontend_alb_listener_arn.value
  backend_alb_listener_arn = dat.backend_alb_listener_arn.value
  alb_listener_arn = var.component ==  frontend ?  local.frontend_alb_listener_arn : local.backend_alb_listener_arn
  host_header = var.component == frontend ? "${var.project}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
  common_tags = {
        Project = "${var.project}"
        Environment = "${var.environment}"
        Terraform = "true"
    }
}