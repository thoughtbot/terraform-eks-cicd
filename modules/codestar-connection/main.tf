resource "aws_codestarconnections_connection" "this" {
  name          = var.name
  provider_type = var.provider_type
  tags          = var.tags
}

resource "aws_ssm_parameter" "codestar_connection" {
  name  = join("/", ["", "codestar_connection", var.provider_type, var.name])
  value = aws_codestarconnections_connection.this.arn
  type  = "String"
}
