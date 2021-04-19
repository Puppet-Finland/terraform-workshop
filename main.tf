provider "aws" {
  # Select values for the region from this list:
  #
  # eu-central-1
  # eu-north-1
  # eu-south-1
  # eu-west-1
  # eu-west-2
  # eu-west-3
  #
  # Make sure the value matches the value of region parameter in variables.tf
  region = "eu-west-2"
}

terraform {
  required_version = "= 0.15.0"

  # Uncomment this to enable the local file state backend
  #backend "local" {
  #  path = "local.tfstate"
  #}

  # Comment this backend if you wish to use the local backend
  backend "s3" {
    # Do not change these two values
    bucket = "terraform-state-test-aws.puppeteers.net"
    region = "eu-central-1"

    # Change this "key" to match your alias or nickname. Avoid special
    # characters.  This ensures that your state file does not collide with
    # somebody else's
    key    = "your-alias"
  }
}
