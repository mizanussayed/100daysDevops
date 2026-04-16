# Day 48: Deploy Pods in Kubernetes Cluster

## Objective
The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task to create a pod according to the details below:

1. Create a pod named pod-httpd using the httpd image with the latest tag. Ensure to specify the tag as httpd:latest.

2. Set the app label to httpd_app, and name the container as httpd-container.

## by cmd
```bash
kubectl run pod-httpd --image=httpd:latest --labels=app=httpd_app --dry-run=client -o yaml > pod.yaml
kubectl apply -f pod.yaml
kubectl get pod pod-httpd -o jsonpath='{.spec.containers[0].name}'
```