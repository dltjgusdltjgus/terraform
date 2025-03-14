terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "dltjgus-terraform-s3"
    key            = "<SOME PATH>/terraform.tfstate" # <SOME PATH> -> mysql
    region         = "ap-northeast-2"
    dynamodb_table = "dltjgus-terraform-Dynamo"
    encrypt        = true

  }
}

provider "aws" {
  region = "ap-northeast-2"

  # 2.x 버전의 AWS 공급자 허용
  version = "~> 2.0"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"

  username            = "admin"

  name                = var.db_name
  skip_final_snapshot = true

  password            = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "dltjgus_key"
}

