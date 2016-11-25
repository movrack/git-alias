alias gs='git status'
alias gb='git branch'
alias gt='git show-branch -a'
alias ll="ls -la"

alias lg=lg2
alias lg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias lg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias lg3="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' --all"

#git_savePush [commit message]
function git_savePush() {
    git add .
    git commit -a -m "$1"
    git push
}

#git_update  [branch name]
#or 'git pull' looks faster on my PC
#https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/
function git_update() {
	git fetch origin
	git rebase -p origin/$1
}

#git_changeBranch [branch name]
function git_changeBranch() {
	git checkout $1
}

#git_createBranch [new branch name] [from branch]
function git_createBranch() {
	git checkout -b $1 $2
}


#git_closeFeatureBranch [cloned branch name]
function git_closeFeatureBranch_develop() {
	git pull origin develop
	git checkout develop 
	if git merge $1
	then
		git push
		git branch -d $1
	fi
}

#git_releaseBranch_master [issue/release branch name] [annotate] [tag name]
#e.g. "release-0.1"  0.1  "Initial public release"
function git_releaseBranch_master() {

	git checkout master
	git merge $1
	git push

	git tag -a $2 -m "$3" master
	git push --tags

	git checkout develop
	git merge $1
	git push

	if git merge $1
	then
		git branch -d $1
	fi
}

#edit [filename]
function edit(){
	"C:\Program Files\Sublime Text 3\sublime_text.exe" $1 &
}

