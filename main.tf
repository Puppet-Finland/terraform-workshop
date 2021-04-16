provider "aws" {
  # If you run into issues with the VPC limit change this region. Region names are listed here:
  #
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-regions
  #
  region = "eu-central-1"
}

terraform {
  required_version = "> 0.14.0"

  backend "s3" {
    bucket = "terraform-state-test-aws.puppeteers.net"
    region = "eu-central-1"

    # Change this "key" to match your name or alias. Avoid special characters.
    # This ensures that your state file does not collide with somebody else's
    key    = "your-alias"
  }
}
