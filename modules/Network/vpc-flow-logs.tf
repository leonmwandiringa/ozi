/*
resource "aws_flow_log" "network_flow_logs" {
  iam_role_arn    = aws_iam_role.network_flow_logs_iam_role.arn
  log_destination = aws_cloudwatch_log_group.network_flow_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.network_vpc.id
  depends_on = [
    aws_vpc.network_vpc,
  ]
  tags = merge(
    {
      "Name" = "network_flow_logs"
    },
    var.global_tags,
  )
}

resource "aws_cloudwatch_log_group" "network_flow_log_group" {
  name = "network-flow-logs"
}

resource "aws_iam_role" "network_flow_logs_iam_role" {
  name = "flow_logs_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "network_flow_logs_policy" {
  name = "network_flow_logs_policy"
  role = aws_iam_role.network_flow_logs_iam_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}*/