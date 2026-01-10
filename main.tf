provider "hcloud" {
  token = var.hcloud_token
}

locals {
  web_servers = {
    "web-1" = { message = "Hello World from web-1" }
    "web-2" = { message = "Hello World from web-2" }
  }
}

resource "hcloud_server" "web" {
  for_each    = local.web_servers
  name        = each.key
  image       = var.image
  server_type = var.server_type
  location    = var.location

  user_data = templatefile("${path.module}/cloud-init-nginx.sh.tftpl", {
    message = each.value.message
  })

  labels = {
    role = "web"
  }
}

resource "hcloud_load_balancer" "lb" {
  name               = "web-lb"
  load_balancer_type = var.lb_type
  location           = var.location

  algorithm {
    type = "round_robin"
  }
}

resource "hcloud_load_balancer_target" "web_1" {
  load_balancer_id = hcloud_load_balancer.lb.id
  type             = "server"
  server_id        = hcloud_server.web["web-1"].id
}

resource "hcloud_load_balancer_target" "web_2" {
  load_balancer_id = hcloud_load_balancer.lb.id
  type             = "server"
  server_id        = hcloud_server.web["web-2"].id
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.lb.id
  protocol         = "http"
  listen_port      = 80
  destination_port = 80



  health_check {
    protocol = "http"
    port     = 80
    interval = 10
    timeout  = 5
    retries  = 3

    http {
      path = "/"
    }
  }

  depends_on = [
    hcloud_load_balancer_target.web_1,
    hcloud_load_balancer_target.web_2
  ]

}
