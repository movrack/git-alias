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

	if [ -z "$1" ]
	then
		echo "You have to give a commit message."
	else
		git add .
    	git commit -a -m "$1"
    	git push
	fi

}

#git_update  [branch name]
#or 'git pull' looks faster on my PC
#https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/
function git_update() {

	if [ -z "$1" ]
	then
		echo "You have the branch name (current) to update."
	else
		git fetch origin
		git rebase -p origin/$1
	fi

}

#git_changeBranch [branch name]
function git_changeBranch() {

	if [ -z "$1" ]
	then
		echo "You have to give the branch name where we should switch."
	else
		git checkout $1
	fi
	
}

#git_createBranch [new branch name] [from branch]
function git_createBranch() {
	if [ -z "$1" ]
	then
		echo "You have to give the new branch name."
	else
		git checkout -b $1 $2
	fi
}


#git_closeFeatureBranch [cloned branch name]
function git_closeFeatureBranch_develop() {

	if [ -z "$1" ]
	then
		echo "You have to give the cloned (current) branch name."
	else
		git pull origin develop
		git checkout develop 
		if git merge $1
		then
			git push
			git branch -d $1
		fi
	fi
	
}

#git_releaseBranch_master [release branch name] [annotate] [tag name]
#e.g. "release-0.1"  0.1  "Initial public release"
function git_releaseBranch_master() {


	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ];
	then
		echo "You have to give the release branch name, the tag id and the tag name."
	else
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
	fi

}

#git_releaseBranch_master [issue branch name] 
function git_hotFix_master() {
	if [ -z "$1" ]
	then
		echo "You have to give the issue branch name."
	else
		git checkout master
		git merge $1
		git push

		git checkout develop
		git merge $1
		git push

		if git merge $1
		then
			git branch -d $1
		fi
	fi
}

#edit [filename]
function edit(){
	"C:\Program Files\Sublime Text 3\sublime_text.exe" $1 &
}

