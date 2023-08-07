provider "aws" {
  version = ">= 3.0.0"
  # Add any other necessary provider configurations here
}

resource "aws_security_group" "default" {
  name_prefix = "${var.namespace}"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "my-elasticache-subnet-group"
  subnet_ids = ["subnet-040e75a6dbdbe0c2e", "subnet-012b07d11ce5a65db"]  # Replace with the actual subnet IDs in your VPC
}
resource "aws_elasticache_replication_group" "default" {
  replication_group_id   = var.cluster_id
  automatic_failover_enabled = true
  replication_group_description = "Redis cluster for Hashicorp ElastiCache example"

  # Other configurations for the replication group...

  subnet_group_name = aws_elasticache_subnet_group.default.name

  # More configurations for the replication group...
}
