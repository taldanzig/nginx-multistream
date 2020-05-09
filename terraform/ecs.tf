data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "multiplexer" {
  name               = "multiplexer"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_multiplexer_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_multiplexer_policy" {
  name        = "ecr_multiplexer_policy"
  description = "Allow container pull and logs"

  policy = data.aws_iam_policy_document.ecs_multiplexer_policy.json
}

resource "aws_iam_role_policy_attachment" "multiplexer" {
  role       = aws_iam_role.multiplexer.name
  policy_arn = aws_iam_policy.ecr_multiplexer_policy.arn
}

resource "aws_ecs_cluster" "multiplexer" {
  name               = "multiplexer"
  capacity_providers = ["FARGATE"]
}

resource "aws_cloudwatch_log_group" "multiplexer_logs" {
  name = "/ecs/multiplexer"
}

resource "aws_ecs_service" "multiplexer" {
  name                               = "multiplexer"
  cluster                            = aws_ecs_cluster.multiplexer.id
  task_definition                    = aws_ecs_task_definition.multiplexer.arn
  desired_count                      = 0
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  network_configuration {
    subnets = var.subnet_ids

    security_groups = [
      aws_security_group.multiplexer.id,
    ]

    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "multiplexer" {
  family                   = "multiplexer"
  task_role_arn            = aws_iam_role.multiplexer.arn
  execution_role_arn       = aws_iam_role.multiplexer.arn
  memory                   = 8192
  cpu                      = 4096
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  container_definitions = <<EOF
[
  {
    "portMappings": [
      {
        "containerPort": 8080
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.multiplexer_logs.name}",
        "awslogs-region": "us-west-2",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "environment": [
      { "name": "SERVICE_NAME", "value": "multiplexer" }
    ],
    "image": "${aws_ecr_repository.multiplexer.repository_url}",
    "essential": true,
    "name": "multiplexer"
  }
]
EOF

}
