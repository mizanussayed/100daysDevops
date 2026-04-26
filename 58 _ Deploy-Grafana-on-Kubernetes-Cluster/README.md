# Day 58: Deploy Grafana on Kubernetes Cluster

## 🎯 task
1.) Create a deployment named grafana-deployment-nautilus using any grafana image for Grafana app. Set other parameters as per your choice.


2.) Create NodePort type service with nodePort 32000 to expose the app.


`You do not need to make any configuration changes inside the Grafana app once deployed; just make sure you can access the Grafana login page.`


# Solution
```bash
# Create deployment
kubectl create deployment grafana-deployment-nautilus --image=grafana/grafana
```
## Expose the deployment using NodePort service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: grafana-service-nautilus
spec:
  type: NodePort
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 32000
  selector:
    app: grafana-deployment-nautilus
```
