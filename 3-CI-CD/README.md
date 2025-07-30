# Spring Petclinic CI/CD Pipeline

This Folder contains a GitLab CI/CD pipeline for building, testing, scanning, and deploying the **Spring Petclinic** application.

The CI/CD workflow is containerized, uses Docker-in-Docker, and targets a Kubernetes environment for deployment. It includes image scanning with **Trivy** for security compliance.

---

## 👷 Pipeline Stages

The pipeline consists of the following stages:

1. **Test** - Run unit tests using Maven.
2. **Build** - Build a Docker image using Spring Boot’s buildpack and push it to the GitLab Container Registry.
3. **Scan** - Perform a security scan on the built image using [Trivy](https://github.com/aquasecurity/trivy).
4. **Deploy** - Deploy the application to a Kubernetes cluster using `kubectl`.

---

## 🧪 Stage: Unit Tests

Runs unit tests using Maven inside a lightweight JDK 17 container.

---

## 🔧 Stage: Build

Builds the application Docker image using the Spring Boot buildpack and pushes it to the GitLab Container Registry.

- Caches Maven dependencies for faster builds.
- Uses `docker:dind` service to enable Docker commands inside the job.

---

## 🔒 Stage: Scan

Uses [Trivy](https://github.com/aquasecurity/trivy) to scan the Docker image for vulnerabilities.

---

## 🚀 Stage: Deploy

Deploys the application to a Kubernetes cluster using `kubectl` reling on KAS and give access using .gitlab/agents/swisswcom/config.yaml file .


- Sets up image pull secrets to access the private GitLab Container Registry.
- Applies Kubernetes manifests located in the `k8s/` directory it will be disccussed separately in k8s manifistes folder 

---

## 📆 Caching

Maven dependencies are cached to speed up build time

---


## 🔐 GitLab Variables

Ensure the following variables are defined in your GitLab project settings:

- `CI_REGISTRY_USER` – usually your GitLab username or automation bot.
- `CI_JOB_TOKEN` – predefined by GitLab. create using PAT
- `CI_REGISTRY` – GitLab container registry endpoint

---


