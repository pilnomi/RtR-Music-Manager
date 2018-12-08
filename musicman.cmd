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
ECHO Total user files(s) : !idx!
ECHO Total game files(s) : !gidx!


for /L %%i in (1,1,%gidx%) do call :processfile %%i
echo ***user music has been randomly mapped to game music files***
echo ***Waiting %RefreshMinutes% minutes to refresh music, press CTRL+C to abort***
for /L %%h in (1,1,%RefreshMinutes%) do (timeout /t 60 /NOBREAK > nul)
goto loop                           					    //Return to loop marker
goto End

:processfile
	SET /a "_rand=((%RANDOM%*%idx%/32768)+1)"
	REM ECHO Random number "%_rand%"
	echo "!FileName[%_rand%]!" 
	REM del "!GameFileName[%1]!" > nul
	copy "!FileName[%_rand%]!" "!GameFileName[%1]!" > nul
goto :eof

:End