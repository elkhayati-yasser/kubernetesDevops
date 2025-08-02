#  Argo CD for Kubernetes GitOps Deployment


This folder uses **Argo CD** to continuously deploy Kubernetes workloads to an **Amazon EKS (Elastic Kubernetes Service)** cluster using a GitOps workflow.


##  Argo CD Installation


After Terraform finishes setting up the infrastructure, we can deploy Argo CD to EKS cluster.

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Access the Argo CD Web UI

By default, the Argo CD API server is not exposed with an external IP. To access the API server we have to Change the argocd-server service type to LoadBalancer

<img width="1701" height="655" alt="image" src="https://github.com/user-attachments/assets/4a0fdd1e-e4ff-4bbc-bd5c-fab5abff4ae5" />

And we can create application to deploy our petclinic app 

<img width="1170" height="826" alt="image" src="https://github.com/user-attachments/assets/bacfcdca-1e06-45cc-9246-951a605cb62d" />

