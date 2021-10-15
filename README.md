# Dotfiles
This repo holds the dotfiles based on my preferences. Suggestions and PRs are welcome.

## Getting Started
To get started, follow the following steps,
- Create a `.dotfiles` folder, which will be use to track your dotfiles
```shell
git init --bare $HOME/.dotfiles
```
- Create an alias `dotfiles` in .zshrc (or .bashrc) to make life easier
```shell
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
- Set git status to hide untracked files
```shell
dotfiles config --local status.showUntrackedFiles no
```

## Usage
Now use regular git commands such as.
```shell
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
# Create and add remote repo
dotfiles push
```

## Setup in New Machine
Make sure `git` is installed in system and then,
- Firstly, make sure source repository ignores the folder where cloning is done in order to avoid weird recursion problems
```shell
echo ".dotfiles" >> .gitignore
```
- Clone `dotfiles` repo
```shell
git clone --bare git@github.com:maharjanaman/dotfiles.git $HOME/.dotfiles
```
- Create an alias `dotfiles` in .zshrc (or .bashrc) to make life easier
```shell
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
- Checkout the actual content from the git repository to your $HOME
```shell
dotfiles checkout
```
> Note that if system already has some of the files there will be an error message. Either (1) delete them or (2) back them up somewhere else.
- Set git status to hide untracked files
```shell
dotfiles config --local status.showUntrackedFiles no
```
