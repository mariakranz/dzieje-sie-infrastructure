provider "aws" {
    region     = "${var.region}"
    default_tags {
    tags = {
      manged_by      = "terraform"  
      project        = "dzieje-sie"
    }
  }
}