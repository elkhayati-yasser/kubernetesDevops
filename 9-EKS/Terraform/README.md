# AWS EKS Cluster Setup with Terraform

This folder provisions a fully functional **Amazon EKS (Elastic Kubernetes Service)** cluster using **Terraform**, including all required :
  -   VPC networking, IAM roles, Kubernetes add-ons, and node groups.

## Directory Overview

| File | Purpose |
|------|---------|
| `0-locals.tf` | Defines reusable local variables |
| `1-providers.tf` | Sets up AWS and Helm providers |
| `2-vpc.tf` | Creates the VPC (Virtual Private Cloud) |
| `3-igw.tf` | Creates the Internet Gateway |
| `4-subnets.tf` | Defines public and private subnets |
| `5-nat.tf` | Configures NAT gateway for private subnet access |
| `6-routes.tf` | Adds route tables and associations |
| `7-eks.tf` | Provisions the EKS control plane |
| `8-nodes.tf` | Creates node groups for worker nodes |
| `9-add-manager-role.tf` | Adds a role with cluster admin permissions |
| `10-helm-provider.tf` | Initializes Helm provider for Kubernetes add-ons |
| `11-metrics-server.tf` | Installs the Kubernetes Metrics Server |
| `12-pod-Identity-addon.tf` | Enables IAM roles for service accounts (IRSA) |
| `13-cluster-autoscaler.tf` | Deploys the Cluster Autoscaler |
| `values/` | Contains Helm values for add-ons ( Metrics Server)|


1. Initialize Terraform

```
terraform init
```

2. Apply
```
terraform apply
```
