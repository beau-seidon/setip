:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Name: setip.bat
::Version: 0.3.4
::Author: Beau Sterling
::Contact: beau.sterling@se.com
::Date: 2021.09.30
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
::	an option in the menu. This version also includes the ability to quickly
::  address or host, or a specified range of address in a network.
::
::	With the update I have included a script to place the setip.bat file into
::	the "C:\Program Files\bs" directory. It can be called quickly by clicking 
::  Start, or pressing the "Super" or [Win] key, and typing setip, then 
::  pressing [Enter]. The file can be placed pretty much anywhere else, but 
::  the installation path must be changed in the :CONFIG subroutine. The 
::  address presets and adapter names can be modified in the same section.
::
::	Please contact me at the email address above if you have any questions,
::	find any issues, or would like to work together with me to make this 
::	script fancier and/or more useful. I hope it saves you some effort. Enjoy.



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
::if not "%1" == "max" start /MAX cmd /c %0 max & exit/b



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:CONFIG
:: configure default values here

	set installation_directory="C:\Program Files\bs\setip\setip.bat"
	
	set adapter_1="LAN"
	set adapter_2="Wi-Fi"
	
	set static_1=192.168.1.111
	set static_2=10.110.210.111
	set static_3=10.159.102.111
	set static_4=10.15.90.111
	set static_5=10.0.0.111
	
	set netmask=255.255.255.0
	
	set gateway_1=192.168.1.1
	set gateway_2=10.110.210.1
	set gateway_3=10.159.102.1
	set gateway_4=10.15.90.1
	set gateway_5=10.0.0.1

	set selected_adapter=%adapter_1%



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MAIN_MENU
	echo.
	echo.
	echo ***MAIN MENU***
	echo.
	echo Note: Address changes will be applied to adapter with name %selected_adapter%
	echo.
	echo Choose one of the following:
	echo     [s] Set custom static IP
	echo     [d] Use DHCP
	echo     -------------------------------------------------
	echo     Presets:
	echo       [1] Set static IP to preset 1 (%static_1%/24)
	echo       [2] Set static IP to preset 2 (%static_2%/24)
	echo       [3] Set static IP to preset 3 (%static_3%/24)
	echo       [4] Set static IP to preset 4 (%static_4%/24)
	echo       [5] Set static IP to preset 5 (%static_5%/24)	
	echo     -------------------------------------------------
	echo     [a] Change adapter
	echo     -------------------------------------------------
	echo     [n] Open Control panel: Network Connections
	echo     [i] Run ipconfig
	echo     [p] Ping (fast)
	echo     [r] Ping a range of IP addresses
	echo     -------------------------------------------------
	echo     [config] Edit script configuration
	echo     -------------------------------------------------
	echo     [cmd] Open new terminal window
	echo     [q] Terminate script



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
	
	
	for %%? in (config) do if /i "%sel%"=="%%?" (
		echo.
		echo WARNING: Modifying this script may break functionality, continue at your own risk...
		goto CONFIRM_EDIT
	)

	
	for %%? in (n) do if /i "%sel%"=="%%?" (
		start control netconnections
		goto MAIN_MENU
	)


	for %%? in (i, ipconfig) do if /i "%sel%"=="%%?" (
		echo.
		ipconfig
		goto MAIN_MENU
	)
	

	for %%? in (p, ping) do if /i "%sel%"=="%%?" (
		echo.
		set /P address_to_ping="Enter IP address or host name: "
		goto DO_PING
	)


	for %%? in (r, range) do if /i "%sel%"=="%%?" goto PING_RANGE


	for %%? in (cmd) do if /i "%sel%"=="%%?" (
		start cmd
		goto MAIN_MENU
	)


	for %%? in (q) do if /i "%sel%"=="%%?" goto FAREWELL


	echo huh?

	goto INPUT

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
	
	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:DHCP_RESET
	echo.
	
	netsh int ip set address name = %selected_adapter% source = dhcp
	ipconfig /renew %selected_adapter%

	goto MAIN_MENU	
	


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ADAPTER_MENU
	echo.
	echo Available network adapters: 
	echo      [1] %adapter_1%
	echo      [2] %adapter_2%

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:CONFIRM_EDIT
	echo.
	set /p cont= "Continue? [y/n]: "
	
	for %%? in (y) do if /i "%cont%"=="%%?" goto EDIT_CONFIG
	for %%? in (n) do if /i "%cont%"=="%%?" goto MAIN_MENU

	echo huh?
	
	goto CONFIRM_EDIT
	


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PRESET_1
	netsh interface ip set address %selected_adapter% static %static_1% %netmask% %gateway_1%

	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:PRESET_2
	netsh interface ip set address %selected_adapter% static %static_2% %netmask% %gateway_2%

	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PRESET_3
	netsh interface ip set address %selected_adapter% static %static_3% %netmask% %gateway_3%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU
	


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:PRESET_4
	netsh interface ip set address %selected_adapter% static %static_4% %netmask% %gateway_4%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:PRESET_5
	netsh interface ip set address %selected_adapter% static %static_5% %netmask% %gateway_5%
	
	echo IP address has been modified. Run ipconfig to verify.
	
	goto MAIN_MENU



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:DO_PING
	%SystemRoot%\system32\ping.exe -n 3 -w 2000 "%address_to_ping%"
	
	goto MAIN_MENU



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PING_RANGE
	set pingrange_dest=%userprofile%\Desktop\active_hosts.txt
	set timeout=2000

	echo.
	echo To ping a range of IP addresses in a network with an assumed subnet mask
	echo of /24 (255.255.255.0), enter the network portion (the first three octets
	echo of your ip address ___.___.___.nnn) of your address below. [eg. 192.168.1]
	echo.
	set /p subnet="subnet: "
	echo.
	echo Enter the first host address to ping
	set /p first="first: "
	echo.
	echo Enter the last host address to ping
	set /p last="last: "

	echo.
	echo Pinging all addresses in your specified range. 
	echo Responses from online devices will be written to "%pingrange_dest%".
	echo This may take some time. Please wait...
	echo.
	
	echo PING-RANGE Exectuted: %date% %time%>>"%pingrange_dest%"
	echo Requested range: (%subnet%.%first% - %subnet%.%last%)>>"%pingrange_dest%"
	
	set /a rng=last-first
		
	for /L %%i in (%first%,1,%last%) do if %rng% GEQ 0 (
		echo Pinging %subnet%.%%i
		ping -n 1 -w %timeout% %subnet%.%%i | FIND /i "Reply">>"%pingrange_dest%"
	)
	
	for /L %%i in (%first%,-1,%last%) do if %rng% LSS 0 (
		echo Pinging %subnet%.%%i
		ping -n 1 -w %timeout% %subnet%.%%i | FIND /i "Reply">>"%pingrange_dest%"
	)
	
	echo.>>"%pingrange_dest%"
	
	goto MAIN_MENU

	

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	
:FAREWELL
	echo.
	echo.
	echo Share this script with your friends! And your enemies.
	echo.
	echo Script will now terminate
	
	pause
	
	goto END 



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:END
