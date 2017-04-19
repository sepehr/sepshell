# Sepshell
Sepshell is zsh theme inspired by the good old "cobalt2" them with git bisecting, merging and rebasing modes.

## Requirements
- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) framework.
- Install [Powerline fonts](https://github.com/powerline/fonts) and select a Powerline font for your terminal.

## Installation
```shell
# NOTICE: Sepshell needs "robbyrussell/oh-my-zsh" in place.

# With vanilla zsh:
git clone https://github.com/sepehr/sepshell.git ~/.zsh-sepshell
echo 'source  ~/zsh-sepshell/sepshell.zsh-theme' >> ~/.zshrc

# With zplug:
zplug "sepehr/sepshell", use:"sepshell.zsh-theme", on:"robbyrussell/oh-my-zsh"

# With zgen:
zgen load sepehr/sepshell sepshell

# With antigen:
antigen theme sepehr/sepshell sepshell

# With antibody:
antibody bundle sepehr/sepshell

# With ZPM:
Plug sepehr/sepshell
source ~/.local/share/zpm/plugins/sepehr/sepshell.zsh-theme
```

## Screenshot
![Screenshot](http://i.imgur.com/t1WowE8.png)
