@echo off
echo "=== Setting Up Apache Tomcat ==="

set TOMCAT_VERSION=9.0.82
set TOMCAT_URL=https://archive.apache.org/dist/tomcat/tomcat-9/v%TOMCAT_VERSION%/bin/apache-tomcat-%TOMCAT_VERSION%-windows-x64.zip
set TOMCAT_FILE=apache-tomcat-%TOMCAT_VERSION%.zip
set TOMCAT_DIR=C:\tomcat9

echo "1. Downloading Apache Tomcat %TOMCAT_VERSION%"
powershell -Command "(New-Object Net.WebClient).DownloadFile('%TOMCAT_URL%', '%TOMCAT_FILE%')"

echo "2. Extracting Apache Tomcat to %TOMCAT_DIR%"
powershell -Command "Expand-Archive -Path '%TOMCAT_FILE%' -DestinationPath '%TOMCAT_DIR%' -Force"

echo "3. Setting up Tomcat as a service"
powershell -Command "& '%TOMCAT_DIR%\bin\service.bat' install"

echo "4. Starting Tomcat service"
net start Tomcat9

echo "=== Tomcat Setup Complete ==="
echo "You can access Tomcat at: http://localhost:8080/" 