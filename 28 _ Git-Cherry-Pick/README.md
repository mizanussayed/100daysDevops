# Day 28: Git Cherry Pick

## task:
The Nautilus application development team has been working on a project repository /opt/news.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with the DevOps team:

There are two branches in this repository, master and feature. One of the developers is working on the feature branch and their work is still in progress, however they want to merge one of the commits from the feature branch to the master branch, the message for the commit that needs to be merged into master is `Update info.txt`. Accomplish this task for them, also remember to push your changes eventually.

## Solution:
1. First, navigate to the repository directory:
```bash
cd /usr/src/kodekloudrepos
```
2. Fetch the latest changes from the remote repository:
```bash
git fetch origin
```
3. Check out the master branch:
```bash
git checkout master
```
4. Use the `git cherry-pick` command to apply the specific commit from the feature branch to the master branch. You can find the commit hash for the commit with the message "Update info.txt" by using the following command:
```bash
git log feature --grep="Update info.txt"
```

5. Once you have the commit hash, use the cherry-pick command to apply it to the master branch:
```bash
git cherry-pick <commit-hash>
```
6. After successfully cherry-picking the commit, push the changes to the remote repository:
```bash
git push origin master
```






