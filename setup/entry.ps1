# unrestricted ps exec policy
Set-ExecutionPolicy Unrestricted -Force

New-Item -Path "C:\tmp" -ItemType directory
cd "C:\tmp"

# install choco
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# run cmd script part
Download-File "$setupurl/setup.cmd" "setup.cmd"
.\setup.cmd

# run ps part
iex ((New-Object System.Net.WebClient).DownloadString("$setupurl/install.ps1"))

# wait a bit 'till windows finishes doing windows things
Start-Sleep -s 30

# shutdown (comment out in dev)
Stop-Computer
