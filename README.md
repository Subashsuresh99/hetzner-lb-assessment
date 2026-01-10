# Hetzner Cloud Terraform Assessment — 2 Web Servers Behind a Load Balancer

**Hetzner Project Name:** Subash_Test  
**Hetzner Project ID:** 12991687  

## Overview
This Terraform project provisions:
- **2 web servers** (`web-1`, `web-2`) running Nginx on port **80**
- **1 Hetzner Load Balancer** in front of them (HTTP **80 → 80**) distributing traffic across both servers
- Terraform outputs for the **Load Balancer IPv4** and **server IPv4s**
- Clean removal using `terraform destroy`

Each backend serves a distinct response at `/`:
- `Hello World from web-1`
- `Hello World from web-2`

---

## Folder Structure
hetzner-lb-assessment/

├─ main.tf

├─ variables.tf

├─ outputs.tf

├─ versions.tf

├─ cloud-init-nginx.sh.tftpl

├─ .gitignore

└─ README.md


---

## Prerequisites
- Terraform installed on Windows
- Verified version used: **Terraform v1.14.3**
  ```powershell
  terraform -version
Hetzner Cloud API Token (provided)

---

Created the Terraform files using:
```powershell
 New-Item main.tf,variables.tf,outputs.tf,versions.tf,cloud-init-nginx.sh.tftpl,.gitignore,README.md -ItemType File
```
---

Authentication (PowerShell)

The API token is passed via environment variable and not committed to the repository:
```powershell
$env:TF_VAR_hcloud_token="YOUR_TOKEN_HERE"
```
---

Commands to Run
1) Initialize 
```powershell
 terraform init
```
2) Validate 
 ```powershell
terraform validate
```
3) Deploy (Server type used: cx23 (available and orderable in fsn1)) 
  ```powershell
terraform apply
```

---

How to Test (Verify Distribution)

1) Get Load Balancer IP
```powershell
$lb = terraform output -raw load_balancer_ipv4
```

3) Send multiple requests to observe distribution
```powershell
1..10 | % { (Invoke-WebRequest "http://$lb/" -UseBasicParsing).Content }
```

Expected: Over repeated requests, both responses should appear over time:

Hello World from web-1

Hello World from web-2

---

Outputs
```powershell
terraform output
```

Includes:

load_balancer_ipv4 — public IPv4 of the Load Balancer

server_ipv4s — public IPv4s of web-1 and web-2

---

Cleanup

Destroyed all created resources using :
```powershell
terraform destroy
```

---

Evidence

Screenshots captured for:

Terraform version

terraform validate

Successful terraform apply + outputs

Load balancer test output showing distribution

Successful terraform destroy


   

