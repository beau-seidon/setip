@echo off

set pingrange_dest=C:\TEMP\online_devices.txt

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo enter your subnet (the first three octets of your ip address ___.___.___.nnn) [eg. 192.168.1]
set /p subnet="subnet: "
echo.
echo enter the first address to ping
set /p first="first: "
echo.
echo enter the last address to ping
set /p last="last: "

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo pinging all addresses in your specified range 
echo responses from online devices will be written to "%pingrange_dest%"
echo this may take some time. please wait...
echo.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set /a rng=last-first
for /L %%i in (%first%,1,%last%) do if not %rng% == 0 (
	echo pinging %subnet%.%%i
	ping -n 1 %subnet%.%%i | FIND /i "Reply">>"%pingrange_dest%"
)

start notepad.exe "%pingrange_dest%"
exit