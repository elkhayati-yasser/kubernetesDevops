Autoscaling the petclinic-app with Horizontal Pod Autoscaler (HPA)


To implement autoscaling for your petclinic-app using Kubernetes' Horizontal Pod Autoscaler (HPA), we will follow these steps:

1. Metrics Server
  
Ensure the Metrics Server is installed in our cluster. It enables the HPA to retrieve metrics like CPU or memory usage:

<img width="1013" height="157" alt="image" src="https://github.com/user-attachments/assets/436690d1-7368-48b2-ab00-19697a7febc7" />


2. Adjust Resource Requests to petclinic-app

This is required for the HPA to make autoscaling decisions.In our case :

<img width="1912" height="147" alt="image" src="https://github.com/user-attachments/assets/776083b3-9b1b-4c43-8c4e-0d91e79b278d" />

```
        resources:
          requests:
            cpu: 50m
            memory: 600Mi
```
the file  petclinic-hpa.yaml contains the resource that will scal based on percentage of usage both memory and CPU

4. Monitor the HPA
```
kubectl get hpa
```

<img width="1437" height="146" alt="image" src="https://github.com/user-attachments/assets/81fae9d6-6917-4aa3-85aa-17ae03cdf337" />

5. Generate Load


```
while true; do wget -q -O- http://petclinic-app-svc.default.svc.cluster.local; done
```
Then monitor autoscaling:

<img width="1423" height="220" alt="image" src="https://github.com/user-attachments/assets/573b6b6c-08bb-44ee-8245-28648431f28a" />

HPA triggered scaling, and the deployment reached 5 replicas.

<img width="939" height="290" alt="image" src="https://github.com/user-attachments/assets/14fafbd7-e37d-44d5-b59e-80885c955580" />





