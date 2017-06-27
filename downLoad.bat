
set config_home=lizhi

rem 1.创建工作目录
if exist kp_home (
	rd /s /q kp_home
)
md kp_home
rem 2.进入工作目录
cd kp_home

rem 3.获取pscp工具.
xcopy \\exchange.90km.com\exchange\xf\pscp.exe

rem 4.使用pscp下载文件Tomcat.
pscp -l root -pw 123456 192.168.80.84://home/Frank/openSource/apache-tomcat-7.0.55.zip .

md zip
cd zip
rem 5.使用pscp下载文件7zip.
pscp -l root -pw 123456 192.168.80.84://home/Frank/openSource/zip/* .
cd ../

rem 6.下载需要的包.gateway , proxy , gameProxy , kp , gameServer. 先下载proxy和kp
rem 6.1下载kp................
md kp
cd kp
pscp -l root -pw 123456 192.168.80.84://root/java_source/kp/dist/kp.war .


rem 6.1下载kp_config................
md kp_config
cd kp_config
pscp -l root -pw 123456 192.168.80.84://root/kpgroup/%config_home%/kp_config/* .
cd ../../


rem 6.2下载config_config................
rem md proxy_config
rem cd proxy_config
rem pscp -l root -pw 123456 192.168.80.84://root/kpgroup/xf/kp_config/* .
rem cd ../

rem 6.2下载proxy................
md proxy
cd proxy
pscp -r -l root -pw 123456 192.168.80.84://root/java_source/proxy/dist/* .
pscp -r -l root -pw 123456 192.168.80.84:/root/kpgroup/%config_home%/proxy_config/startup.bat .
cd lib/
pscp -r -l root -pw 123456 192.168.80.84:/home/Frank/openSource/jce.jar .
pscp -r -l root -pw 123456 192.168.80.84:/home/Frank/openSource/sunjce_provider.jar .

cd ../../


rem 6.3下载gateway
md gateway
cd gateway
pscp -r -l root -pw 123456 192.168.80.84://root/java_source/gateway/dist/* .
pscp -r -l root -pw 123456 192.168.80.84:/root/kpgroup/%config_home%/gateway_config/startup.bat .
rem 6.4创建gateway配置文件目录
md gateway_config
cd gateway_config
rem 替换配置文件
pscp -l root -pw 123456 192.168.80.84://root/kpgroup/%config_home%/gateway_config/config.properties .
copy config.properties ..\conf\ /y
cd ../../



rem 7.解压Tomcat.
.\zip\7z e -spf apache-tomcat-7.0.55.zip -oTomcat
rem 8.放入指定的文件到Tomcat下.

cd .\Tomcat\apache-tomcat-7.0.55\
rd /s /q webapps
md webapps
cd webapps
copy ..\..\..\kp\kp.war .\
..\..\..\zip\7z e -spf kp.war -okp
rem 删除原来的包
del kp.war 

rem 9.替换配置文件
copy ..\..\..\kp\kp_config\application.properties .\kp\WEB-INF\classes\ /y
copy ..\..\..\kp\kp_config\config.properties .\kp\WEB-INF\classes\ /y
cd ..\..\..\


rem 10.下载缓存
md cache
cd cache
pscp -r -l root -pw 123456 192.168.80.84:/home/Frank/openSource/memcached-1.4.5-x86.zip .
pscp -r -l root -pw 123456 192.168.80.84:/home/Frank/openSource/redis.zip .

..\zip\7z e -spf memcached-1.4.5-x86.zip -omemcached
..\zip\7z e -spf redis.zip -oredis

cd ..\
pscp -r -l root -pw 123456 192.168.80.84:/home/Frank/openSource/mysql-connector-python-1.0.12-py2.7.msi .

