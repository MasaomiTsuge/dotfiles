(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(ruby-insert-encoding-magic-comment nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq mac-command-key-is-meta t)

(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))


;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; global-set-key
(global-set-key [(control tab)] 'other-window)
(global-set-key (kbd "C-c /") 'comment-region)
(global-set-key (kbd "C-c _") 'comment-dwim)
(global-set-key (kbd "M-e") 'eshell)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-_") 'kmacro-call-macro)
(global-set-key (kbd "C-i") 'anything-imenu)
(global-set-key (kbd "C-c @") 'eval-buffer)
(global-set-key (kbd "C-:") 'call-last-kbd-macro)
(global-set-key (kbd "C-c >") 'indent-region)

;;; tab to space
(setq-default tab-width 2 indent-tabs-mode nil)
;; (setq-default show-trailing-whitespace t)
(add-hook 'font-lock-mode-hook
  (lambda ()
    (font-lock-add-keywords
      nil
      '(("\t" 0 'trailing-whitespace prepend)))))

;;; メニューバーを消す
(menu-bar-mode -1)
;;; ツールバーを消す
(tool-bar-mode -1)

;;; 対応する括弧を光らせる。
(show-paren-mode 1)


;;; 現在行を目立たせる
(global-hl-line-mode)

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; ;; auto-complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (global-auto-complete-mode t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; ruby インデント調整
(setq ruby-deep-indent-paren-style nil)

(require 'slim-mode)

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))


;; rainbow-mode: カラー
(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)

;; ignoramus
(require 'dired-x)
(require 'ignoramus)
(ignoramus-setup)

;; helm
(require 'helm-config)
(helm-mode 1)

(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogroup")
(global-set-key (kbd "M-s") 'helm-do-ag)

(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; migemo
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)


(require 'eshell-z)

(require 'hlinum)
(hlinum-activate)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; sqlf 
;; http://d.hatena.ne.jp/kitokitoki/20091129/p1
(defun sqlf (start end)
  "リージョンのSQLを整形する"
  (interactive "r")
  (let ((case-fold-search t))
    (let* ((s (buffer-substring-no-properties start end))
           (s (replace-regexp-in-string "\\(select \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(update \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(insert into \\)\\(fuga\\)\\(fuga\\)" "\n\\2\n  " s))
           (s (replace-regexp-in-string "\\(delete from \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(create table \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(alter table \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(drop constraint \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(from \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(exists \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(where \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(values \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(order by \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(group by \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(having \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(left join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(left outer join )\\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(right join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(right outer join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(inner join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(cross join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(union join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(and \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(or \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(any \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update restrict \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update cascade \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update set null \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update no action \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete restrict \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete cascade \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete set null \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete no action \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(,\\)" "\\1\n  " s)))
    (save-excursion
      (insert s)))))

(global-set-key (kbd "C-c f") 'sqlf)

;;sql-indent mode
(eval-after-load "sql"
  '(load-library "sql-indent"))


;;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)
