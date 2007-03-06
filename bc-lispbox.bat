rem Only assign a value if none exists
if "%LISPBOX_HOME%"=="" goto nt
goto start

:nt
if NOT %OS%==Windows_NT goto win98
for %%i in ( "%CD%" ) do set LISPBOX_HOME=%%~si%
goto start

:win98
set LISPBOX_HOME=%CD%

:start
set EMACS=%LISPBOX_HOME%/emacs-21.3/bin/runemacs.exe
set TO_EVAL="(progn (load \"lispbox\") (slime))"

%EMACS% --no-init-file --no-site-file --eval=%TO_EVAL%