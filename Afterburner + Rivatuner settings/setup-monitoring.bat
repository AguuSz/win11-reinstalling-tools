@echo off
setlocal
title Setup Monitoring (MSI Afterburner + Rivatuner)

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permisos de administrador...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-monitoring.ps1"
set "PS_EXIT=%errorlevel%"

echo.
if not "%PS_EXIT%"=="0" (
    echo El script termino con errores ^(codigo %PS_EXIT%^).
)
pause
exit /b %PS_EXIT%
