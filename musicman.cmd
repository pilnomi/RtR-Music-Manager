@echo off 
set "MusicFolder=%userprofile%\Music"
set "GameMusicFolder=."
set "RefreshMinutes=60"

:loop
echo *****************************************
echo MusicFolder: %MusicFolder%
echo GameMusicFolder: %GameMusicFolder%
echo *****************************************

setlocal enabledelayedexpansion
set /a "idx=0"
set /a "gidx=0"
set "AlreadySetFileCount=0"
set AlreadySetFileName=

FOR /f "delims=" %%f IN ('dir /b /s "%MusicFolder%\*.ogg"') DO (
set /a "idx+=1"
set "FileName[!idx!]=%%~f"
)

FOR /f "delims=" %%f IN ('dir /b "%GameMusicFolder%\*.ogg"') DO (
set /a "gidx+=1"
set "GameFileName[!gidx!]=%GameMusicFolder%\%%~f"
)


rem Display array elements
REM for /L %%i in (1,1,%idx%) do (
REM       echo [%%i] "!FileName[%%i]!"
REM   )
rem Display array elements
REM for /L %%i in (1,1,%gidx%) do (
REM      echo [%%i] "!GameFileName[%%i]!"
REM  )

set /a "enforceUniqueFiles=0"
for /L %%i in (1,1,%gidx%) do (
 if %idx% GEQ %gidx% (set /a "enforceUniqueFiles=1") ELSE (set /a "enforceUniqueFiles=0")
 if %%i LEQ %idx% set /a "enforceUniqueFiles=1"
 call :processfile %%i
)

ECHO Total user files(s) : !idx!
ECHO Total game files(s) : !gidx!
if %enforceUniqueFiles% EQU 1 (echo **you have more files than the game, enforcing unique file names**)  ELSE (echo ** you have less files than the game, some duplicates will occur **)
echo ***user music has been randomly mapped to game music files***
set "minutesleft=%RefreshMinutes%"
for /L %%h in (1,1,%RefreshMinutes%) do (
	echo:***Waiting !minutesleft! minutes to refresh music, press ^(Q^) to Quit, ^(R^) to refresh now***
	choice /C WRQ /N /T 60 /D W
	if errorlevel 3 echo Quit&goto :End
	if errorlevel 2 echo Refresh&goto :loop
	REM if errorlevel 1 echo Waiting...
	set /a "minutesleft=!minutesleft!-1"
)
goto :loop                           					    //Return to loop marker
goto :End

:processfile
	SET /a "_rand=((%RANDOM%*%idx%/32768)+1)"
	REM ECHO Random number "%_rand%"
	if %enforceUniqueFiles% EQU 1 call :isFileAlreadySet "!FileName[%_rand%]!"
	if %isFileSet% EQU 1 goto :processfile
	echo "!FileName[%_rand%]!" 
	copy "!FileName[%_rand%]!" "!GameFileName[%1]!" > nul
	set /a "AlreadySetFileCount+=1"
	set AlreadySetFileName[%AlreadySetFileCount%]="!FileName[%_rand%]!"
goto :eof

:isFileAlreadySet
REM echo checking duplicates
set /a "isFileSet=0"
for /L %%s in (1,1, %AlreadySetFileCount%) do (
	if /I !AlreadySetFileName[%%s]! EQU %1 (
		REM echo duplicate file name found %1
		set "isFileSet=1"
		goto :eof
	)
)
goto :eof

:End