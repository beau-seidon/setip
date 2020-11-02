::Name: setip.bat
::Version: 0.3.4
::Author: Beau Sterling
::Contact: beau.sterling@schneider-electric.com
::Date: 2018.07.18
::Description:
::	I wrote this script because I sometimes have to change my IP address
::	several times per day, to configure and program various BAS devices.
::	Navigating to the network connections through the explorer can quickly
::	become quite a tedious chore, so I decided to learn how to create a batch
::	script to expedite the process.
::
::	This script presents the user with a menu, and with the option to set 
::	a custom static IP address, choose among 5 presets, or reset the network
::	adapter to DHCP.The adapter is selectable through a submenu. The presets
::	and adapter names are configured by modifying the script text, which is
::	an option in the menu.
::
::	With the update I have included a script to place the setip.bat file into
::	the "C:\Program Files\bs" directory, which is in the run PATH by default. It can be
::	called quickly by clicking start, or pressing the "Super" or [Win] key, 
::	and typing setip, then pressing [Enter]. The file can be placed pretty much 
::	anywhere else, but the installation path must be changed in the :CONFIG 
::	subroutine. The address presets and adapter names can be modified in the 
::	same section.
::
::	Please contact me at the email address above if you have any questions,
::	find any issues, or would like to work together with me to make this 
::	script fancier and/or more useful. I hope it saves you some effort. Enjoy.
::
::
::  writing ping range


@echo off
::if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

	
:CONFIG
:: configure default values here

	set installation_directory="C:\Program Files\bs\setip\setip.bat"
	
	set adapter_1="LAN"
	set adapter_2="Wi-Fi"
	
	set static_1=192.168.1.111
	set static_2=10.0.0.111
	set static_3=10.159.102.111
	set static_4=10.159.38.111
	set static_5=10.15.90.111
	
	set netmask=255.255.255.0
	
	set gateway_1=192.168.1.1
	set gateway_2=10.0.0.1
	set gateway_3=10.159.102.1
	set gateway_4=10.159.38.1
	set gateway_5=10.15.90.1

	set selected_adapter=%adapter_1%
	
	set pingrange_dest=C:\TEMP\online_devices.txt


:SPLASH
	echo **********************************************************************
	echo.                                                                    
	echo                                     ho                              
	echo            .                       :M+          /.                  
	echo        -odSS:                      dN'          ds                  
	echo     -smMMMMd-          ._     :ssshMmmyyy              -oo+_        
	echo    hMMMNy`          .odMNMs  :MMMMMMNddyy       ..    oMMMMMd.      
	echo    dMMNs+::.       dNMt..mMN     :dm`           +h   'mm   oNh      
	echo    `smNNNNNMNhp    NMNhoso:       sm            oN.  :m-   -dm      
	echo            `MNMo   lNho           .Ns.    .,    +M.  ;NyydNMMy      
	echo          ..;NNMm    +NMMMmt:       +MMNmmNN+    :N.  mMMMMNd+       
	echo       mMMMMMMMm:     `:++:`         :ymdho'      :   :Nh-           
	echo       'ossoo++'                                      :No            
	echo                                                      :Mo            
	echo                                                      :M+            
	echo                                                      `h/            
	echo                                                              (v 0.3.4)
	echo **********************************************************************

	
:MAIN_MENU
	echo.
	echo.
	echo ***MAIN MENU***
	echo.
	echo Note: Changes will be applied to adapter with name %selected_adapter%
	echo.
	echo Choose one of the following:
	echo     [s] Set custom static IP
	echo     [d] Use DHCP
	echo     -------------------------------------------------
	echo     [a] Change adapter
	echo     -------------------------------------------------
	echo     Presets:
	echo       [1] Set static IP to preset 1 (%static_1%/24)
	echo       [2] Set static IP to preset 2 (%static_2%/24)
	echo       [3] Set static IP to preset 3 (%static_3%/24)
	echo       [4] Set static IP to preset 4 (%static_4%/24)
	echo       [5] Set static IP to preset 5 (%static_5%/24)
	echo     -------------------------------------------------
	echo     [n] Open Control panel: Network Connections
	echo     [i] ipconfig
	echo     [p] ping
	echo     [r] Ping Range (incomplete)
	echo     -------------------------------------------------
	echo     [config] Edit script configuration
	echo     -------------------------------------------------
	echo     [cmd] Open new terminal window
	echo     [exit] Terminate script

	
:INPUT
	echo.
	set /P sel="Whatcha wanna do?: "


	for %%? in (s) do if /i "%sel%"=="%%?" goto CUSTOM_STATIC
	
	for %%? in (d) do if /i "%sel%"=="%%?" goto DHCP_RESET

	
	for %%? in (a) do if /i "%sel%"=="%%?" goto ADAPTER_MENU

	
	for %%? in (1) do if /i "%sel%"=="%%?" goto PRESET_1
	
	for %%? in (2) do if /i "%sel%"=="%%?" goto PRESET_2
	
	for %%? in (3) do if /i "%sel%"=="%%?" goto PRESET_3
	
	for %%? in (4) do if /i "%sel%"=="%%?" goto PRESET_4

	for %%? in (5) do if /i "%sel%"=="%%?" goto PRESET_5

	
	for %%? in (n) do if /i "%sel%"=="%%?" (
		start control netconnections
		goto MAIN_MENU
	)

	for %%? in (i) do if /i "%sel%"=="%%?" (
		echo.
		ipconfig
		goto MAIN_MENU
	)

	for %%? in (p) do if /i "%sel%"=="%%?" (
		echo.
		set /P address="Enter IP address to ping: "
		%SystemRoot%\system32\ping.exe -n 3 %address%
		goto MAIN_MENU
	)

	for %%? in (r) do if /i "%sel%"=="%%?" goto PINGRANGE (
	
	)


	for %%? in (config) do if /i "%sel%"=="%%?" (
		echo.
		echo WARNING: Modifying this script may break functionality, continue at your own risk...
		goto CONFIRM_EDIT
	)

	
	for %%? in (cmd) do if /i "%sel%"=="%%?" (
		start cmd
		goto MAIN_MENU
	)

	for %%? in (exit) do if /i "%sel%"=="%%?" goto FAREWELL


	echo huh?
	goto INPUT

	
:CUSTOM_STATIC 
	echo.
	echo Static IP Address:
	set /p ip_address=

	echo.
	echo Subnet Mask:
	set /p subnet_mask=

	echo.
	echo Default Gateway:
	set /p default_gateway=

	netsh interface ip set address %selected_adapter% static %ip_address% %subnet_mask% %default_gateway%

	echo IP address has been modified. Run ipconfig to verify.

	goto MAIN_MENU
	
	
:DHCP_RESET
	echo.
	netsh int ip set address name = %selected_adapter% source = dhcp
	ipconfig /renew

	goto MAIN_MENU	
	
	
:ADAPTER_MENU
	echo.
	echo Available network adapters: 
	echo      [1] %adapter_1%
	echo      [2] %adapter_2%
	
	
:CHANGE_ADAPTER
	
	echo.
	set /P ad= "Pick one: "
	
	for %%? in (1) do (
		if /i "%ad%"=="%%?" (
			set selected_adapter=%adapter_1%
			echo Adapter selected!
			goto MAIN_MENU		
		)
	)
	
	for %%? in (2) do (
		if /i "%ad%"=="%%?" (
			set selected_adapter=%adapter_2%
			echo Adapter selected!
			goto MAIN_MENU		
		)
	)

	echo huh?
	
	goto CHANGE_ADAPTER
	
	
:CONFIRM_EDIT

	echo.
	set /p cont= "Continue? [y/n]: "
	
	for %%? in (y) do if /i "%cont%"=="%%?" goto EDIT_CONFIG
	for %%? in (n) do if /i "%cont%"=="%%?" goto MAIN_MENU

	echo huh?
	
	goto CONFIRM_EDIT
	

:EDIT_CONFIG

	if EXIST %installation_directory% (

		start notepad %installation_directory%
		
		exit

	) else (
		echo.
		echo Uh oh... The Script directory is not mapped correctly. 
		echo You must locate the file and correct the "installation_directory"
		echo in the CONFIG section for this feature to work. Good luck. 
		goto MAIN_MENU
	)
	
	
:PRESET_1

	netsh interface ip set address %selected_adapter% static %static_1% %netmask% %gateway_1%

	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU
	
	
:PRESET_2

	netsh interface ip set address %selected_adapter% static %static_2% %netmask% %gateway_2%

	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU
	
	
:PRESET_3

	netsh interface ip set address %selected_adapter% static %static_3% %netmask% %gateway_3%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU
	
	
:PRESET_4

	netsh interface ip set address %selected_adapter% static %static_4% %netmask% %gateway_4%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU
	
	
:PRESET_5

	netsh interface ip set address %selected_adapter% static %static_5% %netmask% %gateway_5%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU


:PINGRANGE

	echo enter your subnet (the first three octets of your ip address ___.___.___.nnn) [eg. 192.168.1]
	set /p subnet="subnet: "
	echo.
	
	echo enter the first address to ping
	set /p first="first: "
	echo.
	
	echo enter the last address to ping
	set /p last="last: "
	echo.
	
	echo pinging all addresses in your specified range 
	echo responses from online devices will be written to "%pingrange_dest%"
	echo this may take some time. please wait...
	echo.

	set /a rng=last-first
	for /L %%i in (%first%,1,%last%) do if not %rng% == 0 (
		echo pinging %subnet%.%%i
		ping -n 1 %subnet%.%%i | FIND /i "Reply">>"%pingrange_dest%"
	)

	start notepad.exe "%pingrange_dest%"

	
:FAREWELL

	echo.
	echo.
	echo Share this script with your friends! And your enemies.
	echo.
	echo Script will now terminate
	pause
	goto END 


:END

