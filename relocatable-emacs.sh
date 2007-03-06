#!/bin/sh

#PWD
#SHELL

export EMACSDATA=${LISPBOX_HOME}/share/emacs/21.4/etc/

export EMACSDOC=${LISPBOX_HOME}/share/emacs/21.4/etc/

export EMACSLOADPATH=\
${LISPBOX_HOME}/share/emacs/21.4/site-lisp:\
${LISPBOX_HOME}/share/emacs/site-lisp:\
${LISPBOX_HOME}/share/emacs/21.4/leim:\
${LISPBOX_HOME}/share/emacs/21.4/lisp:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/toolbar:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/textmodes:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/progmodes:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/play:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/obsolete:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/net:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/mail:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/language:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/international:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/gnus:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/eshell:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/emulation:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/emacs-lisp:\
${LISPBOX_HOME}/share/emacs/21.4/lisp/calendar


PATH=$PATH:${LISPBOX_HOME}/libexec/emacs/21.4/i686-pc-linux-gnu


exec ./bin/emacs --no-init-file --no-site-file
