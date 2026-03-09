variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "bluegreen-app"
}
variable "blue_version" {
  default = "v1"
}
variable "green_version" {
  default = "v2"
}
variable "live_env" {
  default     = "blue"
  description = "Which environment recieves the live traffic : blue or green"
}

