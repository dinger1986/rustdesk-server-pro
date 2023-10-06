@echo off

REM Assign the value random password to the password variable
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set alfanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789

set rustdesk_pw=
FOR /L %%b IN (1, 1, 12) DO (
    SET /A rnd_num=!RANDOM! %% 62
    for %%c in (!rnd_num!) do set rustdesk_pw=!rustdesk_pw!!alfanum:~%%c,1!
)

REM Get your config string from your Web portal and Fill Below
set rustdesk_cfg="secure-string"

REM ############################### Please Do Not Edit Below This Line #########################################

if not exist C:\Temp\ md C:\Temp\
cd C:\Temp\

curl -L "https://github.com/rustdesk/rustdesk/releases/download/1.2.2/rustdesk-1.2.2-x86_64.exe" -o rustdesk.exe

rustdesk.exe --silent-install
timeout /t 20

cd "C:\Program Files\RustDesk\"
rustdesk.exe --install-service -wait -Verbose
timeout /t 20

for /f "delims=" %%i IN ('rustdesk.exe --get-id ^| more') DO set rustdesk_id=%%i

RustDesk.exe --config %rustdesk_cfg%

RustDesk.exe --password %rustdesk_pw%

echo ...............................................
REM Show the value of the ID Variable
echo RustDesk ID: %rustdesk_id%

REM Show the value of the Password Variable
echo Password: %rustdesk_pw%
echo ...............................................
