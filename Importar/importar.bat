@echo off
title � Importar

rem Inicio del programa
set errorFichero=nada
set verFicheros=no

:gotoInicio
cls

if %verFicheros% equ si (
	set verFicheros=no
	dir /B /O:N /s *.json /s *.csv
	echo.&echo.
)
if %errorFichero% equ ficheroNoEncontrado (
	rem /B		cambia la vista
	rem /O:N	ordena por nombre
	rem /s		especifica el archivo
	dir /B /O:N /s *.json /s *.csv
	echo.&echo.
	set mensaje=Fichero '%fichero%' no encontrado
)
set fichero=vacio
echo �������������������Ŀ
echo �             � 1/? �
echo �   Fichero   �������
echo �  ���������  �
echo ���������������������ͻ
echo �                     �
echo � JSON o CSV          �
echo � con o sin extension �
echo �                     �
echo � [0] Ver ficheros    �
echo �                     �

rem sin errores: sin mensajes
if %errorFichero% equ nada (
	echo ���������������������ͼ
	set /P fichero= ���ͯ 

) else (
	echo ���������������������ͼ
)

rem errores: muestra error
if %errorFichero% equ ficheroNoEncontrado (
	echo � %mensaje%
	echo �����������������������
	set /P fichero= ���į 

	) else if %errorFichero% equ errorficheroVacio (
	echo � Necesitas un fichero para importar
	echo �����������������������
	set /P fichero= ���į 
)

if "%fichero%" equ "0" (
	set errorFichero=nada
	set verFicheros=si
	goto gotoInicio

) else if "%fichero%" equ "vacio" (
	goto gotoErrorFicheroIntroducidoVacio
)

rem Detectar extensi�n
rem JSON
if "%fichero:~-4%" equ "json" (
	goto gotoFichero

rem CSV
) else if "%fichero:~-3%" equ "csv" (
	goto gotoFichero

rem resto ficheros
) else (
	if exist "%fichero%.json" (
		set fichero=%fichero%.json
		goto gotoFichero
	
	) else if exist "%fichero%.csv" (
		set fichero=%fichero%.csv
		goto gotoFichero
	
	) else (
		goto gotoErrorFicheroNoEncontrado
	)
)


:gotoFichero
set errorBaseDatos=nada

:gotoFicheroBaseDatos
set baseDatos=vacia
cls
echo �������������������Ŀ
echo � fichero: %fichero%
echo �������������������������Ŀ
echo �                   � 2/3 �
echo �   Base de datos   �������
echo �  ���������������  �

if %errorBaseDatos% equ nada (
	echo �������������������ͼ
	set /P baseDatos= ���ͯ 

) else (
	echo �������������������ͼ
)

if %errorBaseDatos% equ errorBaseDatosVacia (
	echo � Error: Base de datos en blanco
	echo �����������������������
	set /P baseDatos= ���į 
)


if "%baseDatos%" equ "vacia" (
	goto gotoErrorBaseDatosIntroducidaVacia
)

set errorColeccion=nada
:gotoFicheroColeccion
set coleccion=vacia
cls
echo �������������������Ŀ
echo � fichero: %fichero%
echo �    BBDD: %baseDatos%
echo ���������������������Ŀ
echo �               � 3/3 �
echo �   Coleccion   �������
echo �  �����������  �

if %errorColeccion% equ nada (
	echo ���������������ͼ
	set /P coleccion= ���ͯ 

) else (
	echo ���������������ͼ
)

if %errorColeccion% equ errorColeccionVacia (
	echo � Error: Coleccion en blanco
	echo �����������������������
	set /P coleccion= ���į 
)


if "%coleccion%" equ "vacia" (
	goto gotoErrorColeccionIntroducidaVacia
)

cls
echo Info
echo �
echo �   fichero: %fichero%
echo �      BBDD: %baseDatos%
echo � Coleccion: %coleccion%
echo �������������������������������������
echo.&echo.

if "%fichero:~-4%" equ "json" (
	rem Importando en json
	mongoimport -d "%baseDatos%" --collection "%coleccion%" "%fichero%" --drop --stopOnError

rem CSV
) else if "%fichero:~-3%" equ "csv" (
	rem Importando en csv
	mongoimport -d "%baseDatos%" -c "%coleccion%" --type csv --file "%fichero%" --headerline
)

goto gotoTerminado

:gotoTerminado
echo.&echo.
echo ���������������ͻ
echo �   Terminado   �
echo ���������������ͼ
echo � Pulse una tecla para finalizar . . . �
echo ����������������������������������������
pause >nul
exit


rem ERRORES
rem ERRORES > Fichero
	rem No introducido ning�n fichero
	:gotoErrorFicheroIntroducidoVacio
		set errorFichero=errorficheroVacio
		goto gotoInicio

	rem Fichero no encontrado
	:gotoErrorFicheroNoEncontrado
		set errorFichero=ficheroNoEncontrado
		goto gotoInicio
	
rem ERRORES > Base Datos
	:gotoErrorBaseDatosIntroducidaVacia
		set errorBaseDatos=errorBaseDatosVacia
		cls
		goto gotoFicheroBaseDatos
	
rem ERRORES > Coleccion
	:gotoErrorColeccionIntroducidaVacia
		set errorColeccion=errorColeccionVacia
		cls
		goto gotoFicheroColeccion