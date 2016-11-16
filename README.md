# Sepshell
Sepshell is zsh theme forked from Taylor Otwell's old taybalt theme. It's inspired by "cobalt2".

## Requirements
- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) framework.
- Install [Powerline fonts](https://github.com/powerline/fonts) and select a Powerline font for your terminal.

## Installation
```shell
# With vanilla zsh:
git clone https://github.com/sepehr/sepshell.git ~/.zsh-sepshell
echo 'source  ~/zsh-sepshell/sepshell.zsh-theme' >> ~/.zshrc

# With zplug:
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "sepehr/sepshell", use:sepshell.zsh-theme
zplug load

# With zgen:
zgen load sepehr/sepshell sepshell
zgen save 

# With antigen:
antigen theme sepehr/sepshell sepshell
antigen apply

# With antibody:
antibody bundle sepehr/sepshell

# With ZPM:
Plug sepehr/sepshell
source ~/.local/share/zpm/plugins/sepehr/sepshell.zsh-theme
```

## Screenshot
![Screenshot](http://i.imgur.com/9FrW2iL.png)
sss
