# GitLab to Kubernetes Vanilla Cluster Integration Guide

## Prerequisites
- Access to Kubernetes control plane and worker nodes
- SSL certificates for your GitLab domain
- Administrative access to the cluster

## 1. SSL Certificate Setup

### Copy Certificates to Nodes
```bash
# Copy to control plane
scp /path/to/ssl/files user@controlplane:/root/ssl/

# Copy to worker nodes 
scp /path/to/ssl/files user@node:/root/ssl/


### Configure containerd Certificates

On each Kubernetes node (control plane and workers):

# Create directory structure
sudo mkdir -p /etc/containerd/certs.d/gitlab.yasserelkhayati.com:5050/

# Copy certificates
cp -r /root/ssl/* /etc/containerd/certs.d/gitlab.yasserelkhayati.com:5050/


<img width="1877" height="714" alt="image" src="https://github.com/user-attachments/assets/99e97148-7ceb-4646-8288-c753141f0ccc" />

## 2. CoreDNS Configuration

### Edit CoreDNS ConfigMap

kubectl edit cm coredns -n kube-system

Add the following hosts section to the ConfigMap:

hosts {
  192.168.31.239 gitlab.yasserelkhayati.com 
  fallthrough
}

Restart CoreDNS

kubectl rollout restart -n kube-system deployment/coredns

After completing these steps, your GitLab agent should show as connected in the Kubernetes cluster:

<img width="1596" height="538" alt="image" src="https://github.com/user-attachments/assets/39859ba9-828f-4b3c-ab48-cb3e33e3ebcd" />
