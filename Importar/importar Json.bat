@echo off
title � Importar JSON

:gotoVolverPreguntar
mode con lines=5
mode con cols=38
cls
echo ������������������������������������ͻ
echo � 1/3 � Fichero JSON (sin extension) �
echo ������������������������������������ͼ
set /P nombreJson= ���ͯ 

if not exist "./%nombreJson%.json" (
	mode con lines=13
	mode con cols=41
	cls
	echo ������������������������������������ͻ
	echo �                                    �
	echo �    Error: fichero no encontrado    �
	echo �                   �������������    �
	echo ������������������������������������Ĺ
	echo � Comprueba que el archivo json este �
	echo � al lado de este ejecutable .bat    �
	echo ������������������������������������ͼ
	echo � fichero: '%nombreJson%.json'
	echo � Pulse una tecla para reiniciar . . .
	echo ����������������������������������������
	pause >nul
	goto gotoVolverPreguntar
)
mode con lines=7
mode con cols=36
cls
echo ����������������������������������Ŀ
echo � json: '%nombreJson%.json'
echo ����������������������������������ͻ
echo � 2/3 � Nombre de la base de datos �
echo ����������������������������������ͼ
set /P nombreBD= ���ͯ 

mode con lines=8
mode con cols=32
cls
echo ������������������������������Ŀ
echo � json: '%nombreJson%.json'
echo �   BD: '%nombreBD%'
echo ������������������������������ͻ
echo � 3/3 � Nombre de la coleccion �
echo ������������������������������ͼ
set /P nombreCol= ���ͯ 

mode con lines=27
mode con cols=80
cls
echo �
echo �        jso: '%nombreJson%.json'
echo � Base Datos: '%nombreBD%'
echo �  Coleccion: '%nombreCol%'
echo �������������������������������������
echo.&echo.
mongoimport -d "%nombreBD%" --collection "%nombreCol%" "%nombreJson%.json"
echo.&echo.
echo ���������������ͻ
echo �   Terminado   �
echo ���������������ͼ
echo � Pulse una tecla para finalizar . . . �
echo ����������������������������������������
pause >nul
exit