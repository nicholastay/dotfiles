# dotfiles

My dotfiles. Probably bad to use, constant WIP for myself.

Using git bare repo.

I am on Fedora 41 with sway installed.

```
$ git clone --bare https://github.com/nicholastay/dotfiles.git ~/.dotfiles.git
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout
$ git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME config --local status.showUntrackedFiles no

# To add more files (once aliases loaded)
# May need to add to gitignore to not use -f (safety)
$ d a ~/.config/...

# Any other git operations
$ d ...
```

## Licence

`SPDX-License-Identifier: BSD-2-Clause`
