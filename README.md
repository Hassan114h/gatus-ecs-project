<div align="center">
  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  <h1 style="font-size: 3.5em;"> Gatus on ECS Fargate</h1>

  <p>
    <a href="#"><img src="https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws" alt="AWS | ECS Fargate"></a>
    <a href="#"><img src="https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform" alt="Terraform"></a>
    <a href="#"><img src="https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions" alt="CI/CD"></a>
  </p>
</div>

This project provides a fully functional, production-ready deployment of **Gatus** on **AWS ECS Fargate**, following best practices for security, scalability and infrastructure automation. 

Key features include:
- **Terraform backend with S3**: centralized state storage, versioning for rollbacks and encryption to secure sensitive data.
- **VPC configuration**: public subnets (one per AZ) for ALB and NAT Gateways, private subnets (one per AZ) for ECS tasks.
- **Security Groups**: inbound/outbound rules to control traffic between the ALB and ECS tasks.
- **ECR repository**: stores Docker images for ECS tasks.
- **Route 53 hosted zone**: manages DNS with alias records pointing to the ALB.
- **Automated CI/CD pipelines**: Docker pipeline builds, scans and pushes Gatus images to ECR. Terraform pipeline provisions and manages AWS ECS infrastructure with linting and validation.

This setup delivers a **scalable, secure, and highly available monitoring solution** using Gatus.

<img width="550" height="750" alt="image" src="https://github.com/user-attachments/assets/7bb41c48-02fb-48e4-92bb-31dbbb8834c4" />
