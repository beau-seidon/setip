NAME:		setip
VERSION:	0.3.2
AUTHOR:		Beau Sterling
DATE:		8/6/2018
CONTACT:	beau.sterling@schneider-electric.com
DESCRIPTION:

Version 0.3.2
	Fixed some broke stuff. Stupid typos that I simply missed.
	Added install.bat to the .zip archive, which copies setip.bat into "C:\Windows\"

Version 0.3.1
	Expanded menu
		Added 5x IP address presets
		Added shortcuts for a few things like ipconfig and the network adapters control panel window.
		Added ability to select different network adapters
		Added ability to launch notepad to quickly edit the script. 
	User input verification
	Many changes to the internal structure of the script.
	More details in the script header comment


Version 0.2
	setip.bat is a script I have built up over the past year, whose simple core function was originally posted by Scott D. on the Spiceworks community. I use it almost every day, and it saves LOTS of time and mouse clicks, as I frequently change my IPv4 address on my LAN adapter.

	When it is executed, a terminal window opens and prompts* the user to decide between setting a static IP address, and setting the adapter to DHCP mode, by pressing either 'a' or 'b'.
	If you choose to set a static IP address, it will prompt you, in order, for the address, the subnet mask, and then the default gateway, and it will modify your adapter configuration accordingly. If you press 'b', the adapter will be reset to DHCP mode.

		* The menu is now much more useful than that of previous versions. For more information see NEW FEATURES above, or just use the script to see the changes.


	The script can be executed by double-clicking the .bat file from any directory on your machine... 
	OR to save even more time, it can be placed in any Path defined in your system's Environment Variables, and executed from the terminal or the Run dialog box. 


	The fastest method is to move or copy the .bat file to the C:\Windows directory, and run the script by pressing 'Win' + 'r' on your keyboard, then entering "setip", when the Run dialog box appears.
	(The 'Win' key is typically found between 'Ctrl' and 'Alt')


	To cancel** operation of the script, press 'Ctrl' + 'c'. It will ask if you wish to terminate. The decision is yours.
		
		** "exit" will now terminate the script
	
Version 0.1
	Not released to public, only in local branch.


KNOWN ISSUES:
	1. If your LAN adapter name does not match the name specified in the script, eg. "Local Area Connection", you will receive an error message. 

		To fix this, select edit script from the main menu, and change your adapter name(s) to match those in your control panel. 

	2. Weird stuff happens sometimes if you leave the default gateway blank.

	Don't leave the default gateway blank. If you are simply connecting your machine to a controller or other IP device to configure it, it is usually fine to enter the same address as your's, but enter 1 for the last octet; ie. x.x.x.1, eg. 192.168.1.1 (if your address is 192.168.1.69).
	
	3. Some PC's cannot edit the script from its menu, because elevated permissions are required to modify files in C:\Windows\. I am currently working on a fix for this. I didn't notice this on my PC, but Windows 10 seems to be a bit more restrictive. 


MOTIVATION:
	The shortest procedure I know of to execute this task, using mouse clicks, is the following:

	1. Right click network icon on the taskbar tray
	2. Select "Network and Sharing Center"
	3. Click the link to the active network connection you wish to configure, eg. "Local Area Connection"
	4. Click "Properties"
	5. Click "IPv4" on the Networking tab
	6. Click "Properties"
	7. Click either "Use the following IP address:" or "Obtain an IP address automatically"
	8. Enter IP address, subnet mask, and default gateway (if setting static IP)
	9. Mope about all the time wasted moving your mouse point around the on the screen.


	Doesn't this seem a bit easier?:

	1. Type 'win' + 'r'
	2. Enter "setip"
	3. Enter 'a' or 'b'
	4. Enter IP address, subnet mask, and default gateway (if setting static IP)
	5. Brag to your friends about how much faster you can change your IP address than they can.