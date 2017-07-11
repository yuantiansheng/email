@REM ----------------------------------------------------------------------------
@REM Copyright 2001-2004 The Apache Software Foundation.
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM      http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM ----------------------------------------------------------------------------
@REM

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of agruments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup
if exist %BASEDIR%\bin\setenv.bat call %BASEDIR%\bin\setenv.bat

if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=..\lib

set CLASSPATH="%BASEDIR%"\conf;"%REPO%"\james-server-core-api-3.0-M2.jar;"%REPO%"\apache-mailet-2.4.jar;"%REPO%"\commons-configuration-1.6.jar;"%REPO%"\commons-collections-3.2.1.jar;"%REPO%"\commons-lang-2.4.jar;"%REPO%"\commons-logging-1.1.jar;"%REPO%"\mail-1.4.3.jar;"%REPO%"\activation-1.1.1.jar;"%REPO%"\james-server-core-library-3.0-M2.jar;"%REPO%"\james-server-util-3.0-M2.jar;"%REPO%"\james-server-dnsservice-api-3.0-M2.jar;"%REPO%"\oro-2.0.8.jar;"%REPO%"\apache-mailet-base-1.1.jar;"%REPO%"\commons-io-1.4.jar;"%REPO%"\jsr250-api-1.0.jar;"%REPO%"\spring-core-3.0.5.RELEASE.jar;"%REPO%"\spring-asm-3.0.5.RELEASE.jar;"%REPO%"\spring-beans-3.0.5.RELEASE.jar;"%REPO%"\spring-context-3.0.5.RELEASE.jar;"%REPO%"\spring-aop-3.0.5.RELEASE.jar;"%REPO%"\aopalliance-1.0.jar;"%REPO%"\spring-expression-3.0.5.RELEASE.jar;"%REPO%"\spring-web-3.0.5.RELEASE.jar;"%REPO%"\camel-core-2.5.0.jar;"%REPO%"\commons-logging-api-1.1.jar;"%REPO%"\commons-management-1.0.jar;"%REPO%"\camel-spring-2.5.0.jar;"%REPO%"\spring-tx-3.0.5.RELEASE.jar;"%REPO%"\xbean-spring-3.6.jar;"%REPO%"\spring-jms-3.0.5.RELEASE.jar;"%REPO%"\spring-orm-3.0.5.RELEASE.jar;"%REPO%"\spring-jdbc-3.0.5.RELEASE.jar;"%REPO%"\servlet-api-2.4.jar;"%REPO%"\log4j-1.2.14.jar;"%REPO%"\james-server-mailetcontainer-library-3.0-M2.jar;"%REPO%"\james-server-domainlist-api-3.0-M2.jar;"%REPO%"\james-server-mailetcontainer-api-3.0-M2.jar;"%REPO%"\geronimo-annotation_1.0_spec-1.1.jar;"%REPO%"\james-server-user-api-3.0-M2.jar;"%REPO%"\james-server-mailetcontainer-camel-3.0-M2.jar;"%REPO%"\james-server-mailbox-adapter-3.0-M2.jar;"%REPO%"\apache-james-mailbox-store-0.2-M1.jar;"%REPO%"\apache-james-mailbox-api-0.2-M1.jar;"%REPO%"\apache-mime4j-0.6.jar;"%REPO%"\apache-james-mailbox-maildir-0.2-M1.jar;"%REPO%"\james-server-dnsservice-dnsjava-3.0-M2.jar;"%REPO%"\dnsjava-2.1.0.jar;"%REPO%"\james-server-netty-socket-3.0-M2.jar;"%REPO%"\protocols-api-1.2-M1.jar;"%REPO%"\protocols-impl-1.2-M1.jar;"%REPO%"\netty-3.2.1.Final.jar;"%REPO%"\james-server-user-library-3.0-M2.jar;"%REPO%"\james-server-user-file-3.0-M2.jar;"%REPO%"\james-server-mail-api-3.0-M2.jar;"%REPO%"\commons-codec-1.4.jar;"%REPO%"\geronimo-jpa_2.0_spec-1.0.jar;"%REPO%"\james-server-user-jcr-3.0-M2.jar;"%REPO%"\jcr-2.0.jar;"%REPO%"\jackrabbit-jcr-commons-2.1.2.jar;"%REPO%"\commons-dbcp-1.3.jar;"%REPO%"\commons-pool-1.2.jar;"%REPO%"\derby-10.6.2.1.jar;"%REPO%"\slf4j-log4j12-1.5.8.jar;"%REPO%"\slf4j-api-1.5.8.jar;"%REPO%"\james-server-user-jdbc-3.0-M2.jar;"%REPO%"\james-server-user-jpa-3.0-M2.jar;"%REPO%"\james-server-user-ldap-3.0-M2.jar;"%REPO%"\james-server-domainlist-library-3.0-M2.jar;"%REPO%"\james-server-domainlist-xml-3.0-M2.jar;"%REPO%"\james-server-domainlist-jdbc-3.0-M2.jar;"%REPO%"\james-server-domainlist-jpa-3.0-M2.jar;"%REPO%"\james-server-smtpserver-3.0-M2.jar;"%REPO%"\james-server-queue-api-3.0-M2.jar;"%REPO%"\protocols-smtp-1.2-M1.jar;"%REPO%"\apache-jspf-0.9.5.jar;"%REPO%"\james-server-imapserver-3.0-M2.jar;"%REPO%"\apache-james-imap-api-0.2-M1.jar;"%REPO%"\apache-james-imap-message-0.2-M1.jar;"%REPO%"\james-server-lmtpserver-3.0-M2.jar;"%REPO%"\james-server-pop3server-3.0-M2.jar;"%REPO%"\james-server-fetchmail-3.0-M2.jar;"%REPO%"\james-server-core-function-3.0-M2.jar;"%REPO%"\james-server-queue-jms-3.0-M2.jar;"%REPO%"\geronimo-jms_1.1_spec-1.0.jar;"%REPO%"\james-server-queue-activemq-3.0-M2.jar;"%REPO%"\activemq-core-5.4.1.jar;"%REPO%"\activeio-core-3.1.2.jar;"%REPO%"\geronimo-j2ee-management_1.1_spec-1.0.1.jar;"%REPO%"\kahadb-5.4.1.jar;"%REPO%"\activemq-protobuf-1.1.jar;"%REPO%"\jasypt-1.6.jar;"%REPO%"\james-server-mailets-3.0-M2.jar;"%REPO%"\apache-jsieve-mailet-0.4.jar;"%REPO%"\apache-jsieve-0.4.jar;"%REPO%"\apache-standard-mailets-1.0.jar;"%REPO%"\james-server-remotemanager-3.0-M2.jar;"%REPO%"\jackrabbit-core-2.1.2.jar;"%REPO%"\concurrent-1.3.4.jar;"%REPO%"\jackrabbit-api-2.1.2.jar;"%REPO%"\jackrabbit-spi-commons-2.1.2.jar;"%REPO%"\jackrabbit-spi-2.1.2.jar;"%REPO%"\tika-parsers-0.6.jar;"%REPO%"\tika-core-0.6.jar;"%REPO%"\commons-compress-1.0.jar;"%REPO%"\geronimo-stax-api_1.0_spec-1.0.1.jar;"%REPO%"\tagsoup-1.2.jar;"%REPO%"\asm-3.1.jar;"%REPO%"\metadata-extractor-2.4.0-beta-1.jar;"%REPO%"\jcl-over-slf4j-1.5.8.jar;"%REPO%"\lucene-core-2.4.1.jar;"%REPO%"\apache-james-mailbox-jpa-0.2-M1.jar;"%REPO%"\openjpa-2.0.1.jar;"%REPO%"\serp-1.13.1.jar;"%REPO%"\geronimo-jta_1.1_spec-1.1.1.jar;"%REPO%"\apache-james-mailbox-jcr-0.2-M1.jar;"%REPO%"\james-server-mail-library-3.0-M2.jar;"%REPO%"\james-server-mail-file-3.0-M2.jar;"%REPO%"\james-server-mail-jdbc-3.0-M2.jar;"%REPO%"\james-server-mail-jcr-3.0-M2.jar;"%REPO%"\apache-james-imap-processor-0.2-M1.jar;"%REPO%"\jaxb-api-2.1.jar;"%REPO%"\stax-api-1.0-2.jar;"%REPO%"\jaxb-impl-2.2.1.jar;"%REPO%"\james-server-container-spring-3.0-M2.jar
set EXTRA_JVM_ARGUMENTS=-Xms128m -Xmx512m -Djava.system.class.loader=org.apache.james.container.spring.JamesClassLoader -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dmail.mime.multipart.ignoremissingendboundary=true -Dmail.mime.multipart.ignoremissingboundaryparameter=true -Dmail.mime.ignoreunknownencoding=true -Dmail.mime.uudecode.ignoreerrors=true -Dmail.mime.uudecode.ignoremissingbeginend=true -Dmail.mime.multipart.allowempty=true -Dmail.mime.base64.ignoreerrors=true -Dmail.mime.encodeparameters=true -Dmail.mime.decodeparameters=true -Dmail.mime.address.strict=false -Djames.message.usememorycopy=false
goto endInit

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS% %EXTRA_JVM_ARGUMENTS% -classpath %CLASSPATH_PREFIX%;%CLASSPATH% -Dapp.name="run" -Dapp.repo="%REPO%" -Dbasedir="%BASEDIR%" org.apache.james.container.spring.Main %CMD_LINE_ARGS%
if ERRORLEVEL 1 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=1

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@endlocal

:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
