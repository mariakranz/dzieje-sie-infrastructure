#variables.tf
variable "access_key" {
    description = "Access key to AWS console"
}
variable "secret_key" {
    description = "Secret key to AWS console"
}
variable "region" {
    description = "AWS region"
    default = "eu-west-1"
}

variable "discord_webhook_url" {
  description = "Discord Webhook URL"
}

variable "db_username" {
    description = "Username in RDS"
}

variable "db_password" {
    description = "Password to RDS"
}