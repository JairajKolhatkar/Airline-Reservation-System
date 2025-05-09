$tomcatUrl = "https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82-windows-x64.zip"
$tomcatZip = "apache-tomcat-9.0.82.zip"
$extractPath = "C:\tomcat9"

# Download Tomcat
Write-Host "Downloading Tomcat..."
Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip

# Extract Tomcat
Write-Host "Extracting Tomcat..."
Expand-Archive -Path $tomcatZip -DestinationPath $extractPath -Force

Write-Host "Tomcat has been downloaded and extracted to $extractPath" 