<div align="center">
  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  
 <div align="center">

  <img width="100" height="100" alt="Gatus Logo" src="https://github.com/user-attachments/assets/bb670d76-1282-4bad-a9e9-4190d9f43410" />
  
  <h1 style="font-size: 3.5em;">🟢 Gatus on ECS Fargate</h1>

  <p>
    <a href="#"><img src="https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws" alt="AWS | ECS Fargate"></a>
    <a href="#"><img src="https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform" alt="Terraform"></a>
    <a href="#"><img src="https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions" alt="CI/CD"></a>
  </p>

  <p style="font-size: 1.2em; color: #555; text-align: center; max-width: 800px;">
    This project demonstrates a fully functional deployment of <strong>Gatus</strong> on <strong>AWS ECS Fargate</strong>, following best practices for infrastructure, high availability, and automation. Key features include:
  </p>

  <ul style="list-style-type: none; padding-left: 0; text-align: left; display: inline-block; text-align: left; max-width: 700px;">
    <li>• <strong>Terraform backend with S3</strong>: central state storage, versioning for rollbacks, and encryption for security.</li>
    <li>• <strong>Highly available ECS Fargate setup</strong>: Application Load Balancer, Route 53 DNS, and ACM TLS/SSL for secure traffic.</li>
    <li>• <strong>VPC Configuration</strong>: 2 public subnets (one per AZ) for ALB and NAT Gateways, 2 private subnets (one per AZ) for ECS tasks.</li>
    <li>• <strong>ECR repository</strong> for storing application images.</li>
    <li>• <strong>Route 53 hosted zone</strong> with an alias record pointing to the ALB.</li>
    <li>• <strong>Automated CI/CD deployment</strong>: infrastructure provisioned and updated reliably through GitHub Actions pipelines.</li>
  </ul>

  <p style="font-size: 1.2em; color: #555; text-align: center; max-width: 800px;">
    Provides a scalable, secure, and production-ready monitoring solution using Gatus.
  </p>

</div>
