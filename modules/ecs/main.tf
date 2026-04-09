resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-cluster"

  tags = merge(var.default_tags, {
    Name = "${var.environment}-ecs-cluster"
  })
}
