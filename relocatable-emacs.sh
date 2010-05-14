#!/bin/sh

#PWD
#SHELL

export EMACSDATA=${LISPBOX_HOME}/share/emacs/23.2/etc/

export EMACSDOC=${LISPBOX_HOME}/share/emacs/23.2/etc/

export EMACSLOADPATH=\
${LISPBOX_HOME}/share/emacs/23.2/site-lisp:\
${LISPBOX_HOME}/share/emacs/site-lisp:\
${LISPBOX_HOME}/share/emacs/23.2/leim:\
${LISPBOX_HOME}/share/emacs/23.2/lisp:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/toolbar:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/textmodes:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/progmodes:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/play:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/obsolete:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/net:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/mail:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/language:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/international:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/gnus:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/eshell:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/emulation:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/emacs-lisp:\
${LISPBOX_HOME}/share/emacs/23.2/lisp/calendar


PATH=$PATH:${LISPBOX_HOME}/libexec/emacs/23.2/i686-pc-linux-gnu


exec ./bin/emacs --no-init-file --no-site-file
