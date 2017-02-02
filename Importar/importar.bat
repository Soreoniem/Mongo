@echo off
title ® Importar

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
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍËÄÄÄÄÄ¿
echo º             º 1/? ³
echo º   Fichero   ÌÄÄÄÄÄÙ
echo º  îîîîîîîîî  º
echo ÌÄÄÄÄÄÄÄÄÄÄÄÄÄÊÍÍÍÍÍÍÍ»
echo º                     º
echo º JSON o CSV          º
echo º con o sin extension º
echo Ì                     ¹
echo º [0] Ver ficheros    º
echo º                     º

rem sin errores: sin mensajes
if %errorFichero% equ nada (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	set /P fichero= ÈÍÍÍ¯ 

) else (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
)

rem errores: muestra error
if %errorFichero% equ ficheroNoEncontrado (
	echo ³ %mensaje%
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	set /P fichero= ÀÄÄÄ¯ 

	) else if %errorFichero% equ errorficheroVacio (
	echo ³ Necesitas un fichero para importar
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	set /P fichero= ÀÄÄÄ¯ 
)

if "%fichero%" equ "0" (
	set errorFichero=nada
	set verFicheros=si
	goto gotoInicio

) else if "%fichero%" equ "vacio" (
	goto gotoErrorFicheroIntroducidoVacio
)

rem Detectar extensión
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
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ fichero: %fichero%
echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÄÄÄÄÄ¿
echo º                   º 2/3 ³
echo º   Base de datos   ÌÄÄÄÄÄÙ
echo º  îîîîîîîîîîîîîîî  º

if %errorBaseDatos% equ nada (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	set /P baseDatos= ÈÍÍÍ¯ 

) else (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
)

if %errorBaseDatos% equ errorBaseDatosVacia (
	echo ³ Error: Base de datos en blanco
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	set /P baseDatos= ÀÄÄÄ¯ 
)


if "%baseDatos%" equ "vacia" (
	goto gotoErrorBaseDatosIntroducidaVacia
)

set errorColeccion=nada
:gotoFicheroColeccion
set coleccion=vacia
cls
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ fichero: %fichero%
echo ³    BBDD: %baseDatos%
echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÄÄÄÄÄ¿
echo º               º 3/3 ³
echo º   Coleccion   ÌÄÄÄÄÄÙ
echo º  îîîîîîîîîîî  º

if %errorColeccion% equ nada (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	set /P coleccion= ÈÍÍÍ¯ 

) else (
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
)

if %errorColeccion% equ errorColeccionVacia (
	echo ³ Error: Coleccion en blanco
	echo ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	set /P coleccion= ÀÄÄÄ¯ 
)


if "%coleccion%" equ "vacia" (
	goto gotoErrorColeccionIntroducidaVacia
)

cls
echo Info
echo Â
echo ³   fichero: %fichero%
echo ³      BBDD: %baseDatos%
echo ³ Coleccion: %coleccion%
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º   Terminado   º
echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo ³ Pulse una tecla para finalizar . . . Ú
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pause >nul
exit


rem ERRORES
rem ERRORES > Fichero
	rem No introducido ningún fichero
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