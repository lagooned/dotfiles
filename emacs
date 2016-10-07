;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; jared engler emacs file ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; C-u for up in normal mode
(setq evil-want-C-u-scroll t)

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
;; bury *scratch* buffer instead of kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

; disable scroll bars
(scroll-bar-mode -1)

; enable upcase region
(put 'upcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'evil)
    (evil-mode 1)

(require 'powerline)
    (powerline-evil-vim-color-theme)

(require 'powerline-evil)

(require 'helm-config)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)

; relative line numbers
(require 'linum)
(require 'linum-relative)
    (linum-on)
    (linum-relative 1)
    (linum-relative-in-helm-p)
    (setq linum-relative-format " %3s   ")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces

 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#d3d7cf" :foreground "#2e3436" :box (:line-width -1 :style released-button) :height 1.0)))))


