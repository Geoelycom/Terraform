# 🌍 Terraform Learning Repository

Welcome to your Terraform learning journey! This repository is designed to take you from **zero to hero** with real-world Infrastructure as Code (IaC) projects using **Terraform**. Whether you're just getting started with DevOps or want to solidify your Terraform skills, you're in the right place.

---

## 📘 About This Project

This repo is based on my learning materails from youtube, udemy, online resources and my experiences working with Terraform to deploy infrastructures on the cloud it includes practical examples and guided exercises to help you learn how to:

- Deploy infrastructure using **Terraform**
- Manage state remotely with **HCP Terraform**
- Apply best practices using **version-controlled workflows**
- Build and maintain **modular, reusable Terraform code**
- Securely manage secrets and variables with **Vault integration**

---

## 📂 Repository Structure

Here's a quick overview of what you'll find inside:

| Folder/Module        | Description |
|----------------------|-------------|
| `variables/`         | Working with input/output variables and locals |
| `remote-state/`      | Storing and retrieving Terraform state remotely using HCP |
| `cloud-config/`      | Cloud infrastructure provisioning examples (e.g., AWS) |
| `vcs-workflow/`      | Setting up VCS-based triggers with GitHub and HCP Terraform |
| `local-infra/`       | Building local infrastructure for testing and learning |

---

## 🧰 Prerequisites

Before you get started, make sure you have the following:

- ✅ [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed
- ✅ A valid [AWS Account](https://aws.amazon.com/)
- ✅ An [HCP Terraform](https://cloud.hashicorp.com/products/terraform) account
- ✅ A GitHub account (for VCS integration)
- ✅ Basic knowledge of terminal usage

---

## 🔐 Secrets Management

Do **NOT** hardcode your AWS credentials inside your Terraform files. Instead:

1. Store secrets securely using HCP Terraform’s variable UI.
2. Use environment variables for local testing:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

--- 
🚀 Getting Started
1. Fork or clone the repo:
```bash 
git clone https://github.com/your-username/terraform-learning.git
cd terraform-learning
```

2. Choose a module to start with, e.g., cd variables/
3. Initialize the project:
```bash
terraform init
```
4. Review the plan:
```bash
terraform plan
```
5. Apply it
```bash 
terraform apply
```
6. Destroy when done:
```bash
terraform destroy
```

## 🧠 Topics You’ll Learn
Terraform core concepts: providers, resources, modules, state

AWS provisioning (EC2, VPC, IAM, etc.)

Remote backends and state locking

HCP Terraform and VCS automation

Secrets and variable management

Terraform Cloud Workspaces

Reusability with modules



## 🧭 Next Steps
Once you complete the basics, you can:

Try creating your own reusable modules

Deploy a 3-tier web app using modules

Integrate Terraform with CI/CD pipelines

Explore advanced features like for_each, dynamic, and count



📚 Resources
Terraform Docs

HCP Terraform

AWS Free Tier

Vault by HashiCorp

Learn Terraform - HashiCorp


