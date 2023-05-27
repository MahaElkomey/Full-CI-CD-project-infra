terraform {
  backend "s3" {
    bucket = "itiprojectterraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
