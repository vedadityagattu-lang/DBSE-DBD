@echo off
cd /d "%~dp0"
if not exist "backend\.env" (
  echo Missing backend\.env. Configure the backend first or copy this upgrade into your configured DINE folder.
  pause
  exit /b 1
)
if exist "backend\.venv\Scripts\python.exe" (
  "backend\.venv\Scripts\python.exe" "scripts\update_menu.py"
) else (
  py -3.12 "scripts\update_menu.py"
)
if errorlevel 1 (
  echo Check that backend dependencies are installed and MySQL is running.
  pause
  exit /b 1
)
pause
