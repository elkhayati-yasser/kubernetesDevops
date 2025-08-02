# Spring Petclinic CI/CD Pipeline

This folder contains a **GitLab CI/CD pipeline** for building, testing, scanning, and deploying the Spring Petclinic application.

The CI/CD workflow is containerized, uses Docker-in-Docker (DinD), and targets a Kubernetes environment for deployment. It includes image security scanning using **Trivy** for vulnerability compliance.

---

##  Pipeline Stages

The pipeline consists of the following stages:

| Stage           | Description                                                                                   |
|-----------------|-----------------------------------------------------------------------------------------------|
| **test**        | Run unit tests using Maven inside a JDK 17 container.                                         |
| **build**       | Build a Docker image using Spring Boot’s buildpack and push it to the GitLab Container Registry. |
| **scan**        | Perform a security vulnerability scan on the built image using Trivy.                        |
| **secret**      | Create Kubernetes secrets for the application (e.g., database credentials).                   |
| **deploy**      | Deploy the application to a Kubernetes cluster using `kubectl`.                              |
| **secreteks**   | Create Kubernetes secrets on an AWS EKS cluster with AWS CLI and update kubeconfig.           |
| **update-manifests** | Manually update Kubernetes manifests with the new Docker image tag and push to GitLab.    |

---

##  Stage Details

### Unit Tests (`test` stage)
- Runs unit tests using Maven (`./mvnw clean test`) inside an Eclipse Temurin 17 Alpine JDK container.
- Tests are allowed to fail without failing the whole pipeline (`allow_failure: true`).

### Build (`build` stage)
- Builds the Spring Boot application image using the Spring Boot buildpack (`spring-boot:build-image`).
- Pushes the Docker image to the GitLab Container Registry using Docker-in-Docker (`docker:dind`).
- Maven dependencies are cached (`.m2/repository`) to speed up builds.
- Docker login uses `$CI_JOB_TOKEN` and `$CI_REGISTRY_USER`.

### Scan (`scan` stage)
- Uses [Trivy](https://github.com/aquasecurity/trivy) to scan the built Docker image for vulnerabilities.
- Runs only on merge request events.
- Generates a GitLab-compliant security report artifact.

### Secret Management (`secret` & `secreteks` stages)
- Creates Kubernetes secrets for the database connection using `kubectl`.
- The `secreteks` stage specifically handles creating secrets on an AWS EKS cluster, configuring AWS CLI with credentials, and updating kubeconfig for the cluster.
- Database credentials are injected using GitLab CI/CD variables.

### Deploy (`deploy` stage)
- Deploys the application to Kubernetes by applying manifests from the `k8s/` directory.
- Sets up image pull secrets for private registry access.

### Update Manifests (`update-manifests` stage)
- Allows manual update of Kubernetes manifests to use the new image tag.
- Uses `yq` to update the container image in the deployment YAML.
- Commits and pushes changes back to the GitLab repository.
- Runs on merge requests and main branch pushes.


