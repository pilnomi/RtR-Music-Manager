# RtR-Music-Manager
Rise to Ruins music manager copies .ogg files from your music folder to the game's res/music, randomly mapping your tracks over the game's.

1) (optional) Create a backup of your game music folder.  You can always verify files from Steam of course.  The program uses the file names in the game's folder, so don't delete them.
2) (recommended) copy the .cmd file to the game's res/music folder.  If you want to run it from somewhere else, edit the .cmd file for the correct "GameMusicFolder"
3) (recommended) set your own music folder, defaults to "MusicFolder=%userprofile%\Music".   It will search all folders and sub-folders for *.ogg files
4) (optional) set your refresh interval, defaults to 10 minutes, set "RefreshMinutes=60"

While running it will randomly copy OGG files from your library over top the game's music files (overwriting them).
To end the program, use CTRL+C and confirm Y to end the batch program.
