# Day 61: Init Containers in Kubernetes

## 🎯 task

1. Create a Deployment named as ic-deploy-datacenter.


2. Configure spec as replicas should be 1, labels app should be ic-datacenter, template's metadata labels app should be the same ic-datacenter.


3. The initContainers should be named as ic-msg-datacenter, use image debian with latest tag and use command '/bin/bash', '-c' and 'echo Init Done - Welcome to xFusionCorp Industries > /ic/news'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic.


4. Main container should be named as ic-main-datacenter, use image debian with latest tag and use command '/bin/bash', '-c' and 'while true; do cat /ic/news; sleep 5; done'. The volume mount should be named as ic-volume-datacenter and mount path should be /ic.


5. Volume to be named as ic-volume-datacenter and it should be an emptyDir type.

## 🧑‍💻 solution

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ic-deploy-datacenter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ic-datacenter
  template:
    metadata:
      labels:
        app: ic-datacenter
    spec:
      initContainers:
        - name: ic-msg-datacenter
          image: debian:latest
          command: ['/bin/bash', '-c', 'echo Init Done - Welcome to xFusionCorp Industries > /ic/news']
          volumeMounts:
            - name: ic-volume-datacenter
              mountPath: /ic
      containers:
        - name: ic-main-datacenter
          image: debian:latest
          command: ['/bin/bash', '-c', 'while true; do cat /ic/news; sleep 5; done']
          volumeMounts:
            - name: ic-volume-datacenter
              mountPath: /ic
      volumes:
        - name: ic-volume-datacenter
          emptyDir: {}

```


