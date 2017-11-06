# fluxbox-bg-rotator

Reads images in given directory, picks random one and set it as background.
To prevent repetition, once displayed images are stored in file and excluded from
further selection. When there is no image to be displayed process starts all over again.

Default image rotation is 10 minutes.
Default image directory is `$HOME/wallpapers`


Usage:

1. Edit script file
2. Set directory with wallpapes
3. Edit *.fluxbox/startup* file and put following code before `exec fluxbox` line

```
 sleep 1
 {
        . /path/to/sctipt/random_wallpaper_slideshow.sh &
 } &
```
