execute the script in this directory to enable the settings needed in this video series. Be aware that it might change some visible elements, whatever.  

To only enable the setting that displays the full path, use the command below:  
`xfconf-query --channel thunar --property /misc-full-path-in-title --create --type bool --set true`  

To use the amazing `xfce4-settings-editor`, you need to have the package:  `xfce4-settings` (*available in the official arch repos with pacman*)

world wide web pages:  
https://docs.xfce.org/xfce/thunar/hidden-settings
https://bugzilla.xfce.org/show_bug.cgi?id=14069
