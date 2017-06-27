rem 服务启动脚本
set home_dir=kp_home

rem 进入主目录
cd %home_dir%
rem 启动memcache
start .\cache\memcached\memcached-1.4.5-x86\memcached.exe

rem 启动redis
start .\cache\redis\redis\64bit\redis-server.exe

rem 启动proxy
cd proxy
start startup.bat
cd ..\

rem 启动gateway
cd gateway
start startup.bat
cd ..\

rem 启动gameProxy
rem cd gameproxy
rem start startup.bat
rem cd ..\

rem rem Tomcat 包含gameServer和KP
rem cd .\Tomcat\apache-tomcat-7.0.55\bin\
rem start catalina.bat run
