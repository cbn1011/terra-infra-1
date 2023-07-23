resource "aws_security_group" "ecs_sg" {
  name        = "messaging-sg"
  description = "Need to modify this"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}