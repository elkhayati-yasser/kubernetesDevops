# kind Kubernetes Cluster Configuration


This repository contains a `kind` cluster configuration file to create a local Kubernetes cluster with multiple nodes and customized settings for local development and testing.



The cluster config defines a multi-node kind cluster with:

- **1 control-plane node**
- **2 worker nodes**


## Usage

1. **Install kind**
2. Place your SSL certificate
3. Create the cluster using this config file:

      ```
      kind create cluster --config kind-cluster-config.yaml
      ``` 

## Notes ## 

    Make sure the SSL certificate path exists and is readable by Docker/kind.

    Adjust port mappings as needed to avoid conflicts with other services on your host.

    The ingress-ready=true node label can be used for ingress controller deployment or custom scheduling.

    The containerd config patch ensures your local registry with the custom certificate is trusted.



### Due to certain limitations, I provisioned another cluster using Kubeadm. ###
