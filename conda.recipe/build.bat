@echo on

if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"

copy /Y "dfu-util.exe" "%LIBRARY_BIN%\dfu-util.exe"
if errorlevel 1 exit /b 1

copy /Y "dfu-prefix.exe" "%LIBRARY_BIN%\dfu-prefix.exe"
if errorlevel 1 exit /b 1

copy /Y "dfu-suffix.exe" "%LIBRARY_BIN%\dfu-suffix.exe"
if errorlevel 1 exit /b 1

if exist "libusb-1.0.dll" (
  copy /Y "libusb-1.0.dll" "%LIBRARY_BIN%\libusb-1.0.dll"
  if errorlevel 1 exit /b 1
)
