# Day 60: Persistent Volumes in Kubernetes

## 🎯 task
1. Create a PersistentVolume named as `pv-xfusion`. Configure the spec as storage class should be `manual`, set capacity to 3Gi, set access mode to `ReadWriteOnce`, volume type should be `hostPath` and set path to `/mnt/security` (this directory is already created, you might not be able to access it directly, so you need not to worry about it).

2. Create a PersistentVolumeClaim named as `pvc-xfusion`. Configure the spec as storage class should be `manual`, request 2Gi of the storage, set access mode to `ReadWriteOnce`.

3. Create a pod named as `pod-xfusion`, mount the persistent volume you created with claim name `pvc-xfusion` at document root of the web server, the container within the pod should be named as `container-xfusion` using image `httpd` with latest tag only (remember to mention the tag i.e `httpd:latest`).

4. Create a node port type service named `web-xfusion` using node port 30008 to expose the web server running within the pod.

## 🧑‍💻 solution
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-xfusion
spec:
  storageClassName: manual
  capacity:
    storage: 3Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/security
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-xfusion
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-xfusion
  labels:
    app: pod-xfusion   # ✅ important for Service
spec:
  containers:
    - name: container-xfusion
      image: httpd:latest
      volumeMounts:
        - name: web-content
          mountPath: /usr/local/apache2/htdocs/
  volumes:
    - name: web-content
      persistentVolumeClaim:
        claimName: pvc-xfusion
---
apiVersion: v1
kind: Service
metadata:
  name: web-xfusion
spec:
  type: NodePort
  selector:
    app: pod-xfusion   # ✅ matches Pod label
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
```