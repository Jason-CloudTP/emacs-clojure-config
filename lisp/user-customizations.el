;This is the custom emacs config for user hellofunk, which adds features not included in the example-config from clojure-emacs.
;info: https://github.com/hellofunk/example-config

;anything you see below that uses require-package is downloaded automatically from Melpa and requires no manual installation of any .el files

;;;;;;;;;;;;;
;; Editing
;;;;;;;;;;;;;

;; Highlights matching parenthesis
;;(show-paren-mode 1)

;; Highlight current line
;; (global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
;; sometimes C-; doesn't work in terminals, so adding C-c ; as well
(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-c ;") 'toggle-comment-on-line)

;----------------------------------------------------------------------------
;VIM mode always on start.  Toggle between emacs and VIM modes with C-z
(require-package 'evil)
(evil-mode 1)
(setq scroll-conservatively 100)

; which-key provides key combination completion
(require-package 'which-key)
(which-key-mode t)

;turn off emacs alarms (those annoying beeps)
(setq ring-bell-function 'ignore)

;expand-region functionality is really great for lisp/clojure editing
;from https://github.com/magnars/expand-region.el
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;sets the auto-save directory to be other than project directories, so you aren't inundated with tons of backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;winner mode
;from: http://www.emacswiki.org/emacs/WinnerMode
(when (fboundp 'winner-mode)
      (winner-mode 1))

;adds color matching for open and closed parenthesis
;from https://github.com/Fanael/rainbow-delimiters
(require-package 'rainbow-delimiters)
;turns on this for default with clojure files
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;be kind to your eyes, solarize! hey, that rhymes!
;from https://github.com/bbatsov/solarized-emacs
;(require-package 'solarized-theme)
;(require 'solarized-light-theme)
;(require 'solarized-dark-theme)
;(provide 'solarized-theme)

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
;; (when (fboundp 'tool-bar-mode)
;;   (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/themes")
(add-to-list 'load-path "~/.emacs.d/lisp/themes")
(load-theme 'tomorrow-night-bright t)

;; increase font size for better readability
(set-face-attribute 'default nil :height 120)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
(setq initial-frame-alist '((top . 0) (left . 0) (width . 150) (height . 40)))

;use ido-mode, a must-have for quick emacs navigation
;from http://emacswiki.org/emacs/InteractivelyDoThings
;more about it: http://www.masteringemacs.org/article/introduction-to-ido-mode
(require 'ido)
(ido-mode t)

;smex brings the power of ido mode to your M-x mini-buffer, another way to supercharge your emacs navigation
;from https://github.com/nonsequitur/smex
(require-package 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

; because M-S-6 is awkward
(global-set-key (kbd "C-c q") 'join-line)

;use I-Buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;shortcut to launch a shell
(global-set-key (kbd "C-x C-m") 'shell)

;useful little tweak. press C-space once to start a mark, then C-space to end a mark. If you do this in succession, it will simply mark a particular point in a file. Then use C-u and repeat C-space to move back through your saved points.
(setq set-mark-command-repeat-pop t)

;turn off the emacs toolbar; we're coders, after all. when do we use a mouse?
(tool-bar-mode -1)

;turn off the scroll bars
(scroll-bar-mode -1)

;turn off the cursor blinking -- personally i find it distracting
(blink-cursor-mode 0)

;turn off text wrapping in the middle of a word
(global-visual-line-mode 1)

;set font size on startup
;my eyes are kinda bad so i prefer a larger font size
(set-face-attribute 'default nil :height 135)

;; Font size
(define-key global-map (kbd "C-c C-=") 'text-scale-increase)
(define-key global-map (kbd "C-c C--") 'text-scale-decrease)

;use shift + arrow keys to jump between windows
(windmove-default-keybindings)

;;these are simple keybindings i've always like to quickly make an emacs window taller, shorter, narrower or wider, without using the mouse
(defalias 'hellofunk/windowtaller  (read-kbd-macro "C-u 2 C-x ^"))
(global-set-key (kbd "C-q") 'hellofunk/windowtaller)
(defalias 'hellofunk/windowshorter (read-kbd-macro "C-u - 2 C-x ^"))
(global-set-key (kbd "C-z") 'hellofunk/windowshorter)
(defalias 'hellofunk/windowwider (read-kbd-macro "C-u - 2 C-x }"))
(global-set-key (kbd "C-\\") 'hellofunk/windowwider)
(defalias 'hellofunk/windownarrower (read-kbd-macro "C-u - 2 C-x {"))
(global-set-key (kbd "C-]") 'hellofunk/windownarrower)

;;ORG MODE
;;org mode is a great emacs feature for organization notes, outlines, and more. plenty of docs online about it
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;erc configurations, for using irc. if using this, change the username from to whatever you use
(setq erc-nick "your-irc-username")
;http://www.emacswiki.org/emacs/ErcLogging
;choose any directory on your computer for placing log files
;be mindful that some channels to do not promote irc logging, therefore don't post logs publicly without some knowledge about the manners of a channel
(setq erc-log-channels-directory "~/your-irc-saves/")
(setq erc-save-buffer-on-part t
      erc-save-queries-on-quit t
      erc-log-write-after-send t
      erc-log-mode t
      erc-autojoin-mode t
      erc-log-write-after-insert t
      erc-log-file-coding-system 'utf-8)
(setq erc-log-insert-log-on-open nil)
;choose your desired channels to automatically join here; anything can be added after the "#freenode.net" element
(setq erc-autojoin-channels-alist '(("freenode.net"  "#emacs")))
;hides annoying irc messages unrelated to actual chats
(setq erc-hide-list (quote ("JOIN" "PART" "QUIT" "NICK" "AWAY")))
(setq erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
(defun erc-columns ()
  (erc-fill-disable))
(add-hook 'erc-mode-hook 'erc-columns )

;adds a custom directory where some .el scripts are placed used in this config file. Note that if you have .el scripts that exist on Melpa, you don't need this directory. But I have an undo-tree script (configured below) not on Melpa, so this is how you do it:
;(add-to-list 'load-path (concat user-emacs-directory "hellofunk-config"))

;undo-tree
;from http://www.emacswiki.org/emacs/UndoTree
;script must exist in the hellofunk-config directory before proceeding (see above paragraph)
;(require 'undo-tree)
;(global-undo-tree-mode)

;see: http://www.emacswiki.org/emacs/EmacsForMacOS#toc26
(when (eq system-type 'darwin) ;; mac specific settings
  ;(setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'control)
  ;(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
)

