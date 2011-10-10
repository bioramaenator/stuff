(add-to-list 'load-path "~/.emacs.d/")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(display-time)

(setenv "PATH" (concat (getenv "PATH") ":/opt/bin"))

(custom-set-variables
 '(c-basic-offset 4)
 '(c-label-minimum-indentation (quote set-from-style))
 '(c-strict-syntax-p t)
 '(c-syntactic-indentation t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(jabber-account-list (quote (("kudryashov@jabber.kmyard.ru" (:password . "lehf12rq") (:port . 5222) (:connection-type . ssl)))))
 '(version-control-system (quote SVN)))
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(show-paren-match ((((class color) (background light)) (:background "#bfe8df")))))


;; Чтобы не было вступительного сообщения
(setq inhibit-startup-message t)

;; Настройки скроллинга
(setq scroll-conservatively 50)
(setq scroll-margin 4)

;Перезагрузка окна методов после каждого сохранения
(setq imenu-auto-rescan 1)
;;-----------------------------------------------------------------------------

;Длинные строки всегда разбивать при отображении
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; Tabs
(setq-default indent-tabs-mode nil)

;; c++-mode
(setq c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))
(global-set-key (kbd "C-c C-j") 'compile)

;; kmsearch
(setenv "KMSEARCH" "/kmsearch/")
(setenv "KMSEARCH_ROOT" "/home/kudryashov/dev")

;;; Emacs/W3 Configuration
(setq load-path (cons "/usr/share/emacs/site-lisp" load-path))
(condition-case () (require 'w3-auto "w3-auto") (error nil))

;;; Erlang emacs-mode

(add-to-list 'load-path "/opt/lib/erlang/lib/tools-2.6.6.2/emacs/")
(require 'erlang-start)

(setq erlang-electric-commands '())
(setq erlang-root-dir "/opt/local/lib/erlang")
(add-to-list 'exec-path "/opt/local/lib/erlang/bin")
(setq erlang-man-root-dir "/opt/local/lib/erlang/man")

(defun my-erlang-mode-hook ()
        ;; when starting an Erlang shell in Emacs, default in the node name
        (setq inferior-erlang-machine-options '("-sname" "emacs"))
        ;; add Erlang functions to an imenu menu
        (imenu-add-to-menubar "imenu")
        ;; customize keys
        (local-set-key [return] 'newline-and-indent)
        )

;; Some Erlang customizations
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)


;;; Distel

(add-to-list 'load-path "~/.emacs.d/distel/elisp")
(require 'distel)
(distel-setup)

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
                                        (lambda ()
                                                ;; add some Distel bindings to the Erlang shell
                                                (dolist (spec distel-shell-keys)
                                                        (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; Flymake
(require 'erlang-flymake)

;; Wrangler

(add-to-list 'load-path "/usr/local/share/wrangler/elisp")
(require 'wrangler)


(defun date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d.%m.%Y")
            (format-time-string "%Y-%m-%d"))))
(defun timestamp ()
  (interactive)
  (insert (format-time-string "*** %Y-%m-%d %H:%M:%S ***")))

(global-set-key "\C-x\M-d" `timestamp)
