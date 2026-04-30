# Day 62: Manage Secrets in Kubernetes

## 🎯 task
1. We already have a secret key file ecommerce.txt under the /opt/ directory. Create a generic secret named ecommerce, it should contain the password/license-number present in ecommerce.txt file.

2. Also create a pod named secret-devops.

3. Configure pod's spec as container name should be secret-container-devops, image should be debian with latest tag (remember to mention the tag with image). Use sleep command for container so that it remains in running state. Consume the created secret and mount it under /opt/cluster within the container.


4. To verify you can exec into the container secret-container-devops, to check the secret key under the mounted path /opt/cluster. Before hitting the Check button please make sure pod/pods are in running state, also validation can take some time to complete so keep patience.

## 🧑‍💻 solution
```bash
# using the file ecommerce.txt with base64 encoded value of password/license-number
kubectl create secret generic ecommerce --from-file=/opt/ecommerce.txt

# creating a pod named secret-devops with container name secret-container-devops, image debian:latest and mounting the secret
kubectl run secret-devops --image=debian:latest --restart=Never --command -- sleep infinity

# patching the pod to mount the secret
kubectl patch pod secret-devops -p '{"spec":{"volumes":[{"name":"ecommerce","secret":{"secretName":"ecommerce"}}],"containers":[{"name":"secret-container-devops","volumeMounts":[{"name":"ecommerce","mountPath":"/opt/cluster"}]}]}}'
```

## create the pod by defining the yaml file
```yaml
# for pod definition
apiVersion: v1
kind: Pod
metadata:
  name: secret-devops
spec:
  containers:
  - name: secret-container-devops
    image: debian:latest
    command: ["sleep", "infinity"]
    volumeMounts:
    - name: ecommerce
      mountPath: /opt/cluster
  volumes:
  - name: ecommerce
    secret:
      secretName: ecommerce
```

## 🧑‍💻 verification
```bash
kubectl exec -it secret-devops -- cat /opt/cluster/ecommerce.txt
```
