# Install IIS server role
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Remove default htm file
Remove-Item  C:\inetpub\wwwroot\iisstart.htm

# Add a new htm file that displays server name
Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello World from " + $env:computername)