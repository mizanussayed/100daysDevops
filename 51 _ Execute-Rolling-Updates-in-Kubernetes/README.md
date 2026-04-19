# Day 51: Execute Rolling Updates in Kubernetes

## Objective

Execute a rolling update for this application, integrating the nginx:1.18 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.

```bash
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.18
```


