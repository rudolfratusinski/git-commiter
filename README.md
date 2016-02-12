# git-commiter
Git branch-per-task commiter bash script

This script is made for branch-per-task workflow.

What it does:

1. git add -A
2. git commit -m (message)
3. git push origin (task branch)
4. git checkout (dev branch)
5. git fetch origin
6. git pull origin (dev branch)
7. git merge -m "Merge (task branch) into (dev branch)"
8. git fetch origin
9. git pull origin (dev branch)
10. git push origin (dev branch)
11. git checkout (task branch)


Please edit it first and change dev_branch to branch You want merge to (ex. dev-1.3.0) !

1. Place it in project root directory where .git resides.
2. Make it executable (chmod +x commiter.sh)
3. Run (./commiter.sh)
4. Follow instructions



Options:

-v --verbose
  Show info from git commands
