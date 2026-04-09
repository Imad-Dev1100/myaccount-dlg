resource "aws_ecs_cluster" "this" {
  name = "gfdigital_${var.environment}_myaccount_ecs_cluster"

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_ecs_cluster"
  })
}
