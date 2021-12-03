(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq ido-enable-prefix t)
(ido-mode 1)

;; Line numbers + its colour
;;(set-face-foreground 'line-number-current-line "#FFFF00")
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Basic font settings
(set-frame-font "mono-13" nil t)

;; ESC key = quit outta prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(setq confirm-kill-emacs 'y-or-n-p)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs.d/saves/")))


;; Packages setup
;; MELPA repo
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Theme
(unless (package-installed-p 'kaolin-themes)
  (package-install 'kaolin-themes))
(require 'kaolin-themes)
(load-theme 'kaolin-aurora t)
;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

;; Undo tree
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(global-undo-tree-mode)


;; evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)

(require 'evil)

(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))
(when (require 'evil-collection nil t)
  (evil-collection-init))

(evil-mode 1)
(evil-set-undo-system 'undo-tree)

(evil-global-set-key 'normal (kbd "SPC b") 'ido-switch-buffer)
(evil-global-set-key 'normal (kbd "SPC TAB") 'ido-switch-buffer)
(evil-global-set-key 'normal (kbd "SPC f") 'ido-find-file)
(evil-global-set-key 'normal (kbd "SPC s") 'save-buffer)
(evil-global-set-key 'normal (kbd "SPC k") 'kill-this-buffer)
(evil-global-set-key 'normal (kbd "SPC K") 'kill-buffer)
(evil-global-set-key 'normal (kbd "SPC d") 'dired)
(evil-global-set-key 'normal (kbd "SPC e") 'eval-last-sexp)
(evil-global-set-key 'normal (kbd "SPC g") 'magit-status)
(evil-global-set-key 'normal (kbd "SPC x") 'smex)
(evil-global-set-key 'normal (kbd "SPC w") 'save-buffer)
(evil-global-set-key 'normal (kbd "SPC =") 'text-scale-adjust)
(evil-global-set-key 'normal (kbd "SPC -") 'text-scale-adjust)
(evil-global-set-key 'normal (kbd "SPC 1") 'delete-other-windows)
(evil-global-set-key 'normal (kbd "SPC 0") 'delete-window)
(evil-global-set-key 'normal (kbd "SPC 2") 'split-window-below)
(evil-global-set-key 'normal (kbd "SPC 3") 'split-window-right)
(evil-global-set-key 'normal (kbd "SPC r") 'recentf-open-files)
(evil-global-set-key 'normal (kbd "g c") 'comment-or-uncomment-region)


;; smex (enhanced ido)
(unless (package-installed-p 'smex)
  (package-install 'smex))
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; which-key (hotkey hinting)
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(require 'which-key)
(which-key-mode)

;; Multicursor
;; evil-multiedit
(unless (package-installed-p 'evil-multiedit)
  (package-install 'evil-multiedit))
(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

;; Magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Autocomplete
(unless (package-installed-p 'company)
  (package-install 'company))

(require 'company)
(company-mode)
(setq company-show-numbers t)
(setq company-tooltip-flip-when-above t)
(global-company-mode t)

;; Eldoc
(global-eldoc-mode t)

;; Autocomplete backends
;; Python
;;(unless (package-installed-p 'anaconda-mode)
  ;;(package-install 'anaconda-mode))
;;(add-hook 'python-mode-hook 'anaconda-mode)
;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;;(unless (package-installed-p 'company-anaconda)
  ;;(package-install 'company-anaconda))
;;(eval-after-load "company"
 ;;'(add-to-list 'company-backends 'company-anaconda))

;; Rust
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))

;; C
(setq c-default-style "k&r"
        c-basic-offset 4)
;; rexim/simpc-mode astyle setting
(defun astyle-buffer ()
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))
(evil-global-set-key 'normal (kbd "SPC F") 'astyle-buffer)
