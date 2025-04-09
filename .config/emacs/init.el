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
(set-frame-font "Fantasque Sans Mono-13" nil t)

;; ESC key = quit outta prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)



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

;; evil
;; (unless (package-installed-p 'evil)
;;   (package-install 'evil))
;; 
;; (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;; (setq evil-want-keybinding nil)
;; (setq evil-want-C-u-scroll t)
;; 
;; (require 'evil)
;; 
;; (unless (package-installed-p 'evil-collection)
;;   (package-install 'evil-collection))
;; (when (require 'evil-collection nil t)
;;   (evil-collection-init))
;; 
;; (evil-mode 1)
;; 
;; (evil-global-set-key 'normal (kbd "SPC b") 'ido-switch-buffer)
;; (evil-global-set-key 'normal (kbd "SPC f") 'ido-find-file)
;; (evil-global-set-key 'normal (kbd "SPC s") 'save-buffer)
;; (evil-global-set-key 'normal (kbd "SPC k") 'kill-buffer)
;; (evil-global-set-key 'normal (kbd "SPC d") 'dired)
;; (evil-global-set-key 'normal (kbd "SPC e") 'eval-last-sexp)
;; (evil-global-set-key 'normal (kbd "SPC g") 'magit-status)
;; (evil-global-set-key 'normal (kbd "SPC =") 'text-scale-adjust)
;; (evil-global-set-key 'normal (kbd "SPC -") 'text-scale-adjust)
;; (evil-global-set-key 'normal (kbd "SPC 0") 'text-scale-adjust)


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


;; Magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Autocomplete
;;(unless (package-installed-p 'company)
  ;;(package-install 'company))

;;(require 'company)
;;(company-mode)
;;(setq company-show-numbers t)
;;(setq company-tooltip-flip-when-above t)
;;(global-company-mode t)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(which-key smex evil-collection evil kaolin-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
