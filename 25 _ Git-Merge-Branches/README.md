# Day 25: Git Merge Branches

## task:
The Nautilus application development team has been working on a project repository /opt/cluster.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:

- Create a new branch `nautilus` in /usr/src/kodekloudrepos/cluster repo from master
- copy the /tmp/index.html file (present on storage server itself) into the repo.
- add/commit this file in the new branch and merge back that branch into master branch.
- push the changes to the origin for both of the branches.


## solution:
```bash
# navigate to the repo
cd /usr/src/kodekloudrepos/cluster

# create a new branch nautilus from master
git checkout -b nautilus master

# copy the /tmp/index.html file into the repo
cp /tmp/index.html .

# add the file to the staging area
git add index.html

# commit the changes
git commit -m "Add index.html file"

# switch back to the master branch
git checkout master

# merge the nautilus branch into master
git merge nautilus

# push the changes to the origin
git push origin master
git push origin nautilus
```