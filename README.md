# Cloud Platform Engineer (Kubernetes) Assessment

This repository contains my solution for the **Cloud Platform Engineer (Kubernetes)** assessment.

The project demonstrates the **end-to-end deployment of the Spring Petclinic application** on a Kubernetes cluster with **CI/CD**, and several **production-grade enhancements** such as monitoring, autoscaling, and secure networking.

---
## Architecture

<img width="1192" height="660" alt="image" src="https://github.com/user-attachments/assets/e12ef9f8-0aeb-447c-ad06-64351ba99731" />

---

## 📂 Repository Structure

### `0-gitlab/`

- **Self-hosted GitLab CE** with Docker Compose
- **GitLab Runner** configuration
- **TLS configuration** for a custom domain: `gitlab.yasserelkhayati.com`
- **Secure Runtime** setup with sysbox

---

### `1-k8s-cluster/`

- Local Kubernetes cluster setup using [`kind`](https://kind.sigs.k8s.io/)
- Local Kubernetes cluster setup using Kubeadm ( 2 nodes)

---

### `2-Kubernetes-agent-server/`

- GitLab **Kubernetes Agent Server (KAS)** configuration files
- `agentk` connected to GitLab through the KAS tunnel via TLS

---

### `3-ci-cd/`

- Complete GitLab **CI/CD pipeline**:
  - Build with Maven
  - Test 
  - Image scanning with **Trivy**
  - Push to GitLab Container Registry (Private)
  - Auto-deploy using GitLab Agent for Kubernetes (**KAS**)
- Pipeline stages include:  `test`,`build`, `scan image`, `secret` and `deploy`

---

### `4-k8s-manifests/`

- Kubernetes manifests for deploying **Spring Petclinic**
- Includes:
  - Deployment, Services, Secret , PVC, PV , StorageClass 
  - Readiness & Liveness probes
  - Node Affinity
  - Resources requests and Limits

---

### `5-Network-Policie-cilium/`

- Network Policies using **Cilium CNI**
- Allows only necessary communication (e.g., app ↔ DB)
- Allow only communication between app and db

---

### `6-Scalling/HPA/`

- **Horizontal Pod Autoscaler (HPA)** configuration for Spring Petclinic
- Based on CPU metrics collected via **Metrics Server**
- Autoscaling thresholds and limits are configurable

---

### `7-Monitoring/Application/`

- **Prometheus ServiceMonitor** configuration for Spring Petclinic
- Metrics exposed using Spring Actuator and `/actuator/prometheus` endpoint
- Application-level observability enabled for dashboards in grafana

### `8-LoadBalancer-Ingress/`

    - *MetalLB* to provide a LoadBalancer IP in local Kubernetes (kind) clusters.
    - *NGINX Ingress Controller* to route HTTP traffic to internal services

