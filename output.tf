output "blue_url" {
  value = "http://${aws_elastic_beanstalk_environment.blue.cname}"
}
output "green_url" {
  value = "http://${aws_elastic_beanstalk_environment.green.cname}"
}
output "live_env" {
  value = "http://${local.live_url}"
}
