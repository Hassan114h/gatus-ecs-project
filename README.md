<div align="center">
  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  <h1 style="font-size: 3.5em;"> Gatus on ECS Fargate</h1>

  <p>
    <a href="#"><img src="https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws" alt="AWS | ECS Fargate"></a>
    <a href="#"><img src="https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform" alt="Terraform"></a>
    <a href="#"><img src="https://img.shields.io/badge/Container-Docker-2496ED?logo=docker" alt="Docker"></a>
    <a href="#"><img src="https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions" alt="CI/CD"></a>
  </p>
</div>
----

## Navigation
[Key Features](#key-features) • [Architecture Diagram](#architecture-diagram) • [How To Use](#how-to-use) • [Screenshots](#screenshots)

---
This project provides a fully functional, production-ready deployment of **Gatus** on **AWS ECS Fargate**, following best practices for security, scalability and infrastructure automation. 

Key features include:
- **Terraform backend with S3**: Centralised state storage, versioning for rollbacks and encryption to secure sensitive data.
- **VPC configuration**: Public subnets (one per AZ) for ALB and NAT Gateways, private subnets (one per AZ) for ECS tasks.
- **Security Groups**: Inbound/outbound rules to control traffic between the ALB and ECS tasks.
- **ECR repository**: Stores Docker images for ECS tasks.
- **Route 53 hosted zone**: Manages DNS with alias records pointing to the ALB.
- **Automated CI/CD pipelines**: Docker pipeline builds, scans and pushes Gatus images to ECR. Terraform pipeline provisions and manages AWS ECS infrastructure with linting and validation.

This setup delivers a **scalable, secure, and highly available monitoring solution** using Gatus.

## Architecture Diagram
<img width="550" height="750" alt="image" src="https://github.com/user-attachments/assets/3e168beb-0e9d-4e8f-a4b8-1778ad162bd1" />

## How To Use

### Prerequisites
- GitHub Secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `REPO_NAME`  
- S3 bucket for Terraform remote state  


### Steps
```bash
# Clone repository
$ git clone https://github.com/your-username/gatus-ecs-fargate
$ cd gatus-ecs-fargate
```

Update the following files with your values:  
- **S3 bucket for Terraform state**: In your Terraform configuration, edit the `data "aws_s3_bucket" "terraform_state"` block to match your bucket name.  
- **ALB module**: `variables.tf` → `region`  
- **Route53 module**: `variables.tf` → `domain_name`, `hosted_zone_id`  
- **VPC module**: `variables.tf` & `local.tf` → regions, subnets  
- **Root module**: `provider.tf` & `local.tf` → provider config  
- **Gatus config**: `config.yaml` → public domains + optional features (see [Gatus docs](https://gatus.io/))  

**Run Docker CI/CD pipeline manually**: Go to GitHub Actions → select **Docker CICD Pipeline** → click **Run workflow**.  
- **ECS module**: `variables.tf` → `region`, `docker_image`  

**Run Terraform pipeline manually**: Go to GitHub Actions → select **Terraform CICD Pipeline - ECS PROJECT** → click **Run workflow**.  

## Screenshots
<img width="653" height="381" alt="image" src="https://github.com/user-attachments/assets/c700d651-4a2c-469e-9dc3-e08373cbd947" />
<img width="653" height="381" alt="image" src="https://github.com/user-attachments/assets/e3476e4a-34c4-4535-a980-edc120d59402" />
