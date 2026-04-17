# Day 49: Deploy Applications with Kubernetes Deployments

## Objective
Create a deployment named httpd to deploy the application httpd using the image httpd:latest (ensure to specify the tag)

```bash
kubectl create deployment httpd --image=httpd:latest --dry-run=client -o yaml > httpd-deployment.yaml
kubectl apply -f httpd-deployment.yaml
```

