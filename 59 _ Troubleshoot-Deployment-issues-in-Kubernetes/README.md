# Day 59: Troubleshoot Deployment issues in Kubernetes

## 🎯 task
The deployment name is redis-deployment. The pods are not in running state right now, so please look into the issue and fix the same.

1. We already have a secret key file official.txt under the /opt/ directory. Create a generic secret named official, it should contain the password/license-number present in official.txt file.


2. Also create a pod named secret-xfusion.


3. Configure pod's spec as container name should be secret-container-xfusion, image should be debian with latest tag (remember to mention the tag with image). Use sleep command for container so that it remains in running state. Consume the created secret and mount it under /opt/demo within the container.


4. To verify you can exec into the container secret-container-xfusion, to check the secret key under the mounted path /opt/demo. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience.


## 🧑‍💻 solution

* Create a generic secret named official using the official.txt file:

```bash
base64 -w 0 /opt/official.txt | kubectl create secret generic official --from-literal=password=-
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: official
type: Opaque
data:
  official.txt: <BASE64_ENCODED_CONTENT>
---
apiVersion: v1
kind: Pod
metadata:
  name: secret-xfusion
spec:
  containers:
  - name: secret-container-xfusion
    image: debian:latest
    command: ["/bin/sh", "-c", "sleep 3600"]
    volumeMounts:
    - name: secret-volume
      mountPath: /opt/demo
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: official
```

## verification
1. Check the status of the pod & cat the secret key from the mounted path:

```bash
kubectl get pods
kubectl exec -it secret-xfusion -- cat /opt/demo/official.txt
```