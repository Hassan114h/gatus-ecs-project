<div align="center">
  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  
  <h1 style="font-size: 3.5em;">🟢 Gatus on ECS Fargate</h1>

  <p>
    <a href="#"><img src="https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws" alt="AWS | ECS Fargate"></a>
    <a href="#"><img src="https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform" alt="Terraform"></a>
    <a href="#"><img src="https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions" alt="CI/CD"></a>
  </p>

  <h3 style="font-weight: normal; color: #555; font-size: 1.5em;">
    Gatus, a status monitoring service, on AWS ECS Fargate using Terraform and GitHub Actions.
  </h3>
</div>

## Insert Diagram 

This project shows a fully functional deployment of **Gatus** on **AWS ECS Fargate**, following best practices for infrastructure and high availability:

- **Terraform backend with S3**: central state storage, versioning for rollbacks, and encryption for security.  
- **Highly available ECS Fargate setup**: Application Load Balancer, Route 53 DNS, and ACM TLS/SSL for secure traffic.  
- **Automated CI/CD deployment**: infrastructure provisioned and updated reliably through pipelines.  

Provides a scalable, secure, and production-ready monitoring solution using Gatus.
