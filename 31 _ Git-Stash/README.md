# Day 31: Git Stash
## Task:
The Nautilus application development team was working on a git repository `/usr/src/kodekloudrepos/apps` present on Storage server in Stratos DC. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:

Look for the stashed changes under `/usr/src/kodekloudrepos/apps` git repository, and restore the stash with `stash@{1}` identifier. Further, commit and push your changes to the origin.

## Solution:
1. First, navigate to the git repository:
```bash
cd /usr/src/kodekloudrepos/apps
```
2. Check the list of stashes to confirm the presence of `stash@{1}`:
```bash
git stash list
```

3. Apply the stash with identifier `stash@{1}`:
```bash
git stash apply stash@{1}
```
4. After applying the stash, check the status of the repository to see the changes:
```bash
git status
```
5. Add the changes to the staging area:
```bash
git add .
```
6. Commit the changes with an appropriate commit message:
```bash
git commit -m "Restored changes from stash@{1}"
```
7. Finally, push the changes to the origin:
```bash
git push origin main
```



