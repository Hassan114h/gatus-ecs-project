<div align="center">
  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  
  <h1 style="font-size: 3.5em;">🟢 Gatus on ECS Fargate</h1>


[![AWS | ECS Fargate](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)]()
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)]()
[![CI/CD](https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions)]()

This project demonstrates a fully functional deployment of **Gatus** on **AWS ECS Fargate**, following best practices for infrastructure, high availability, and automation. Key features include:

- **Terraform backend with S3**: central state storage, versioning for rollbacks, and encryption for security.
- **VPC Configuration**: 2 public subnets (one per AZ) for ALB and NAT Gateways, 2 private subnets (one per AZ) for ECS tasks.
- **ECR repository** for storing application images.
- **Route 53 hosted zone** with an alias record pointing to the ALB.
- **Automated CI/CD deployment**: infrastructure provisioned and updated reliably through GitHub Actions pipelines.

Provides a scalable, secure, and production-ready monitoring solution using Gatus.
