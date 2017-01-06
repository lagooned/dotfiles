;;
;;  JARED EMACS INIT
;;
;;  * evil
;;  * evil-surround
;;  * evil-commentary
;;  * helm
;;  * spaceline
;;  * linum-relative
;;  * monokai-theme
;;  * org-bullets
;;  * magit
;;  * evil-magit
;;  * babel
;;  * dired+
;;  * diredx
;;  * org-pdfview
;;  * web-mode
;;  * php-mode
;;  * yaml-mode
;;  * auto-indent-mode
;;  * projectile
;;  * helm-projectile
;;  * yasnippet
;;  * auto-complete
;;  * lorem-ipsum
;;  * engine-mode
;;

(when (eq system-type 'darwin)
    ;;
    ;; NOTE: use this emacs25 build for osx:
    ;; github.com/railwaycat/homebrew-emacsmacport
    ;;
    ;; default Latin font
    (set-face-attribute 'default nil :family "Source Code Pro")
    ;; default font size (point * 10)
    (set-face-attribute 'default nil :height 130)
    ;; suppress warnings at startup
    (setq warning-minimum-level :emergency)) 

;; no menu bar
(tool-bar-mode -1)

;; no tabs
(setq-default indent-tabs-mode nil)

;; no splash
(setq inhibit-splash-screen t)

;; no scrollbars
(scroll-bar-mode -1)

;; enable upcase region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; backwards 'other window'
(global-set-key (kbd "C-x O") 'previous-multiframe-window)

;; bury scratch buffer instead of kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
    (let ((buffer-to-kill (ad-get-arg 0)))
        (if (equal buffer-to-kill "*scratch*")
                (bury-buffer)
            ad-do-it)))

;; org-mode code in code blocks
(setq org-src-fontify-natively t)

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24) (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; relative line numbers
(require 'linum-relative)
(linum-relative-mode)
(global-linum-mode)
(setq linum-relative-format "%3s ")
(setq linum-relative-current-symbol "")

;; helm
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
(require 'evil-commentary)
(evil-mode 1)
(evil-commentary-mode)

;; spaceline
;; (setq powerline-default-separator 'slant)
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)

;; org bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; monokai
(setq monokai-height-plus-1 1.0
      monokai-height-plus-2 1.0
      monokai-height-plus-3 1.0
      monokai-height-plus-4 1.0
      monokai-height-minus-1 1.0)
(setq monokai-use-variable-pitch nil)
(load-theme 'monokai t)

;; desktop mode
(require 'desktop)
(desktop-save-mode 1)

;; reuse dired+ buffers
(require 'dired+)
(diredp-toggle-find-file-reuse-dir 1)
(define-key dired-mode-map "c" 'find-file)

;; dired-jump
(require 'dired-x)

;; auto-indent-mode
(require 'auto-indent-mode)
(setq auto-indent-on-visit-file t)
(setq auto-indent-untabify-on-visit-file t)
(setq auto-indent-assign-indent-level 4)
;; (setq auto-indent-mode-untabify-on-yank-or-paste t)
(auto-indent-global-mode t)

;; auto complete
(require 'auto-complete)
(global-auto-complete-mode)

;; helm-projectile
(require 'helm-projectile)
(helm-projectile-on)

;; yasnippit
(require 'yasnippet)
(yas-global-mode 1)

;; projectile
(require 'projectile)
(projectile-global-mode)

;; lorem-ipsum
(require 'lorem-ipsum)
(lorem-ipsum-use-default-bindings)

;; emmit-mode 
(require 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode) 
(add-hook 'web-mode-hook 'emmet-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (emmet-mode engine-mode lorem-ipsum try groovy-mode auto-complete helm-projectile projectile auto-indent-mode yaml-mode dired+ ## web-mode pcomplete-extension babel org-pdfview evil-magit git magit org-bullets helm-fuzzy-find helm-c-moccur evil-commentary php-mode spaceline monokai-theme linum-relative helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
