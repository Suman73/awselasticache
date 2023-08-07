provider "aws" {
  version = ">= 3.0.0"
  region  = "ap-south-1"  # Replace this with your desired AWS region
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
resource "aws_elasticache_parameter_group" "example" {
  name   = "example-redis-parameter-group"
  family = "redis7"
  description = "Example Redis Parameter Group"
  # Add any parameter settings if necessary
}

resource "aws_elasticache_replication_group" "example" {
  automatic_failover_enabled  = true
  preferred_cache_cluster_azs = ["ap-south-1a", "ap-south-1b"]
  replication_group_id        = "tf-rep-group-1"
  description                 = "example description"
  node_type                   = "cache.t2.micro"
  num_cache_clusters          = 2
  parameter_group_name        = "default.redis7"
  port                        = 6379
}



