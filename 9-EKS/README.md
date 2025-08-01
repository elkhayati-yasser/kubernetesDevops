#  AWS EKS  with Terraform


Steps to provision an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform, and configure access via different AWS IAM users.

## 1: Configure AWS Access

Before deploying infrastructure, create an **Access Key ID** and **Secret Access Key** for your IAM user and configure them locally:

<img width="1039" height="154" alt="image" src="https://github.com/user-attachments/assets/ff54890b-96ed-4e50-94ca-e325aaa200b0" />

## 2: Deploy Infrastructure 

Once the AWS CLI is configured:
```
terraform init
terraform apply
```
<img width="961" height="220" alt="image" src="https://github.com/user-attachments/assets/c522f5ab-93bc-413c-b3c4-433632879a4f" />


## 3: Validate AWS Console Resources

In the **AWS Console (Ohio region)**, verify the following:

- EKS cluster is healthy
- Node group and its associated Auto Scaling Group (ASG)
- Launch Template used by the ASG
- EC2 instances are registered in the ASG

## 4: Create RBAC for Manager Role

Create Kubernetes RBAC (Role-Based Access Control) to grant admin access to the Manager IAM role:

<img width="823" height="31" alt="image" src="https://github.com/user-attachments/assets/e183fd2c-20ba-46ae-b19d-ab0f443f5fbc" />

## 5: Configure AWS CLI Profile for Manager User 

Generate a new Access Key and Secret Key for the Manager user, then configure a new named profile:

```bash
aws configure --profile manager
```

<img width="1087" height="103" alt="image" src="https://github.com/user-attachments/assets/d6b23399-b887-49c6-9abd-cdccedfefdef" />


To update kubeconfig and switch to the Manager user:

```bash
aws eks update-kubeconfig --name prod-petclinc-prod --region us-east-2 --profile manager
```

This command sets up your `kubeconfig` file to authenticate with the EKS cluster using the Manager profile.
