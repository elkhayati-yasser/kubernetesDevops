# Monitoring Setup for Spring Petclinic on Kubernetes

1. Enable Actuator and micrometer in our pom.xml and rebuild the image:

```
<dependencies>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
  </dependency>
  <dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
  </dependency>
</dependencies>
```

In the application deplyement we can passe somme management parameters using SPRING_APPLICATION_JSON :

```
                  "management.endpoint.health.probes.add-additional-paths": true,
                  "logging.level.org.springframework.web": "DEBUG",
                  "management.endpoint.prometheus.enable" : true,
                  "management.endpoints.web.exposure.include" : "*",
                  "management.prometheus.metrics.export.enabled": true
```
This exposes the Prometheus endpoint, which provides metrics that can be collected for monitoring.


2. Set up Prometheus and Grafana on Kubernetes

Install Prometheus

```
helm install prometheus bitnami/kube-prometheus
```

<img width="1234" height="110" alt="image" src="https://github.com/user-attachments/assets/e23377b8-22f6-44fd-8748-6ec54adf4307" />


Install Grafana

```
helm install grafana bitnami/grafana
```
<img width="652" height="131" alt="image" src="https://github.com/user-attachments/assets/f017ef43-cb6e-4887-96c6-14082228ecda" />

Finaly couple Prometheus with Grafana

<img width="1499" height="263" alt="image" src="https://github.com/user-attachments/assets/ecb1e3a0-dfcd-448c-8fae-4e59b1299366" />



specify a ServiceMonitor that defines endpoints to scrape metrics.

```
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
 name: petclinic-app-service-monitor
spec:
 selector:
   matchLabels:
     app: petclinic-app-svc
 endpoints:
   - port: http
     path: "/actuator/prometheus"
```

<img width="1833" height="326" alt="image" src="https://github.com/user-attachments/assets/942d49c7-556e-473d-aa3f-16d54e421781" />

 
 let’s head to Grafana and visualize our metrics there
 
<img width="922" height="537" alt="image" src="https://github.com/user-attachments/assets/fdaa6bd6-cb2b-4484-848b-3eabf3a04118" />


OverView of our K8S Cluster 

<img width="1346" height="674" alt="image" src="https://github.com/user-attachments/assets/4160bdd4-73cd-44d4-af64-c54894800c49" />

Application Monitoring with Prometheus and Grafana

<img width="1688" height="912" alt="image" src="https://github.com/user-attachments/assets/67f8a5c1-7d0b-4ed6-a17f-f8a3e1ca41b4" />

