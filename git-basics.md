To stage new, modified or deleted files:
```
git add -A
```

To stage new and modified files:
```
git add .
```

To stage modified and deleted files:
```
git add -u
```

To stage new and modified files:
```
git add *
```

Deletes the file from your working directory and stages the deletion.
```
git rm [file]
```

Git commit
```
git commit -m "your text"
```

Edit a commit message
```
git commit --amend -m "New message"
```

Add and commit - Not recommended for beginners.
```
git commit -am "message"
```

Throw away all you uncommitted changes
```
git reset --hard
```

Unstages the file, but it preserves the file contents.
```
git reset [file]
```

Undoes all the commits after the specified commit and preserves the changes locally.
```
git reset [commit-id]
```

Remove a file from git without removing it from computer
Sometime using “git add” command you might end up adding files that you didn’t want to add.
If you are not careful during a “git add”, you may end up adding files that you didn’t want to commit. You should remove the staged version of the file, and then add the file to .gitignore to avoid making the same mistake a second time:
```
git reset file_name
echo filename >> .gitignore
```

git config
```
git config -global user.name "[name]"
git config -global user.email "[email address]"
```


This command shows the differences between the files in the staging area and the latest version present.
```
git diff –staged
```

Switch from one branch to another.
```
git checkout [branch name]
```

Creates a new branch and also switches to it.
```
git checkout -b [branch name]
```

Temporarily stores all the modified tracked files.
```
git stash save
```

Restores the most recently stashed files.
```
git stash pop
```

Lists all stashed changesets.
```
git stash list
```

Discards the most recently stashed changeset.
```
git stash drop
```

