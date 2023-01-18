terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key = "s3_backend.tfstate"
    region = "eu-central-1"
    dynamodb_table = "s3-state-lock"
    access_key = "use-your-own-key"
    secret_key = "use-your-own-key"
  }
}