# dotfiles

My dotfiles. Probably bad to use, constant WIP for myself.

Using git bare repo.

If installing from a base Arch system, [NARB](https://github.com/nicholastay/narb) can be used to bootstrap this installation.

```
$ git clone --bare https://github.com/nicholastay/dotfiles.git ~/.dotfiles.git
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout

# To add more files (once aliases loaded)
$ dott ~/.config/...

# Any other git operations
$ dots ...

# To restore dconf settings
$ dconf load / < ~/.local/narb/dconf.ini

# To use texlive profile
$ sudo /opt/texlive-installer/install-tl -init-from-profile ~/.local/narb/texlive.profile
```
