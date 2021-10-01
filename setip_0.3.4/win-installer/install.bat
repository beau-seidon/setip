@echo off

cd /D %~dp0
cd src


:CONFIG
	set script_name=setip.bat
	set install_directory=C:\Program Files\bs\setip
	
	set task_name=\bs\setip
	set task_xml=setip_task_config.xml
	
	set shortcut_name=setip.lnk
	::  set shortcut_target=C:\Windows\System32\schtasks.exe /run /tn "\bs\setip"
	set shortcut_dest=%ProgramData%\Microsoft\Windows\Start Menu\Programs

	goto SUMMARY
	

:SUMMARY
	echo "%script_name%" will be installed to "%install_directory%"
	echo a shortcut will also be created on the Start Menu
	echo an on-demand task will be created for Win10 UAC purposes
	echo.
	pause
	goto CHECK


:CHECK	
	if exist "%install_directory%" (
		if exist "%install_directory%\%script_name%" ( goto REPLACE ) else ( goto INSTALL )
	) else ( 
		echo.
		echo "%install_directory%" does not exist, do you want to create it?
		goto CONFIRM_MKDIR
	)


:CONFIRM_MKDIR
	set /p conf= "create [y/n]: "	
	for %%? in (y) do (
		if /i "%conf%"=="%%?" (
			echo creating directory...
			mkdir "%install_directory%"	
			goto INSTALL
		)
	)	
	for %%? in (n) do (
		if /i "%conf%"=="%%?" (
			echo.
			echo well nevermind then...	
			goto FAREWELL
		)
	)	
	echo huh?
	goto CONFIRM_MKDIR


:INSTALL
	echo installing script...
	copy %script_name% "%install_directory%\%script_name%" 
	goto COPY_SHORTCUT

	
:REPLACE
	echo whoops, %script_name% already exists in "%install_directory%", do you want to replace the existing file?
	goto CONFIRM_REPLACE


:CONFIRM_REPLACE
	set /p conf= "overwrite [y/n]: "	
	for %%? in (y) do (
		if /i "%conf%"=="%%?" (
			echo overwriting...
			copy /y %script_name% "%install_directory%\%script_name%" 	
			goto COPY_SHORTCUT
		)
	)	
	for %%? in (n) do (
		if /i "%conf%"=="%%?" (
			echo well nevermind then...	
			goto FAREWELL
		)
	)	
	echo huh?
	goto CONFIRM_REPLACE


:COPY_SHORTCUT
	echo creating shortcuts...
	copy /Y %shortcut_name% "%shortcut_dest%\%shortcut_name%"
	copy /Y %shortcut_name% "%install_directory%\%shortcut_name%"
	goto SCHEDULE_TASK


:SCHEDULE_TASK
	echo creating on-demand task...
	schtasks /Create /XML %task_xml% /tn %task_name%
	goto FAREWELL
	

:FAREWELL
	echo later tater!
	pause
	goto END


:END

