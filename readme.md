# dotfiles

My dotfiles. Probably bad to use, constant WIP for myself. Using GNU Stow.

Don't use the bootstrap files, even I haven't used them.

```
$ git clone git@github.com:nicholastay/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ stow [thing]

# To restore dconf settings
$ dconf load / < dconf.ini

# To use texlive profile
$ sudo /opt/texlive-installer/install-tl -init-from-profile texlive.profile
```
