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
;;      * monokai
;;      * org-mode
;; 

; font
(when (eq system-type 'darwin)
    ;; default Latin font
    (set-face-attribute 'default nil :family "Source Code Pro")

    ;; default font size (point * 10)
    (set-face-attribute 'default nil :height 130)

    ;; not sure if this needs to be here lol
    (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
)

; no menu bar
(tool-bar-mode -1)

; default window size
(when window-system (set-frame-size (selected-frame) 150 37))

; no tabs
(setq-default indent-tabs-mode nil)

; no splash
(setq inhibit-splash-screen t)

; no scrollbars
(scroll-bar-mode -1)

; enable upcase region
(put 'upcase-region 'disabled nil)

; bury scratch buffer instead of kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
	(bury-buffer)
      ad-do-it)))

; auto-indents on put
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

; maximize current buffer
(defun toggle-maximize-buffer () 
    "Maximize buffer"
    (interactive)
    (if (= 1 (length (window-list)))
        (jump-to-register '_) 
    (progn
        (window-configuration-to-register '_)
        (delete-other-windows))))
; (global-set-key (kbd "C-c z") 'toggle-maximize-buffer)

; melpa 
(require 'package)
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
    (package-initialize)

; helm 
(require 'helm)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)

; evil mode
(setq evil-want-C-u-scroll t)
(require 'evil)
    (evil-mode 1)

; relative line numbers
(require 'linum-relative)
    (linum-relative-mode)
    (global-linum-mode)
    (setq linum-relative-format "%3s ")
    (setq linum-relative-current-symbol "")

; spaceline
(require 'spaceline-config)
    (spaceline-emacs-theme) 

; monokai
(load-theme 'monokai t)

