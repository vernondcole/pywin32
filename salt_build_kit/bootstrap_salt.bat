icacls c:\salt /t /q /grant "Authenticated Users":(OI)(CI)F
if exist c:\salt\salt-call.bat goto skip_install
powershell wget -outfile _btss.ps1 http://raw.githubusercontent.com/saltstack/salt-bootstrap/develop/bootstrap-salt.ps1
powershell ./_btss.ps1 -pythonversion 3 -runservice false -master localhost
icacls c:\salt /t /q /grant "Authenticated Users":(OI)(CI)F
:skip_install
copy masterless_minion.conf \salt\conf\minion.d\*.*
icacls c:\salt\conf\pki /t /remove:g "Authenticated Users":(OI)(CI)F
\salt\salt-call --version
