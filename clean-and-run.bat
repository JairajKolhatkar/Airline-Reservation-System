@echo off
echo "=== Cleaning and Running Airline Reservation System ==="

echo "1. Removing unnecessary files..."
if exist test.jsp del test.jsp
if exist simple-index.jsp del simple-index.jsp
if exist web-modified.xml del web-modified.xml

echo "2. Compiling Java files..."
call compile.bat

echo "3. Copying web resources..."
xcopy "src\main\webapp\*.*" "build\" /E /Y

echo "4. Creating the WAR file..."
cd build
jar -cvf airline-reservation-system.war *
cd ..

echo "5. Deploying to Tomcat..."
copy "build\airline-reservation-system.war" "apache-tomcat\apache-tomcat-9.0.82\webapps\"

echo "6. Starting Tomcat..."
set "CATALINA_HOME=%CD%\apache-tomcat\apache-tomcat-9.0.82"
cd "apache-tomcat\apache-tomcat-9.0.82\bin"
call startup.bat
cd ..\..\..

echo "=== Setup Complete ==="
echo "You can access the application at: http://localhost:8080/airline-reservation-system/" 