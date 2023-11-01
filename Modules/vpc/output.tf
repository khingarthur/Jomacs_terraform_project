output "load_balancer" {
  value = aws_lb.my_lb.dns_name
}