# Git Command Reference for GitLab

## Personal Feature Branch

```bash
git fetch origin
git rebase origin/dev/BRANCH
git push --force-with-lease origin dev/laan
```

## Shared Feature Branch

```bash
git add .
git commit -m "feat: MESSAGE"
git push origin dev/laan
git fetch origin
git merge origin/dev/BRANCH
git push origin dev/laan
```

## Push Local Branches

```bash
git push -u origin dev/BRANCH
```

## Fetch, rebase, and push:

```bash
git fetch origin
git rebase origin/main
git push --force-with-lease origin dev/BRANCH
```

## Undo Add

```bash
git restore --staged .
```

## Set-URL Origin

```bash
git remote set-url origin git@gitlab-laan:NathanLaan/REPO
```

