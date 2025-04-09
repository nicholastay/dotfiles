```
# To load these iTerm 2 configs...
$ defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.local/ntay/darwin/iterm2-prefs"
$ defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```

## Acknowledgements

- Tomorrow Night colour scheme: https://github.com/chriskempson/tomorrow-theme/blob/master/iTerm2/Tomorrow%20Night.itermcolors
- Catppuccin colour schemes: https://github.com/catppuccin/iterm/tree/main/colors
- Kaolin Aurora scheme
	- Ported by me (Nicholas Tay)
	- Originally by: Ogden Webb - emacs theme https://github.com/ogdenwebb/emacs-kaolin-themes/tree/main
	- Notes:
		- Foreground fg2=white2
		- Background bg1=azure5
		- Bold white1
		- Links erin3
		- Selection region.bg=selection=bg4
		- Selection text region.fg=fg4=white4
		- Badge warning=orange1
		- Underline =Selection
		- Cursor white0
		- Cursor guide black3
		- Cursor text =background
		- Color0-15 - see kitty
