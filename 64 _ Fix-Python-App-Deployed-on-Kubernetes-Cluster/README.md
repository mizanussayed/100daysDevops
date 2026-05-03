# Day 64: Fix Python App Deployed on Kubernetes Cluster

## 🎯 task
The deployment name is python-deployment-xfusion, its using poroko/flask-demo-app image. The deployment and service of this app is already deployed.

nodePort should be 32345 and targetPort should be python flask app's default port.


## 🧑‍💻 solution
1. Check the current deployment and service configuration:

```bash
kubectl get deployment python-deployment-xfusion -o yaml
kubectl get service python-service-xfusion -o yaml
```
## update if needed


