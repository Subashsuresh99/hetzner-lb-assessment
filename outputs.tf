output "load_balancer_ipv4" {
  description = "Public IPv4 of the load balancer"
  value       = hcloud_load_balancer.lb.ipv4
}

output "server_ipv4s" {
  description = "Public IPv4s of the two web servers"
  value       = { for name, srv in hcloud_server.web : name => srv.ipv4_address }
}
