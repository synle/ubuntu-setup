## VM NAT Host IP
`10.0.2.2 host-machine`

## Classic Theme
`C:\Windows\Resources\Ease of Access Themes`

`http://www.howtogeek.com/133405/how-to-get-classic-style-themes-back-on-windows-8/`

https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/classic.theme

## Open Host Files
notepad c:\Windows\System32\Drivers\etc\hosts


## reg from app
https://social.technet.microsoft.com/Forums/sharepoint/en-US/d7f1b70f-03ed-4c5b-bc79-910278d8fa39/trying-to-change-visual-effects-via-the-registry



## Themes
`%userprofile%\AppData\Local\Microsoft\Windows\Themes`
`C:\Users\**\AppData\Local\Microsoft\Windows\Themes`

Shortcuts
### Tmux default shortcuts
https://github.com/mintty/wsltty
```
%windir%\system32\bash.exe -c "/usr/bin/tmux"
%LOCALAPPDATA%\wsltty\bin\mintty.exe --wsl -o Locale=C -o Charset=UTF-8 /bin/wslbridge -C~ -t /usr/bin/tmux
```

### Cmd with shortcuts
```%windir%\system32\cmd.exe /K C:\Users\syle\alias.cmd```



WSL Bash Home
```
C:\Users\syle\AppData\Local\lxss\home
C:\Users\syle\AppData\Local\lxss\root
```



### Classic Shell Pinned Path
```
 %APPDATA%\ClassicShell\Pinned
```
