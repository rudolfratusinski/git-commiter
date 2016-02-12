#!/bin/bash

#Settings
dev_branch="dev-1.3.0"
ssh_username="user"
ssh_ip="111.111.111.111"
ssh_path="/usr/local/var/www"

#Branches
my_branch=$(git rev-parse --abbrev-ref HEAD 2>&1)
staged=$(git diff --name-only --cached 2>&1)

#Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
magenta=$(tput setaf 5)
reset=$(tput sgr0)

#Other
verbose=false

for i in "$@"
do
case $i in
    -v|--verbose)
      verbose=true
    ;;
    *)
    ;;
esac
done

echo "Type the$magenta commit$reset message:"
read commit_message
read -p "Your task branch is$magenta $my_branch$reset, dev branch is $magenta $dev_branch$reset and commit message is$magenta $commit_message $reset. Do You want to continue ? [y/n] " choice

if [[ $choice =~ ^[Yy]$ ]]
then


  if $verbose
  then

    git add -A &&
    # Commit files with message
    git commit -m "$commit_message" &&
    # Push files to my branch
    git push origin $my_branch &&
    # Checkout DEV branch
    git checkout $dev_branch &&
    # Pull changes from DEV branch to get fresh changes
    git fetch origin
    git pull origin $dev_branch &&
    # Merge my branch to DEV
    git merge -m "Merge '$my_branch' into $dev_branch" $my_branch
    # Pull changes once more to be sure our push wont fail (things change pretty fast on dev here)
    git fetch origin &&
    git pull origin $dev_branch &&
    # Push it hard!
    git push origin $dev_branch &&
    # Checkout my branch again and continue.
    git checkout $my_branch
    #Pull dev branch on remote server
    ssh $ssh_username@$ssh_ip 'cd '"$ssh_path"' && git pull'

  else
    # Stage files to index
    git add -A &> /dev/null &&
      echo $green
      echo "Staged files:"
      echo $magenta $(git diff --name-only --cached)
      echo ""
      echo $reset


    # Commit files with message
    git commit -m "$commit_message" &> /dev/null &&
      echo "Commiting files with message $magenta$commit_message $reset..."

    # Push files to my branch
    git push origin $my_branch &> /dev/null &&
      echo "Pushing to $magenta$my_branch $reset..."

    # Checkout DEV branch
    git checkout $dev_branch &> /dev/null &&
      echo "Checking out $magenta$dev_branch $reset..."

    # Pull changes from DEV branch to get fresh changes
    git fetch origin &> /dev/null
    git pull origin $dev_branch &> /dev/null &&
      echo "Pulling $magenta$dev_branch $reset..."

    # Merge my branch to DEV
    git merge -m "Merge '$my_branch' into $dev_branch" $my_branch &> /dev/null
      echo "Merging $magenta$my_branch$reset into $magenta$dev_branch $reset..."

    # Pull changes once more to be sure our push wont fail (things change pretty fast on dev here)
    git fetch origin &> /dev/null &&
    git pull origin $dev_branch &> /dev/null &&
        echo "Pulling $magenta$dev_branch $reset..."

    # Push it hard!
    git push origin $dev_branch &> /dev/null &&
      echo "Pushing $magenta$dev_branch $reset..."

    # Checkout my branch again and continue.
    git checkout $my_branch &> /dev/null &&
      echo "Checking out $magenta$my_branch $reset..."

    #Pull dev branch on remote server
    ssh $ssh_username@$ssh_ip 'cd '"$ssh_path"' && git pull' &> /dev/null &&
      echo "Pulling $magenta$dev_branch $reset on remote server ..."
  fi


echo $magenta
echo "Finished!$reset"
else
    exit 0
fi
