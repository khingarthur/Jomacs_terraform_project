# Output the load balancer Dns name for testing
output "load_balancer_dnss_name" {
  value = aws_lb.my_lb.dns_name
}



