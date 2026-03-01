@echo on

set "OWNER=ionthedev"
set "REPO=dfu-util-hadron"
set "VERSION=%PKG_VERSION%"

if /I "%target_platform%"=="win-64" (
  set "ASSET=dfu-util-v%VERSION%-windows-x86_64.tar.gz"
) else (
  echo Unsupported target_platform: %target_platform%
  exit /b 1
)

set "URL=https://github.com/%OWNER%/%REPO%/releases/download/v%VERSION%/%ASSET%"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%URL%' -OutFile 'release.tar.gz'"
if errorlevel 1 exit /b 1

tar -xzf release.tar.gz
if errorlevel 1 exit /b 1

if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"

copy /Y "dfu-util.exe" "%LIBRARY_BIN%\dfu-util.exe"
if errorlevel 1 exit /b 1

copy /Y "dfu-prefix.exe" "%LIBRARY_BIN%\dfu-prefix.exe"
if errorlevel 1 exit /b 1

copy /Y "dfu-suffix.exe" "%LIBRARY_BIN%\dfu-suffix.exe"
if errorlevel 1 exit /b 1

for %%F in (*.dll) do (
  copy /Y "%%F" "%LIBRARY_BIN%\%%F"
  if errorlevel 1 exit /b 1
)
