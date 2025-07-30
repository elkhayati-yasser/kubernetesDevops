# NetworkPolicy: Restrict Access to petclinic-db


This `NetworkPolicy` ensures that only the `petclinic-app` can access the `petclinic-db` PostgreSQL service, enhancing security within the Kubernetes cluster.

## 🔒 Objective

To restrict access to the database (`petclinic-db`) so that **only the `petclinic-app` can connect to it**, we create a Kubernetes `NetworkPolicy` that:

1. **Denies all ingress traffic** to the `petclinic-db` pods by default.
2. **Allows ingress traffic only** from pods with label `app=petclinic-app` to port `5432` (PostgreSQL).

---

## Pre-Requisites

To enforce NetworkPolicies, we must use a CNI plugin that supports them. In this case, we are using: Cilium

## Testing the NetworkPolicy

 ### Before Applying the Policy

 Example Test:

```
kubectl run test-pod --rm -it --image=alpine -- /bin/sh
# Inside:
apk add --no-cache netcat-openbsd
nc -zv petclinic-db-svc 5432
```

<img width="1102" height="413" alt="image" src="https://github.com/user-attachments/assets/a71dfe77-fdec-466f-9ba6-6d7896997025" />

### After Applying the Policy

Connection timed and  refused. 

<img width="1238" height="96" alt="image" src="https://github.com/user-attachments/assets/cbca536d-e952-4b05-b1c8-e3bf3ed165d7" />





