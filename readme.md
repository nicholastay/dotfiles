# dotfiles

My dotfiles. Probably bad to use, constant WIP for myself.

Using git bare repo.

I now use the Fedora 35 i3 spin.

Alternatively, if installing from a base Arch system, [NARB](https://github.com/nicholastay/narb) can be used to bootstrap this installation.

```
$ git clone --bare https://github.com/nicholastay/dotfiles.git ~/.dotfiles.git
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME config --local status.showUntrackedFiles no

# To add more files (once aliases loaded)
# May need to add to gitignore to not use -f (safety)
$ d a ~/.config/...

# Any other git operations
$ d ...

# To use texlive profile
$ sudo /opt/texlive-installer/install-tl -init-from-profile ~/.local/nex/texlive.profile
```
