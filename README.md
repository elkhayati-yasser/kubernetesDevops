# Cloud Platform Engineer (Kubernetes) Assessment

This repository contains my solution for the Cloud Platform Engineer (Kubernetes) assessment. 

The project demonstrates the end-to-end deployment of the Spring Petclinic application on a Kubernetes cluster with CI/CD, GitOps, and several production-grade enhancements.

## Repository Structure

### `0-gitlab/`
- Docker Compose setup for a self-hosted GitLab CE and GitLab Runner
- TLS setup for custom domain `gitlab.yasserelkhayati.com`
- Secure Runtime
- GitLab Container Registry and GitLab KAS (Kubernetes Agent Server) configuration

### `1-cluster/`

- Kubernetes cluster setup using `kind`

### `3-ci-cd/`

- GitLab CI/CD pipeline configuration (`.gitlab-ci.yml`)
- GitLab KAS setup for GitOps-style deployment


