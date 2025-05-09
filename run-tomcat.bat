@echo off
echo "=== Starting Tomcat ==="

set TOMCAT_DIR=C:\tomcat9

echo "Deploying application..."
copy build\airline-reservation-system.war "%TOMCAT_DIR%\webapps\" /Y

echo "Starting Tomcat..."
start /b "" "%TOMCAT_DIR%\bin\startup.bat"

timeout /t 5

echo "=== Tomcat started ==="
echo "You can access the application at: http://localhost:8080/airline-reservation-system/" 