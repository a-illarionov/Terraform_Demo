locals {
  common_tags = {
    environment = "${var.environment}"
    location    = "${var.location}"
  }
  extra_tags = {
    test = "${var.environment}"
  }
}