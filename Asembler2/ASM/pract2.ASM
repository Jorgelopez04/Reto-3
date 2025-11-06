;                     UNIVERSIDAD DE MEDELLIN
;             	       Ingenieria de Sistemas

;**************************************************************************
; Asignatura         :   Arquitectura de Computadores
; Nombre del programa:   Pract1.ASM
; Autor              :   Jairo. M. Vergara
; Máquina            :   Computador compatible 80486
; Objetivo           :   Despliega un mensaje en el monitor.
;                        Programa escrito con el fin de mostrar
;                        la forma de presentar los informes
;**************************************************************************

; --------------------------------------------------------------------
; ZONA DE DECLARACIONES Y COMANDOS GENERALES
; --------------------------------------------------------------------
	.MODEL	SMALL          ; Modelo de memoria corto

; --------------------------------------------------------------------
; SEGMENTO DE CODIGO DEL PROGRAMA
; --------------------------------------------------------------------
	.CODE                    ; Area de código
	
	ORG	000
	JMP	MAIN

	
FIN:	MOV	AX,4C00H
     	INT	21H

INICIO: MOV	AX,@DATA            ; Permite el acceso a los datos inicializando
	MOV	DS,AX               ; el registro DS con la dirección adecuada.
	RET

;********RUTINA PARA DEFINIR ATRIBUTO DE COLOR E INTERMITENCIA*****
COLOR:  MOV     AH,06H
        MOV     AL,00H              ;toda la pantalla
        MOV     BH,00110100B        ;Atributo de color bit7: Intermitencia
        MOV     CX,0000H            ;Posicion Inicial
        MOV     DX,0F2FH            ;Posicion Final
        INT     10H
        RET

MOST_MENS1:
	MOV	AH,09H
	MOV	DX,OFFSET MENS1
	INT	21H
	RET

MOST_MENS2:
	MOV	AH,09H
	MOV	DX,OFFSET MENS2
	INT	21H
	RET

MOST_MENS3:
	MOV	AH,09H
	MOV	DX,OFFSET MENS3
	INT	21H
	RET

MOST_RESUL:
	MOV	AH,09H
	MOV	DX,OFFSET RESUL
	INT	21H
	RET

OPER_SUMA:
	CALL	MOST_MENS1
	MOV	AH,01H
	INT	21H
        MOV     DAT1,AL
	CALL	MOST_MENS2
        MOV     AH,01H
	INT	21H
        MOV     AH,00H
	ADD	AL,DAT1
        AAA                     ;AJUSTE ASCII DESPUES DE SUMA
        OR      AX,3030H        ;CONVERSION A ASCII
	MOV	UNI,AL
        MOV     DECE,AH
	RET
	
VISUALIZAR:
	CALL	MOST_RESUL
	MOV	AH,02H
        MOV     DL,DECE
	INT	21H
	MOV	DL,UNI
	INT	21H
	CALL	MOST_MENS3
	RET

CHEQUEO_SALIR:
	MOV	DL,0FFH
	MOV	AH,06H
	INT	21H
	CMP	AL,'Q'
        JE      FIN
	CMP	AL,'S'
	JE	MAIN1
	JMP	CHEQUEO_SALIR


MAIN:	CALL	INICIO
        CALL    COLOR
MAIN1:	CALL	OPER_SUMA
	CALL	VISUALIZAR
	JMP	CHEQUEO_SALIR
; --------------------------------------------------------------------
; SEGMENTO DE DATOS DEL PROGRAMA
; --------------------------------------------------------------------
	.DATA                     ; Segmento de datos

	MENS1	DB	10,13,'INGRESE EL PRIMER NUMERO = ','$'
	MENS2	DB	10,13,'INGRESE EL SEGUNDO NUMERO = ','$'
	RESUL	DB	10,13,'LA SUMA ES = ','$'
	MENS3	DB	10,13,'DIGITE "Q" PARA SALIR O "S" PARA CONTINUAR','$'
	DAT1	DB	?
	UNI	DB	?
        DECE    DB      ?
; --------------------------------------------------------------------
; SEGMENTO DE PILA DEL PROGRAMA Y FINALIZACION
; --------------------------------------------------------------------
	.STACK                   ; Se necesita una PILA.
	END                      ; Fin del programa

;**************************************************************************
ÿ
