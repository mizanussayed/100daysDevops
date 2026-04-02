# Real-World Git Hook Example

## Scenario
A team hosts a central bare repository at `/srv/git/app.git`.
Every push to `main` should:
- create a release tag with date and short commit id,
- write deployment logs,
- trigger a deployment script.

This example uses a `post-receive` hook on the central bare repository.

## Why post-receive?
- It runs on the server after refs are updated.
- It is good for CI/CD triggers, release tagging, notifications, and audit logs.
- It should not reject pushes (use `pre-receive` or `update` for validation/rejection).

## Repository Layout
- Bare remote: `/srv/git/app.git`
- Hook file: `/srv/git/app.git/hooks/post-receive`
- Deployment script: `/usr/local/bin/deploy_app.sh`
- Log file: `/var/log/git-hooks/app-deploy.log`

## 1) Create the Hook

```bash
sudo mkdir -p /var/log/git-hooks
sudo touch /var/log/git-hooks/app-deploy.log
sudo chown git:git /var/log/git-hooks/app-deploy.log

sudo -u git tee /srv/git/app.git/hooks/post-receive > /dev/null << 'EOF'
#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/git-hooks/app-deploy.log"
REPO_DIR="/srv/git/app.git"
DEPLOY_SCRIPT="/usr/local/bin/deploy_app.sh"

while read oldrev newrev refname; do
  if [ "$refname" = "refs/heads/main" ]; then
    ts="$(date +%F_%T)"
    short_sha="$(git --git-dir="$REPO_DIR" rev-parse --short "$newrev")"
    tag="release-$(date +%F)-$short_sha"

    {
      echo "[$ts] main updated: $oldrev -> $newrev"

      # Create annotated release tag if missing.
      if ! git --git-dir="$REPO_DIR" rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1; then
        git --git-dir="$REPO_DIR" tag -a "$tag" -m "Automated release $tag" "$newrev"
        echo "[$ts] created tag: $tag"
      else
        echo "[$ts] tag already exists: $tag"
      fi

      # Deploy the exact pushed commit.
      "$DEPLOY_SCRIPT" "$newrev"
      echo "[$ts] deployment complete for $newrev"
    } >> "$LOG_FILE" 2>&1
  fi
done
EOF

sudo chmod +x /srv/git/app.git/hooks/post-receive
```

## 2) Configure Git Identity for Tag Creation

Annotated tags require identity in the server-side repository context.

```bash
sudo -u git git --git-dir=/srv/git/app.git config user.name "git-release-bot"
sudo -u git git --git-dir=/srv/git/app.git config user.email "git-release-bot@example.com"
```

## 3) Example Deployment Script

```bash
sudo tee /usr/local/bin/deploy_app.sh > /dev/null << 'EOF'
#!/bin/bash
set -euo pipefail

COMMIT_SHA="$1"
WORK_TREE="/srv/apps/app"
GIT_DIR="/srv/git/app.git"

mkdir -p "$WORK_TREE"
git --work-tree="$WORK_TREE" --git-dir="$GIT_DIR" checkout -f "$COMMIT_SHA"

# Place real deployment steps here:
# - install dependencies
# - run migrations
# - restart service
EOF

sudo chmod +x /usr/local/bin/deploy_app.sh
```

## 4) Test End-to-End

From a developer clone:

```bash
git checkout main
echo "release test" >> RELEASE_TEST.txt
git add RELEASE_TEST.txt
git commit -m "Test server hook deployment"
git push origin main
```

Validate on server:

```bash
sudo -u git git --git-dir=/srv/git/app.git tag -l "release-*"
sudo tail -n 50 /var/log/git-hooks/app-deploy.log
```

## Operational Best Practices
- Keep hook scripts idempotent (safe to run multiple times).
- Log all actions with timestamps and commit ids.
- Use absolute paths in hooks.
- Keep hooks fast; hand off long jobs to a queue/CI worker if needed.
- Use file locking if parallel pushes can race on shared resources.
- Never store secrets in hook scripts.

## Common Failures
- Hook not running: missing execute permission.
- No tag created: missing `user.name` and `user.email` in bare repo.
- Works manually but not via push: wrong path assumptions in hook environment.
- Partial deploys: script is not atomic or not fail-fast.

## Safer Extensions
- Add branch protection checks in `pre-receive`.
- Add Slack/Teams notification after deploy.
- Add rollback command tied to previous release tags.
