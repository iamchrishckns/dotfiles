# Firefox on Gnome

## Distinct icons in the dock per profile

### Firefox shortcut 


Replace $name everywhen with the profile name

Filename: `~/.local/share/applications/firefox-$name.desktop`

```
[Desktop Entry]
Version=1.0
Name=Firefox ($name)
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Exec=firefox --class=Firefox$name --name Firefox$name --no-remote -P $name %u
Icon=firefox
Terminal=false
Type=Application
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
# If the StartupWMClass is not set to the same as the argument of the --name option
# the GNOME Shell won't show the proper icon, name and won't ungroup the firefox instances.
StartupWMClass=Firefox$name
Actions=new-window;new-private-window;profile-manager-window;
 
[Desktop Action new-window]
Name=Open a New Window in $name
Exec=firefox --class=Firefox$name --name Firefox$name --no-remote -P $name --new-window %u
 
[Desktop Action new-private-window]
Name=Open a New Private Window in $name
Exec=firefox --class=Firefox$name --name Firefox$name --no-remote -P $name --private-window %u
 
[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=firefox --ProfileManager
```
