;PROGRAMA REALIZADO POR: JAIRO VERGARA
;COMUNICACION SERIAL
;LEER DEL PUERTO SERIAL UN  CARACATER Y VISUALIZARLO POR PANTALLA

        .MODEL  SMALL
        .386
        .STACK

        .DATA
RXDATO   DB      00H    ;MEMORIA DONDE SE ALMACENA DATO RECIBIDO

MINICIO	DB	'LOS CARACTERES QUE ESTA RECIBIENDO SERIALMENTE SON: ',10,13,'$'

;********* MACROS *******************************************
;MACRO PARA CONFIGURAR PUERTO DE COMNICACION SERIAL
;Y = 0 PARA COM1, = 1 PARA COM2
COM     MACRO   Y
        MOV     AH,00           ;SERVICIO PARA CONFIGURACION DE PUERTO
        MOV     AL,11100011B    ;9600 BPS, NO PARIDAD, 1 BIT DE PARADA
        MOV     DX,Y
        INT     14H
        ENDM

;MACRO PARA VISUALIZAR MENSAJE POR PANTALLA
MENSAJE	MACRO	MENS
	MOV	AH,09H
	MOV	DX,OFFSET MENS
	INT	21H
	ENDM
;****************************************************************

         .CODE

        ORG     000
        MOV     AX,@DATA
        MOV     DS,AX
        JMP     MAIN

;****************************************************************
;RUTINA QUE RECIBE UN DATO SERIALMENTE EN AL Y LO ALMACENA EN RXDATO
RX:     PUSHA           ;GUARDAR EN LA PILA TODOS LOS REGISTROS
        MOV     AH,02   ;SERVICIO DE LECTURA POR EL PUERTO SERIAL
        MOV     DX,00   ;SELECCIONAR COM1
        INT     14H
        MOV     RXDATO,AL  ;ALMACENAR DATO RECIBIDO EN RXDATO
        POPA               ;RECUPERAR DE LA PILA TODOS LOS REGISTROS
        RET
;****************************************************************

;****************************************************************
; RUTINA PARA VISUALIZAR EL DATO RECIBIDO POR PANTALLA
VISUAL:  PUSHA          ;GUARDAR EN LA PILA TODOS LOS REGISTROS
         MOV    AL,RXDATO
         CMP    AL,00H  ;SI NO LLEGA NINGUN CARACTER AL=00H
         JE     SALIR
         MOV    DL,AL
         MOV    AH,02   ;SERVICIO PARA MOSTRAR CARACTER POR PANTALLA
         INT    21H
SALIR:   POPA           ;RECUPERAR DE LA PILA TODOS LOS REGISTROS
         RET
;****************************************************************

;****************************************************************
;RUTINA PARA ESCANEAR EL TECLADO
TECLA:   MOV    AH,06   ;CODIGO ASCII DE TECLA SE ALMACENA EN AL
         MOV    DL,0FFH
         INT    21H
         RET
;****************************************************************

;*****************************************************
;PROGRAMA PRINCIPAL
MAIN:   MENSAJE	MINICIO
	COM     00      ;CONFIGURAR PUERTO SERIAL COM1
MAIN2:  CALL    RX      ;RECIBIR CARACTER SERIALMENTE
        CALL    VISUAL  ;VISUALIZAR CARACTER RECIBIDO POR PANTALLA
MAIN1:  CALL    TECLA   ;ESCANEAR TECLADO
        CMP     AL,1BH  ;TECLA 'ESC' PARA TERMINAR
        JE      FIN
        JMP     MAIN2   ;REPITA EL CICLO
FIN:    MOV     AH,4CH  ;FINALIZAR PROGRAMA
        INT     21H
;****************************************************************

        END

ÿ
ÿ
