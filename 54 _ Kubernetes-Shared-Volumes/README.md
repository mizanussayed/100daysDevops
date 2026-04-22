# Day 54: Kubernetes Shared Volumes

## 🎯 task
1. Create a pod named volume-share-datacenter.

2. For the first container, use image fedora with latest tag only and remember to mention the tag i.e fedora:latest, container should be named as volume-container-datacenter-1, and run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/ecommerce.

3. For the second container, use image fedora with the latest tag only and remember to mention the tag i.e fedora:latest, container should be named as volume-container-datacenter-2, and again run a sleep command for it so that it remains in running state. Volume volume-share should be mounted at path /tmp/cluster.

4. Volume name should be volume-share of type emptyDir.

5. After creating the pod, exec into the first container i.e volume-container-datacenter-1, and just for testing create a file ecommerce.txt with the content Welcome to xFusionCorp Industries under the mounted path of first container i.e /tmp/ecommerce.

6. The file ecommerce.txt should be present under the mounted path /tmp/cluster on the second container volume-container-datacenter-2 as well, since they are using a shared volume.

## 🧑‍💻 solution
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-datacenter
spec:
  containers:
    - name: volume-container-datacenter-1
      image: fedora:latest
      command: ["sleep", "infinity"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/ecommerce
    - name: volume-container-datacenter-2
      image: fedora:latest
      command: ["sleep", "infinity"]
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/cluster
  volumes:
    - name: volume-share
      emptyDir: {}
```

## 🧑‍💻 commands
```bash
# Create the pod
kubectl apply -f pod.yaml
# Exec into the first container and create the file
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-1 -- bash
echo "Welcome to xFusionCorp Industries" > /tmp/ecommerce/ecommerce.txt
# Check the file in the second container
kubectl exec -it volume-share-datacenter -c volume-container-datacenter-2 -- cat /tmp/cluster/ecommerce.txt
``` 