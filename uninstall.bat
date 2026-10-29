@echo off
chcp 65001 >nul
echo [HOI4-DXVK] Reverting Hearts of Iron IV to native DirectX 11...

set TARGET_DIR=..
if exist "%TARGET_DIR%\hoi4.exe" (
    echo Target HOI4 directory detected: %TARGET_DIR%
) else (
    set TARGET_DIR=.
)

if exist "%TARGET_DIR%\d3d11.dll" del "%TARGET_DIR%\d3d11.dll"
if exist "%TARGET_DIR%\dxgi.dll" del "%TARGET_DIR%\dxgi.dll"
if exist "%TARGET_DIR%\dxvk.conf" del "%TARGET_DIR%\dxvk.conf"
if exist "%TARGET_DIR%\hoi4.dxvk-cache" del "%TARGET_DIR%\hoi4.dxvk-cache"
if exist "%TARGET_DIR%\hoi4_d3d11.log" del "%TARGET_DIR%\hoi4_d3d11.log"
if exist "%TARGET_DIR%\hoi4_dxgi.log" del "%TARGET_DIR%\hoi4_dxgi.log"

echo [SUCCESS] DXVK files removed. Game reverted to native Direct3D 11.
pause
