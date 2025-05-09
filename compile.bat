@echo off
setlocal enabledelayedexpansion

echo "=== Compiling Java Files ==="

REM Create necessary directories
mkdir "build\WEB-INF\classes" 2>nul
mkdir "build\WEB-INF\lib" 2>nul

REM Copy dependencies to WEB-INF\lib
copy "jstl-1.2.jar" "build\WEB-INF\lib\" /Y >nul
copy "servlet-api.jar" "build\WEB-INF\lib\" /Y >nul
copy "mysql-connector-java-8.0.28.jar" "build\WEB-INF\lib\" /Y >nul

REM Set up classpath
set CLASSPATH=.;build\WEB-INF\classes;build\WEB-INF\lib\jstl-1.2.jar;build\WEB-INF\lib\servlet-api.jar;build\WEB-INF\lib\mysql-connector-java-8.0.28.jar

REM First compile utils
echo "Compiling utility classes..."
for /r src\main\java\com\airline\utils %%f in (*.java) do (
    echo "Compiling %%f..."
    javac -d "build\WEB-INF\classes" -cp "%CLASSPATH%" "%%f"
)

REM Then compile models to avoid circular dependencies
echo "Compiling model classes..."
for /r src\main\java\com\airline\models %%f in (*.java) do (
    echo "Compiling %%f..."
    javac -d "build\WEB-INF\classes" -cp "%CLASSPATH%" "%%f"
)

REM Then compile DAOs
echo "Compiling DAO classes..."
for /r src\main\java\com\airline\dao %%f in (*.java) do (
    echo "Compiling %%f..."
    javac -d "build\WEB-INF\classes" -cp "%CLASSPATH%" "%%f"
)

REM Compile filters
echo "Compiling filter classes..."
for /r src\main\java\com\airline\filters %%f in (*.java) do (
    echo "Compiling %%f..."
    javac -d "build\WEB-INF\classes" -cp "%CLASSPATH%" "%%f"
)

REM Finally compile controllers
echo "Compiling controller classes..."
for /r src\main\java\com\airline\controllers %%f in (*.java) do (
    echo "Compiling %%f..."
    javac -d "build\WEB-INF\classes" -cp "%CLASSPATH%" "%%f"
)

echo "=== Compilation Complete ===" 