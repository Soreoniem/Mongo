@echo off
title ® Importar JSON

:gotoVolverPreguntar
mode con lines=5
mode con cols=38
cls
echo ÉÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º 1/3 ³ Fichero JSON (sin extension) º
echo ÌÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /P nombreJson= ÈÍÍÍ¯ 

if not exist "./%nombreJson%.json" (
	mode con lines=13
	mode con cols=41
	cls
	echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	echo º                                    º
	echo º    Error: fichero no encontrado    º
	echo º                   îîîîîîîîîîîîî    º
	echo ÌÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¹
	echo º Comprueba que el archivo json este º
	echo º al lado de este ejecutable .bat    º
	echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	echo ³ fichero: '%nombreJson%.json'
	echo ³ Pulse una tecla para reiniciar . . .
	echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pause >nul
	goto gotoVolverPreguntar
)
mode con lines=7
mode con cols=36
cls
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ json: '%nombreJson%.json'
echo ÌÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º 2/3 ³ Nombre de la base de datos º
echo ÌÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /P nombreBD= ÈÍÍÍ¯ 

mode con lines=8
mode con cols=32
cls
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ json: '%nombreJson%.json'
echo ³   BD: '%nombreBD%'
echo ÌÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º 3/3 ³ Nombre de la coleccion º
echo ÌÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /P nombreCol= ÈÍÍÍ¯ 

mode con lines=27
mode con cols=80
cls
echo ¿
echo ³        jso: '%nombreJson%.json'
echo ³ Base Datos: '%nombreBD%'
echo ³  Coleccion: '%nombreCol%'
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.&echo.
mongoimport -d "%nombreBD%" --collection "%nombreCol%" "%nombreJson%.json"
echo.&echo.
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo º   Terminado   º
echo ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo ³ Pulse una tecla para finalizar . . . Ú
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pause >nul
exit