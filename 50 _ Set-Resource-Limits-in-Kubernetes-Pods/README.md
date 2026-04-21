# Day 50: Set Resource Limits in Kubernetes Pods

## 🎯 task
Create a pod named `httpd-pod` with a container named `httpd-container`. Use the httpd image with the `latest` tag (specify as httpd:latest). Set the following resource limits:

Requests: Memory: 15Mi, CPU: 100m

Limits: Memory: 20Mi, CPU: 100m

```bash
kubectl run httpd-pod --image=httpd:latest --dry-run=client -o yaml > httpd-pod.yaml
```
Edit the `httpd-pod.yaml` file to include the resource limits under the container specification:

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: httpd-pod
spec:
    containers:
    - name: httpd-container
      image: httpd:latest
      resources:
         requests:
            memory: "15Mi"
            cpu: "100m"
         limits:
            memory: "20Mi"
            cpu: "100m"
```


