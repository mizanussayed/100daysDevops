# Day 27: Git Revert Some Changes

## Task Description 
The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/demo present on Storage server in Stratos DC. However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo HEAD to last commit. Below are more details about the task:


In /usr/src/kodekloudrepos/demo git repository, revert the latest commit ( HEAD ) to the previous commit (JFYI the previous commit hash should be with initial commit message ).


Use revert demo message (please use all small letters for commit message) for the new revert commit.


## Steps Followed

1. Navigate to repository
`cd /usr/src/kodekloudrepos/demo`

2. Verify commit history
`git log --oneline`

3. Revert the latest commit (HEAD)
`git revert HEAD`
This creates a new commit that undoes the latest changes.

4. Commit with required message
`git commit -m "revert demo message"`


### Verification
Check commit history
`git log --oneline`

### Expected result:
A new commit with message revert demo message
Previous commits remain intact
Working directory reflects initial commit state

### Key Concept
`git revert` does NOT delete commits
It creates a new commit that reverses changes from the latest commit
Safe method for production environments

### Final Outcome
HEAD is updated with a revert commit
Repository state matches the previous commit (initial commit state)
Commit history remains preserved

