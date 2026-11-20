# Project 6: Version Control Infrastructure

This cloud-free Terraform demo tracks a small infrastructure configuration in Git. It uses Terraform's built-in `terraform_data` resource to record a server name and environment in local state. It does **not** create a server or any cloud resources, require cloud credentials, or use an external provider.

## Try it

Install Terraform 1.4 or newer, then run:

```sh
terraform init
terraform validate
terraform plan
terraform apply
terraform output
```

Confirm the apply when prompted. Edit `server_name` or `environment` in `terraform.tfvars`, then run `terraform plan` to see the proposed update before applying it. Run `terraform destroy` to remove the demo resource from local state.

Terraform state and working files are excluded from Git. Local state is suitable for this demo only; real infrastructure projects should use a secure shared backend with locking and avoid committing secrets.
