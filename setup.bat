@echo off
echo "=== Setting Up Airline Reservation System ==="

echo "1. Create output directories for compilation"
mkdir build\WEB-INF\classes

echo "2. Compiling Java files"
dir /s /B src\main\java\*.java > sources.txt
javac -d build\WEB-INF\classes -cp "build\WEB-INF\classes;libs\*" @sources.txt

echo "3. Copying web resources"
xcopy src\main\webapp\*.* build\ /E /Y

echo "4. Creating libs directory if needed"
mkdir build\WEB-INF\lib

echo "5. Creating the WAR file"
cd build
jar -cvf airline-reservation-system.war *
cd ..

echo "=== Setup Complete ==="
echo "To deploy the application:"
echo "1. Download and install Apache Tomcat 9"
echo "2. Copy build\airline-reservation-system.war to Tomcat's webapps directory"
echo "3. Start Tomcat"
echo "4. Access the application at: http://localhost:8080/airline-reservation-system/" 