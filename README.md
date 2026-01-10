Hetzner Cloud Terraform Assessment

Project Name: Subash_Test
Project ID: 12991687


Overview
This Terraform project provisions a small web setup on Hetzner Cloud consisting of two web backend
servers behind a load balancer. Each backend serves a distinct response on http://<server-ip>/ and
the load balancer distributes HTTP traffic across both backends.


Folder Structure
hetzner-lb-assessment/
 main.tf
 variables.tf
 outputs.tf
 versions.tf
 cloud-init-nginx.sh.tftpl
 .gitignore
 README.md

 
Prerequisites
• Terraform v1.14.3 (Windows)
• Hetzner Cloud API token provided for the project


Authentication
The API token is provided via an environment variable so it is not stored in Terraform code or
committed to git:
$env:TF_VAR_hcloud_token="YOUR_TOKEN_HERE"

Commands to Run
• Initialize provider and modules: terraform init
• Format files (recommended): terraform fmt
• Validate configuration: terraform validate
• Create / update infrastructure: terraform apply
• Show outputs (LB IP + server IPs): terraform output
• Destroy all resources (cleanup): terraform destroy

How to Test Load Balancer Distribution (PowerShell)
After terraform apply finishes, run:
$lb = terraform output -raw load_balancer_ipv4
1..10 | % { (Invoke-WebRequest "http://$lb/" -UseBasicParsing).Content }
Expected: over multiple requests, the responses should include both Hello World from web-1
and Hello World from web-2 (showing distribution).

Implementation Notes
Page 1
• Two servers are created using a loop (for_each) to avoid copy/paste.
• Servers install and start Nginx automatically via cloud-init and serve a unique index page.
• Server type used: cx23 (small/low-cost option available in fsn1).
• Load balancer listens on port 80 and forwards to destination port 80 with an HTTP health check on
'/'.
• Terraform outputs include the load balancer IPv4 and both server IPv4s.


Steps Performed
1 Installed Terraform on Windows and verified the installation with terraform -version.
2 Created the project directory and the required files: main.tf, variables.tf, outputs.tf, versions.tf,
cloud-init-nginx.sh.tftpl, .gitignore, README.md.
3 Configured the Hetzner API token using the PowerShell environment variable
TF_VAR_hcloud_token.
4 Validated the Terraform configuration using terraform validate.
5 Applied the configuration using terraform apply and confirmed the printed outputs (LB IPv4 +
server IPv4s).
6 Tested traffic distribution by sending 10 requests to the load balancer and observing both backend
responses.
7 Destroyed all resources using terraform destroy.


Evidence
Screenshots were captured for the following: Terraform version output, validation output, apply output
including outputs, load balancer distribution test output, and destroy completion output.
