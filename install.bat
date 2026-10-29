@echo off
chcp 65001 >nul
echo [HOI4-DXVK] Installing DXVK Vulkan wrapper for Hearts of Iron IV...

set TARGET_DIR=..
if exist "%TARGET_DIR%\hoi4.exe" (
    echo Target HOI4 directory detected: %TARGET_DIR%
) else (
    set TARGET_DIR=.
    if not exist "%TARGET_DIR%\hoi4.exe" (
        echo [ERROR] Could not find hoi4.exe in current or parent directory.
        echo Please place this folder inside your Hearts of Iron IV game directory and run again.
        pause
        exit /b 1
    )
)

copy /y "d3d11.dll" "%TARGET_DIR%\"
copy /y "dxgi.dll" "%TARGET_DIR%\"
copy /y "dxvk.conf" "%TARGET_DIR%\"

echo [SUCCESS] DXVK successfully installed to Hearts of Iron IV!
echo You can now launch the game via Steam or Paradox Launcher.
pause
