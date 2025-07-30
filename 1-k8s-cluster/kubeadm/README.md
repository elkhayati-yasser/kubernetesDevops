# 🛠️ Kubernetes Cluster Setup with Containerd and Cilium

This guide is how i'am setting up a Kubernetes cluster manually using `kubeadm`, `containerd`, and `Cilium` CNI on a 2 ubuntu Linux machines

## ⚙️ Step-by-Step Instructions

1. Disable Swap

Kubernetes requires swap to be disabled.

```
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```


2. Enable IP Forwarding
```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
```
```
sudo sysctl --system
```

3. Install Containerd

```
sudo apt update && sudo apt install -y containerd
```

4. Configure containerd:

```
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i -e "s/SystemdCgroup = false/SystemdCgroup = true/g" /etc/containerd/config.toml
sudo systemctl restart containerd
```

5. Install Kubernetes Components
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
6. Initialize Control Plane Node
```
kubeadm init
```
7. Install Cilium CNI
```
cilium install --version 1.18.0
```

8. Join Worker Node

```
kubeadm join 192.168.31.151:6443 --token k6d0dx.9my4dts9g1378w0v \
    --discovery-token-ca-cert-hash sha256:e19070bc93673edc6e8925b3a77f715bf37ef92fff40497fa48a7173ccf0d4b0
```


You can verify everything is running with:
```
kubectl get nodes
```


![nodes ready](/1-k8s-cluster/kubeadm/1.PNG)
