; The name of the installer
Name "KodiLauncher"

; The file to write
OutFile "KodiLauncher.exe"

; The default installation directory
InstallDir $PROGRAMFILES\KodiLauncher

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\KodiLauncher" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "KodiLauncher"
  SectionIn RO  
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File KodiLauncher\bin\Release\KodiLauncher.exe
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\KodiLauncher "Install_Dir" "$INSTDIR"
  
  ; Write the registry key redirecting ehshell.exe to KodiLauncher
  WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ehshell.exe" "Debugger" '"$INSTDIR\KodiLauncher.exe"'
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\KodiLauncher" "DisplayName" "KodiLauncher"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\KodiLauncher" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\KodiLauncher" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\KodiLauncher" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional "Portable Mode" section (can be disabled by the user)
Section "Launch Kodi in Portable Mode"
  File KodiLauncherArgs.txt
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ehshell.exe"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\KodiLauncher"
  DeleteRegKey HKLM SOFTWARE\KodiLauncher

  ; Remove files and uninstaller
  Delete $INSTDIR\KodiLauncher.exe
  Delete $INSTDIR\KodiLauncherArgs.txt
  Delete $INSTDIR\uninstall.exe

  ; Remove directories used
  RMDir "$INSTDIR"

SectionEnd
