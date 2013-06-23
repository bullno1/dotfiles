setlocal
set DIR=%~dp0
call :link .vimrc %USERPROFILE%\.vimrc 

goto :eof

:link
del %2
mklink %2 %DIR%%1
goto :eof
