@echo off

:CONFIG

	cd /D "%~dp0"

	set install_directory="C:\Windows"
	

:CHECK

	if EXIST %install_directory%\setip.bat (
		goto REPLACE
	) else (
		goto INSTALL
	)

	
:INSTALL

	COPY setip.bat %install_directory%\setip.bat >nul

	echo.
	echo Nice, setip.bat has been installed to %install_directory%
	
	goto EXECUTE

	
:REPLACE

	echo.
	echo Whoops, setip.bat already exists, do you want to replace existing file?
	goto CONFIRM


:CONFIRM
	echo.
	set /p conf= "Overwrite [y/n]: "
		
	for %%? in (y) do (
		if /i "%conf%"=="%%?" (
			COPY setip.bat %install_directory%\setip.bat >nul
			echo.
			echo The existing file has been replaced, and is gone forever. Hope you didn't want to keep it.
			goto EXECUTE
		)
	)
		
	for %%? in (n) do (
		if /i "%conf%"=="%%?" (
			echo.
			echo Well nevermind then...	
			pause
			exit
		)
	)
		
	echo huh?
	
	goto CONFIRM


:EXECUTE

	echo.
	%install_directory%\setip.bat
