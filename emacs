;; 
;;  JARED EMACS INIT
;;
;;  NOTE: use this emacs25 build for osx:
;;  github.com/railwaycat/homebrew-emacsmacport 
;;
;;  Packages to install:
;;      * evil
;;      * helm
;;      * spaceline
;;      * linum-relative
;;      * monokai-theme
;;      * org-bullets
;;      * magit
;;      * evil-magit
;;      * babel
;;      * dired+ 
;;      * org-pdfview
;;      * web-mode
;;      * php-mode
;;      * yaml-mode
;;      * auto-indent-mode
;;      * projectile
;;      * helm-projectile
;;      * yasnippet
;;

(when (eq system-type 'darwin)
    ;; default Latin font
    (set-face-attribute 'default nil :family "Source Code Pro")
    
    ;; default font size (point * 10)
    (set-face-attribute 'default nil :height 130)
    
    ;; not sure if this needs to be here lol
    (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
    
    ;; auto complete on opt tab
    (global-set-key (kbd "<A-tab>") 'minibuffer-complete))

;; no menu bar
(tool-bar-mode -1)

;; default window 
;; (when window-system (set-frame-size (selected-frame) 150 37))
(setq default-frame-alist '((top . 20) (left . 20)))

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

;; maximize current buffer
(defun toggle-maximize-buffer () 
    "Maximize buffer"
    (interactive)
    (if (= 1 (length (window-list)))
            (jump-to-register '_) 
        (progn
            (window-configuration-to-register '_)
            (delete-other-windows))))
;; (global-set-key (kbd "C-c z") 'toggle-maximize-buffer)

;; org-mode code in code blocks
(setq org-src-fontify-natively t)

;; melpa 
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
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
(require 'spaceline-config)
(spaceline-spacemacs-theme) 

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

;; google this minor mode
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-x g") 'google-this-mode-submap)

;; desktop mode
(require 'desktop)
(desktop-save-mode 1)

;; reuse dired+ buffers
(require 'dired+)
(diredp-toggle-find-file-reuse-dir 1)

;; dired-jump
(require 'dired-x)

;; auto-indent-mode
(require 'auto-indent-mode)                                      
(setq auto-indent-on-visit-file t)
(setq auto-indent-untabify-on-visit-file t)
(setq auto-indent-assign-indent-level 4)
(setq auto-indent-mode-untabify-on-yank-or-paste t)
(auto-indent-mode t)

;; helm-projectile
;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile projectile auto-indent-mode yaml-mode dired+ ## web-mode pcomplete-extension babel google-this org-pdfview evil-magit git magit org-bullets helm-fuzzy-find helm-c-moccur evil-commentary php-mode spaceline monokai-theme linum-relative helm evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
