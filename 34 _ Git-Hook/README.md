# Day 34: Git Hook

## 🎯 task
Set up a `post-update` hook so every push to `master` creates a release tag in this format:

`release-YYYY-MM-DD`

Example:
- If date is 2026-04-02, tag must be `release-2026-04-02`.

Also:
- Merge `feature` into `master`.
- Push changes.
- Test the hook at least once.

## Important Notes
- Run all commands as user `natasha`.
- The hook must be created in the remote repository (`/opt/beta.git/hooks`), not in the local clone.
- Because the hook creates an annotated tag (`git tag -a`), the remote bare repo must have `user.name` and `user.email` configured.

## Full Working Process

### 1) Switch to natasha
```bash
sudo su - natasha
```

### 2) Confirm local clone and remote target
```bash
cd /usr/src/kodekloudrepos/beta
git remote -v
```
Expected remote path: `/opt/beta.git`

### 3) Create the post-update hook on remote bare repo
```bash
cd /opt/beta.git/hooks
cat > post-update << 'EOF'
#!/bin/bash
set -euo pipefail

today="$(date +%F)"
tag="release-$today"

for ref in "$@"; do
    if [ "$ref" = "refs/heads/master" ]; then
        if ! git rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1; then
            commit="$(git rev-parse refs/heads/master)"
            git tag -a "$tag" -m "Release $today" "$commit"
        fi
    fi
done
EOF

chmod +x post-update
```

### 4) Configure Git identity in remote bare repo
```bash
git --git-dir=/opt/beta.git config user.name "natasha"
git --git-dir=/opt/beta.git config user.email "natasha@ststor01.local"
```

### 5) Merge feature into master in local clone
```bash
cd /usr/src/kodekloudrepos/beta
git checkout master
git merge feature
git push origin master
```

### 6) Trigger hook test (if no new commits remain)
If everything is already merged and push says up-to-date, create an empty commit to trigger the hook:
```bash
git commit --allow-empty -m "Trigger post-update hook"
git push origin master
```

### 7) Verify release tag on remote and local
```bash
git --git-dir=/opt/beta.git tag -l "release-*"

cd /usr/src/kodekloudrepos/beta
git fetch --tags
git tag -l "release-*"
```

Expected for this run:
- `release-2026-04-02`

## Common Issues and Fixes

### Issue 1: No tag created after push
Cause:
- Hook was created in local clone instead of `/opt/beta.git/hooks`.

Fix:
- Move/create hook in `/opt/beta.git/hooks/post-update` and make it executable.

### Issue 2: Remote shows "Committer identity unknown"
Cause:
- Hook runs `git tag -a`, which needs Git identity in remote bare repo.

Fix:
```bash
git --git-dir=/opt/beta.git config user.name "natasha"
git --git-dir=/opt/beta.git config user.email "natasha@ststor01.local"
```

### Issue 3: Local `git tag` shows nothing
Cause:
- Tag exists remotely but local clone has not fetched tags yet.

Fix:
```bash
git fetch --tags
git tag -l "release-*"
```

## Conclusion
The hook is correctly configured and tested. Pushing to `master` now creates a date-based release tag automatically.
