terraform {
  backend "s3" {
    bucket         = "mi-tfstate-ecommerce-055929692786"
    key            = "free-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock"
    encrypt        = true
  }
}
