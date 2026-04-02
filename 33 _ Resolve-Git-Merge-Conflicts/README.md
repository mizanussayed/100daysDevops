# Day 33: Resolve Git Merge Conflicts

There is a production deployment planned for next week. The Nautilus DevOps team wants to test the deployment update and rollback on Dev environment first so that they can identify the risks in advance. Below you can find more details about the plan they want to execute.



Create a namespace datacenter. Create a deployment called httpd-deploy under this new namespace, It should have one container called httpd, use httpd:2.4.28 image and 3 replicas. The deployment should use RollingUpdate strategy with maxSurge=1, and maxUnavailable=2. Also create a NodePort type service named httpd-service and expose the deployment on nodePort: 30008.


Now upgrade the deployment to version httpd:2.4.43 using a rolling update.


Finally, once all pods are updated undo the recent update and roll back to the previous/original version.

1. Create Namespace
kubectl create namespace datacenter
2. Create Deployment (with RollingUpdate strategy)

You can either use a YAML file (recommended) or CLI.

Option A: YAML (best practice)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-deploy
  namespace: datacenter
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: httpd
        image: httpd:2.4.28
        ports:
        - containerPort: 80

Apply it:

kubectl apply -f deployment.yaml
3. Create NodePort Servicek
apiVersion: v1
kind: Service
metadata:
  name: httpd-service
  namespace: datacenter
spec:
  type: NodePort
  selector:
    app: httpd
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008

Apply:

kubectl apply -f service.yaml
4. Upgrade Deployment (Rolling Update)
kubectl set image deployment/httpd-deploy \
httpd=httpd:2.4.43 \
-n datacenter

Check rollout status:

kubectl rollout status deployment/httpd-deploy -n datacenter
5. Verify Updated Pods
kubectl get pods -n datacenter
6. Rollback to Previous Version
kubectl rollout undo deployment/httpd-deploy -n datacenter
7. Confirm Rollback
kubectl rollout status deployment/httpd-deploy -n datacenter
kubectl describe deployment httpd-deploy -n datacenter

