#########################################################################
#                             Kodilauncher                              #
#########################################################################

What is it used for?
====================
Use Windows Media center remote or compatible remote
to launch Kodi media center with remote "start" button.

How does it work?
=================
You have to replace "ehshell.exe" located in
"C:\Windows\ehome\" with this one.

How to replace ehshell.exe?
===========================
Yo have to change permissions:
1. Open in Explorer "C:\Windows\ehome"
2. In "ehome" directory, right click "ehshell.exe" and choose "Properties"
3. Click on the "Security" tab and then "Advanced" button at the bottom.
4. Click on the "Owner" tab and click the "Edit" button.
5. Select "Administrators" and hit "OK."
6. Click "OK" in the "Advanced Security Settings for ehshell.exe" dialog.
7. In the "ehshell.exe Properties" dialog, click on "Administrators" under
    "Group or user names" and click the "Edit" button.
8. Select "Administrators" (or add that group if it isn't already there)
    and check the "Full Control" box in the Allow column.
9. "OK" out of all the properties and permissions dialogs.
10. While in "C:\Windows\ehome", copy ehshell.exe and paste it somewhere
    safe as a backup, in case you ever need to restore.

Now, we can copy the new launcher.
11. From this folder (the one this readme file is in), copy ehshell.exe
12. Paste the modified "ehshell.exe" in the "C:\Windows\ehome" directory.

Optional:
13. If you want to add command line arguments, place a file named "KodiLaunchArgs.txt"
    in the "C:\Windows\ehome" directory.
14. The contents of the text file should be the command line arguments you would like
    to run with.

Original source and all credits for this tool goes to:
http://inchoatethoughts.com/

Modified by:
http://www.zvonimirbuzanic.com/
#########################################################################