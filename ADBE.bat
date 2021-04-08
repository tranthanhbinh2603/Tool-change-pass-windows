@shift /0
@echo off
title Thay doi nhanh mat khau Windows by TungZone.
color 0A
cls
:check_Permissions
echo. Tool thay doi nhanh mat khau Windows by TungZone.
echo. Hoat dong tot voi XP/Vista/7/8/8.1/10/LTSB/LTSC/Longhorn/Server
echo.
echo. Dang kiem tra tool nay da chay vs quyen Administrator hay chua??. . .
    fsutil dirty query %SYSTEMDRIVE% >nul
    if %errorLevel% NEQ 0 (
        Echo Quyen Quan Tri Vien - Administrator chua duoc kich hoat.
        Echo That bai: Vui long chay voi quyen Administrator
        goto :EnableAdministrator
) 
echo. Thanh cong: Quyen Quan Tri Vien - Administrator da duoc kich hoat.
goto :ChangePass

:EnableAdministrator
echo.
choice /c YN /n /m " Ban dong y kich hoat quyen Administrator chu? (Yes/No): "
if %errorlevel% EQU 1 goto :GetAdministrator
if %errorlevel% EQU 2 goto :exit

:GetAdministrator
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
	echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs" &	exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
cls
goto :ChangePass


:ChangePass
set Status=0
echo.
echo. Ban dang dang nhap bang tai khoan ten: %username%
set /p pa="Vui long nhap mat khau moi cua ban: "
echo Dang thay doi mat khau...
net user %username% %pa% >nul 2>&1 | findstr "successfully">nul
if "%ERRORLEVEL%"=="0"  ECHO That Bai. > nul && set Status=That Bai.
if "%ERRORLEVEL%"=="1"  ECHO Thanh Cong. > nul && set Status=Thanh Cong.
echo.
echo Trang Thai Thay Doi: %Status%%
echo.
echo. Bam phim bat ky de thoat.
pause>nul
:exit
exit /b

