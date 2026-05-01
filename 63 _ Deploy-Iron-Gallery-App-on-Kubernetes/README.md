# Day 63: Deploy Iron Gallery App on Kubernetes

## 🎯 task
1. Create a namespace iron-namespace-datacenter

2. Create a deployment iron-gallery-deployment-datacenter for iron gallery under the same namespace you created.

- Labels run `iron-gallery`.

- Replicas count `1`.

- Selector's matchLabels run `iron-gallery`.

- Template labels run `iron-gallery` under metadata.

- The container named `iron-gallery-container-datacenter`, use kodekloud/irongallery:2.0 image ( use exact image name / tag ).

- Resources limits for memory `100Mi` and for CPU `50m`.

- First volumeMount name `config`, its mountPath `/usr/share/nginx/html/data`.

- Second volumeMount name `images`, its mountPath `/usr/share/nginx/html/uploads`.

- First volume name `config` and give it `emptyDir` and second volume name `images`, also give it `emptyDir`.

3. Create a deployment iron-db-deployment-datacenter for iron db under the same namespace.

- Labels db mariadb.

- Replicas count `1`.

- Selector's matchLabels db mariadb.

- Template labels db mariadb under metadata.

- The container name `iron-db-container-datacenter`, use kodekloud/irondb:2.0 image ( use exact image name / tag ).

- Define environment, set MYSQL_DATABASE its value database_blog, set MYSQL_ROOT_PASSWORD and MYSQL_PASSWORD value with some complex passwords for DB connections, and MYSQL_USER value any custom user ( except root ).

- Volume mount name `db` and its mountPath `/var/lib/mysql`. Volume name `db` and give it an emptyDir.

4. Create a service for iron db which named iron-db-service-datacenter under the same namespace. Configure spec as selector's db mariadb. Protocol TCP, port and targetPort 3306 and its type ClusterIP.

5. Create a service for iron gallery which named iron-gallery-service-datacenter under the same namespace. Configure spec as selector's run iron-gallery. Protocol TCP, port and targetPort 80, nodePort 32678 and its type NodePort.




