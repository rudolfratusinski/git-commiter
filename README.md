# git-commiter
Git branch-per-task commiter bash script

This script is made for branch-per-task workflow.

What it does:

git add -A
git commit -m (message)
git push origin (task branch)
git checkout (dev branch)
git fetch origin
git pull origin (dev branch)
git merge -m "Merge (task branch) into (dev branch)"
git fetch origin
git pull origin (dev branch)
git push origin (dev branch)
git checkout (task branch)


Please edit it first and change dev_branch to branch You want merge to (ex. dev-1.3.0) !

1. Place it in project root directory where .git resides.
2. Make it executable (chmod +x commiter.sh)
3. Run (./commiter.sh)
4. Follow instructions



Options:

-v --verbose
  Show info from git commands
