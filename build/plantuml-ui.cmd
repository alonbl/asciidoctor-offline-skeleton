@echo off
setlocal
set JAVA_HOME=C:\DevTools\jdk-18.0.1.1
set ME=%~dp0
"%JAVA_HOME%\bin\java" -Dfile.encoding=UTF-8 -cp "%ME%\..\tools\plantuml.jar;%ME%\..\tools\jlatexmath.jar" net.sourceforge.plantuml.Run -gui
endlocal
