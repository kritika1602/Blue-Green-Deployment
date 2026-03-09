locals {
  live_url = var.live_env == "blue" ? (aws_elastic_beanstalk_environment.blue.cname) : (aws_elastic_beanstalk_environment.green.cname)
}
