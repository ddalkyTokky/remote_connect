@echo off
setlocal enabledelayedexpansion

:connection_loop
cls
set /p "sftp=connect to sftp? Y/N: "
IF /I "!sftp!"=="exit" (
    exit
)
set /p "user=username: "
IF /I "!user!"=="exit" (
    exit
)
set /p "port=port: "
IF /I "!port!"=="exit" (
    exit
)
set /p "url=url: "
IF /I "!url!"=="exit" (
    exit
)
set /p "auth=login(1) pem(2): "
IF /I "!auth!"=="exit" (
    exit
)

IF "!auth!"=="1" (
    IF /I "!sftp!"=="y" (
        start cmd /k "sftp -P !port! !user!@!url!"
    )
    ssh -p !port! !user!@!url!
)
IF "!auth!"=="2" (
    IF /I "!sftp!"=="y" (
        start cmd /k "sftp -P !port! -i ../pem/!user!.pem !user!@!url!"
    )
    ssh -p !port! -i ../pem/!user!.pem !user!@!url!
)
cls
echo Connection closed
goto connection_loop
