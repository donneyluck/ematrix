;; init.el --- Ematrix core initialization file -*- lexical-binding: t; -*-

;; Copyright (C) 2023-2023  MachineSudio

;; Author: donney.luck@gmail.com

;; ___________               __         .__
;; \_   _____/ _____ _____ _/  |________|__|__  ___
;;  |    __)_ /     \\__  \\   __\_  __ \  \  \/  /
;;  |        \  Y Y  \/ __ \|  |  |  | \/  |>    <
;; /_______  /__|_|  (____  /__|  |__|  |__/__/\_ \
;;         \/      \/     \/                     \/
;;
;; MINIMALIST & LIGHTWEIGHT EMACS CONFIGURATION FRAMEWORK
;;                          donneyluck.github.io/ematrix


;;; Commentary:

;;; Code:

;; Run a profiling session if `$EMATRIX_BENCHMARK' is defined.
(when (getenv "EMATRIX_BENCHMARK")
  (let ((dir (concat (file-name-directory load-file-name) "elisp/benchmark-init/")))
    (if (not (file-exists-p (concat dir "benchmark-init.el")))
        (error "[Ematrix:Error] `benchmark-init' is not available, make sure you've run \"git submodule update --init\" inside MinEmacs' directory")
      (add-to-list 'load-path dir)
      (require 'benchmark-init)
      (benchmark-init/activate)

      (defun +benchmark-init--desactivate-and-show-h ()
        (benchmark-init/deactivate)
        (require 'benchmark-init-modes)
        (benchmark-init/show-durations-tree))

      (with-eval-after-load 'me-vars
        (add-hook 'minemacs-lazy-hook #'+benchmark-init--desactivate-and-show-h 99)))))
