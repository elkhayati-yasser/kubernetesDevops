# Cluster Autoscaler – Kubernetes Node Scaling

This directory contains the configuration needed to deploy **Cluster Autoscaler** in a Kubernetes cluster to automatically scale worker nodes


`9-EKS/Terraform/13-cluster-autoscaler.tf`:
  
  - Terraform configuration to deploy the Cluster Autoscaler on EKS.
  - Other support files as needed (e.g., IAM roles, Helm provider, values).
  - We also relay on pod identity to map a role to a service account

<img width="764" height="449" alt="image" src="https://github.com/user-attachments/assets/ca1abd02-1b88-48bb-a31b-e283b072e4a6" />


Node groups must be created as ASGs with the proper tags:
```
k8s.io/cluster-autoscaler/enabled = true
k8s.io/cluster-autoscaler/petclinc-prod = owned
```

IAM Role and Policy : This role is linked to a Kubernetes Service Account via IRSA (IAM Roles for Service Accounts).

The EKS Cluster Scale based on this config :

<img width="777" height="558" alt="image" src="https://github.com/user-attachments/assets/bc548e08-a125-4f29-a8e6-54c7e9782a09" />

   
