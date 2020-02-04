# dotfiles

My dotfiles. Probably bad to use, constant WIP for myself. Using GNU Stow.

If installing from a base Arch system, [NARB](https://github.com/nicholastay/narb) can be used to bootstrap this installation.

```
$ git clone git@github.com:nicholastay/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ stow [thing]

# To restore dconf settings
$ dconf load / < dconf.ini

# To use texlive profile
$ sudo /opt/texlive-installer/install-tl -init-from-profile texlive.profile

# When on a different system and changes were made on another
$ ./upgrade-dots
```
