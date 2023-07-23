resource "aws_iam_role_policy" "this" {
  name = "ecs-task-exec"               //Can use variable in future.
  role = aws_iam_role.this.id

//jsencode function will convert terraform expressions to json syntax
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
      },
      {
        "Sid": "ExecuteCommandSessionManagement",
        "Effect": "Allow",
        "Action": [
          "ssm:DescribeSessions"
        ],
        "Resource": "*"
      },
      {
        "Sid": "ExecuteCommand",
        "Effect": "Allow",
        "Action": [
          "ssm:StartSession"
        ],
        "Resource": [
          "arn:aws:ecs:*:*:task/*",
          "arn:aws:ssm:*:*:document/AmazonECS-ExecuteInteractiveCommand"
        ]
      }
    ]
  })
}

# resource "aws_iam_role" "this" {
#   name = "ecs-task-exec-role"
#     assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "this" {
  name = "ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}
data "aws_iam_policy" "ecs-task" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "ecs-task" {
  role = aws_iam_role.this.name
  policy_arn = data.aws_iam_policy.ecs-task.arn
}