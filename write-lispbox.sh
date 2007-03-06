#!/bin/sh

echo "#!/bin/bash"

cat <<EOF
if [ "\${0:0:2}" = "./" ]; then
    export LISPBOX_HOME=\`pwd\`${LISPBOX_HOME_RELATIVE}
else
    export LISPBOX_HOME=\`dirname \$0\`${LISPBOX_HOME_RELATIVE}
fi
EOF

if [ ! -z "${SBCL_DIR}" ]; then
    cat <<EOF
export SBCL_HOME=\${LISPBOX_HOME}/${SBCL_DIR}/lib/sbcl
EOF
fi

if [ ! -z "${OPENMCL_DIR}" ]; then
    cat <<EOF
export CCL_DEFAULT_DIRECTORY=\${LISPBOX_HOME}/${OPENMCL_DIR}
EOF
fi

if [ ! -z "${LINUX}" ]; then
    cat <<EOF
export EMACSDATA=\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/etc/
export EMACSDOC=\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/etc/
export EMACSLOADPATH=\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/site-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/site-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/leim:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/toolbar:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/textmodes:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/progmodes:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/play:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/obsolete:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/net:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/mail:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/language:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/international:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/gnus:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/eshell:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/emulation:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/emacs-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/21.4/lisp/calendar


PATH=\$PATH:\${LISPBOX_HOME}/libexec/emacs/21.4/i686-pc-linux-gnu
EOF

fi

cat <<EOF
exec \${LISPBOX_HOME}/${EMACS_EXE} --no-init-file --no-site-file --eval='(progn (load "lispbox") (slime))'
EOF
