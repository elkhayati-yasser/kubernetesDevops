# Load Balancing Configuration for Spring Petclinic

This folder contains the configuration files to implement **load balancing** for the Spring Petclinic application using:

- **NGINX Ingress Controller** for HTTP routing
- **MetalLB** as the LoadBalancer provider

### `metallb-config.yaml`

- Defines an IP address pool for MetalLB to assign LoadBalancer IPs in our local network.
- Includes a Layer 2 (ARP) advertisement to announce these IPs.

Note : we need to Expose the Spring Petclinic application internally using a **ClusterIP** service and  targets container port `80`.

### `petclinic-ingress.yaml`

- Routes external traffic to the internal `petclinic` service via an Ingress rule.


## Setup 

### 1. Install MetalLB

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml
```

### 2. Configure MetalLB

```bash
kubectl apply -f metallb-config.yaml
```

### 3. Install NGINX Ingress Controller

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --set controller.service.type=LoadBalancer
```

### 4. Apply Petclinic Ingress
```bash
kubectl apply -f petclinic-ingress.yaml
```
<img width="849" height="93" alt="image" src="https://github.com/user-attachments/assets/607b5bbd-8586-4abe-aee2-7164cf4fee22" />


Since we're using MetalLB, we can change the Ingress Controller service type to LoadBalancer to expose it externally with a real IP address.

<img width="1549" height="184" alt="image" src="https://github.com/user-attachments/assets/9265a2e2-6f20-4baf-a0cb-63465b1ed295" />

We can now access the service on port 80 using the advertised LoadBalancer IP provided by MetalLB.

<img width="929" height="631" alt="image" src="https://github.com/user-attachments/assets/f4e7a9cf-b870-4bc3-8bb5-1ccfa8c37a38" />


