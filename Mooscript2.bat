:: Automatically Sign in to User Account at Startup in Windows

@Echo OFF

(Net session >nul 2>&1)||(PowerShell start """%~0""" -verb RunAs & Exit /B)


:_CHOICE

Cls & Mode CON  LINES=11 COLS=110 & Color F4
Echo.
Echo.
Echo.
Echo        1 - Turn On Automatic Sign in for a Domain, Local, or Microsoft Account
Echo.    
Echo        2 - Turn Off Automatic Sign in for All Users
Echo.


Set /p input=:^>

If Not %input%==1 (Goto :_Ex) Else (Goto :_AutoSign)

:_Ex
If Not %input%==2  (Goto :_CHOICE) Else (Goto :_Disable)




:_AutoSign

Cls

Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f  2>&1 > Nul

Echo.
Echo.
Echo Type the computer name (ex: %COMPUTERNAME%) or domain name
Echo.

Set /p Computer_Name=:^>

Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d "%Computer_Name%" /f  2>&1 > Nul

Cls

Echo.
Echo.
Echo Type the user name (ex: %UserName%) of the account you want to automatically be signed in to at startup
Echo.

Set /p User_Name=:^>

Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName  /t REG_SZ /d "%User_Name%" /f  2>&1 > Nul

Cls

Echo.
Echo.
Echo Type the password of the user account you want to automatically be signed in to at startup.
Echo.

Set /p Password=:^>

Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword  /t REG_SZ /d "%Password%" /f  2>&1 > Nul

Cls

Exit





:_Disable


Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f  2>&1 > Nul


Reg Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f  2>&1 > Nul