

provider "aws" {
  region  = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "ozi-provision"
    key            = "ozi/dev"
    region         = "af-south-1"# region
    dynamodb_table = "ozi-provision"#resource name
    encrypt = true
  }
}