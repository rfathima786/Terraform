terraform {

  backend "s3" {
    bucket         = "rayees-s3-staticfile-test"  # Replace with your S3 bucket name
    key            = "Day1-Basic/terraform.tfstate"    # Path in the bucket to store the state file
    region         = "us-east-1"     
    
  }
}