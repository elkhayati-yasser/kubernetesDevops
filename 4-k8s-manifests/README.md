# 🐾 Spring Petclinic on Kubernetes

This repository contains a set of Kubernetes manifests to deploy the **Spring Petclinic** application with a **PostgreSQL** backend. The setup is tailored for local development or on-prem clusters using static persistant local storage.

## 📦 Overview

The deployment is broken down into modular Kubernetes YAML files for clarity and reusability:

| File Name                          | Description |
|-----------------------------------|-------------|
| `storageClass.yaml`            | Defines a `StorageClass` named `local-storage` using `kubernetes.io/no-provisioner`. Required for provisioning local persistent volumes. |
| `pet-pv.yaml`                      | Declares a static `PersistentVolume` (PV) bound to a specific node and local path for PostgreSQL data. |
| `pet-pvc.yaml`                     | Requests a volume via `PersistentVolumeClaim` (PVC) that is bound to the above PV. |
| `04-db-secret.yaml`               | Contains Kubernetes `Secrets` with database credentials and metadata used by both the database and application. |
| `petclinic-deployment.yaml`| Deploys the `PostgreSQL` database. Mounts persistent storage, injects secrets, and includes readiness/liveness/startup probes. |
| `petclinc-db-svc.yaml`   | Creates an internal `ClusterIP` service for the database, exposing it on port `5432`. |
| `petclinic-app-deployment.yaml`         | Deploys the `Spring Petclinic` application. Configured with environment variables, secret volume projection, and HTTP health probes. |
| `petclinic-app-svc.yaml`            | Exposes the application via a `NodePort` service, making it accessible from outside the cluster. |




Prepare Local Storage Path on the Node 

Before applying the Kubernetes manifests, ensure the local storage directory exists on the target node where the PersistentVolume is bound node1

```
sudo mkdir -p /mnt/data/petclinic-db
sudo chmod 700 /mnt/data/petclinic-db
```
