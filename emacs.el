;; jared emacs.el
; melpa 
(require 'package)
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
    (package-initialize)

; no tabs
(setq-default indent-tabs-mode nil)

; no splash
(setq inhibit-splash-screen t)

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

; helm 
(require 'helm)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)

; evil mode
(require 'evil)
    (evil-mode 1)
    (setq evil-want-C-u-scroll t)

; relative line numbers
(require 'linum-relative)
    (linum-relative-mode)
    (global-linum-mode)
    (setq linum-relative-format "%3s  ")
    (setq linum-relative-current-symbol "")
