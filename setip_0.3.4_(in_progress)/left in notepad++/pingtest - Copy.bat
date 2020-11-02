@echo off
setlocal enabledelayedexpansion
::just a sample adapter here:
set "adapter=LAN"
set adapterfound=false
echo Network Connection Test
for /f "usebackq tokens=2 delims=:" %%f in ("%systemipconfig.exe /all") do (
    set "item=%%f"
    if /i "!item!"=="!adapter!" (
        set adapterfound=true
    ) else if not "!item!"=="!item:IPv4 Address=!" if "!adapterfound!"=="true" (
        echo Your IP Address is: %%f
        set adapterfound=false
    )
)

pause