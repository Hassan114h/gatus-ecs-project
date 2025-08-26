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

## Navigation
[Key Features](#key-features) • [Architecture Diagram](#architecture-diagram) • [How To Use It](#how-to-use-it) • [App Walkthrough](#App-Walkthrough)

---
This project provides a fully functional, production-ready deployment of **Gatus** on **AWS ECS Fargate**, following best practices for Docker containerisation and Terraform IaC, ensuring scalability and infrastructure automation. 

## Key features:
- **Terraform backend with S3**: Centralised state storage, versioning for rollbacks and encryption to secure sensitive data.
- **VPC configuration**: Public subnets (one per AZ) for ALB and NAT Gateways, private subnets (one per AZ) for ECS tasks.
- **Security Groups**: Inbound/outbound rules to control traffic between the ALB and ECS tasks.
- **ECR repository**: Stores Docker images for ECS tasks.
- **Route 53 hosted zone**: Manages DNS with alias records pointing to the ALB.
- **Automated CI/CD pipelines**: Docker pipeline builds, scans and pushes Gatus images to ECR. Terraform pipeline provisions and manages AWS ECS infrastructure with linting, validation and TFsec.

## Architecture Diagram
![ezgif-719eab2db9b7ab](https://github.com/user-attachments/assets/dec86829-9eff-4bd2-9b14-302f281f6d48)

## How To Use It

### Prerequisites
- GitHub Secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `REPO_NAME`  
- S3 bucket for Terraform remote state  


### Steps
```bash
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

## App Walkthrough

![ezgif-774a6d651a144b](https://github.com/user-attachments/assets/0df0f318-6134-44c9-b744-4972eea7ba96)

