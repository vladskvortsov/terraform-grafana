# terraform-grafana
A Terraform module for deploying Grafana container on AWS EC2 using Ansible.


## Prerequisites
- Terraform
- AWS Account & AWS CLI Preconfigured (Security group and rules allowing ssh, and port 3000 for Grafana need manual configuration)


## Configuratin steps:
- Deploying single AWS EC2 instance;
- Attach Elastic IP for instance;
- Provision public key;
- Installing Docker and deploying Grafana container for metrics scrapeing.

To start provisioning clone this repo using :

```sh
git clone https://github.com/vladskvortsov/terraform-grafana.git
cd ~/terraform-grafana
```
And run:

```sh
terraform init
terraform plan 
terraform apply
```

To access Grafana in your browser use Elastic IP created through installiation process and port 3000, in my case:

```sh
http://13.42.200.69:3000
```


> Note: `IMPORTANT NOTICES`

This config uses t2.micro EC2 instance what is `FREE TIER ELIGIBLE` if your not have already pass resources limit for current month.

Also remember Elastic IP is free option only when attached to instance.
