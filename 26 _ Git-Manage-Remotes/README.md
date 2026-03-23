# Day 26: Git Manage Remotes

## task:
The xFusionCorp development team added updates to the project that is maintained under /opt/cluster.git repo and cloned under /usr/src/kodekloudrepos/cluster. Recently some changes were made on Git server that is hosted on Storage server in Stratos DC. The DevOps team added some new Git remotes, so we need to update remote on /usr/src/kodekloudrepos/cluster repository as per details mentioned below:


a. In /usr/src/kodekloudrepos/cluster repo add a new remote dev_cluster and point it to /opt/xfusioncorp_cluster.git repository.


b. There is a file /tmp/index.html on same server; copy this file to the repo and add/commit to master branch.


c. Finally push master branch to this new remote origin.


## solution:
```bash
# navigate to the repo
cd /usr/src/kodekloudrepos/cluster

# add a new remote dev_cluster and point it to /opt/xfusioncorp_cluster.git repository
git remote add dev_cluster /opt/xfusioncorp_cluster.git

# copy the file to the repo
cp /tmp/index.html .

# add and commit the file
git add index.html
git commit -m "Add index.html"

# push the master branch to the new remote origin
git push dev_cluster master
```