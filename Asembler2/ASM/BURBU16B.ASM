;ELABORADO POR: JAIRO VERGARA DIAZ
;UNIVERSIDAD DE MEDELLIN
;ALGORITMO BURBUJA PARA DATOS DE 16 BITS
;PARA PROBAR EL ALGORITMO PUEDE CAMBIAR LOS VALORES DE LOS DATO1 a DAT10 LOS CUALES SON LOS
;QUE SE ORDENAN DE FORMA ASCENDENTE O DESCENDENTE
;EL VECTOR POSI TIENE ALMACENADO LOS INDICES QUE DESPUES DE REALIZAR EL METODO BURBUJA SE VERAN
;AFECTADAS Y MOSTRARAN EL ORDEN DEFINITIVO DE LOS INDICES


                .MODEL  SMALL
                .STACK
                .386

                .DATA
ASCVAL          DB      5 DUP(00H),'-','$'
BINVAL          DW      0000

MEN1		DB	'VALORES ANTES DE ORDENAR: ',10,13,'$'
MEN3		DB	10,13,'POSICIONES ANTES DE ORDENAR: ',10,13,'$'
MEN2		DB	10,13,'VALORES DESPUES DE ORDENAR: ',10,13,'$'
MEN4		DB	10,13,'POSICIONES DESPUES DE ORDENAR: ',10,13,'$'

DAT01		DW	4000	;0FA0H
DAT02		DW	10000	;2710H
DAT03		DW	10	;5BA0H
DAT04		DW	65530	;05DCH
DAT05		DW	3000	;0BB8H
DAT06		DW	5000	;0BB8H
DAT07		DW	1000	;0BB8H
DAT08		DW	6000	;0BB8H
DAT09		DW	8000	;0BB8H
DAT10		DW	9000	;0BB8H


TEMP		DW	?

VECTOR		DW	10 DUP (0000)

POSI		DW	'0','1','2','3','4','5','6','7','8','9','$'


;******************************************************
LLENAR_VECTOR	MACRO	Y,POS
		MOV 	SI,POS
		MOV	AX,DAT&Y
		MOV	VECTOR[SI],AX
		ENDM
;******************************************************

;******************************************************
GET_VIS_VECTOR	MACRO	POS
		MOV 	SI,POS
		MOV	AX,VECTOR[SI]
		MOV	BINVAL,AX
                CALL    BINASCII
		MACROMENSAJE	ASCVAL
		ENDM
;******************************************************

;******************************************************
MACROMENSAJE	MACRO	M           
		MOV	AH,09H
		MOV	DX,OFFSET M
		INT	21H
		ENDM
;******************************************************
		
		.CODE
                ORG     0000
                JMP     MAIN

;****************************************************
INICIO:         MOV     AX,@DATA
                MOV     DS,AX
                RET
;****************************************************

;****************************************************
BINASCII:       LEA     SI,ASCVAL
                MOV     CX,5
                MOV     AL,00H
C10:            MOV     [SI],AL
                INC     SI
                LOOP    C10
                MOV     CX,10
                LEA     SI,ASCVAL+4
                MOV     AX,BINVAL
C20:            CMP     AX,CX
                JB      C30
                XOR     DX,DX
                DIV     CX
                OR      DL,30H
                MOV     [SI],DL
                DEC     SI
                JMP     C20
C30:            OR      AL,30H
                MOV     [SI],AL
                RET
;******************************************************

;****************************************************
BURBUJA_16BITS:	MOV	SI,0
		MOV	DI,0
		MOV	CX,10
CICLOBURB0:	MOV	DI,SI
CICLOBURB1:	ADD	DI,2
		CMP	DI,20
		JE	FINPARADI
		
		MOV	AX,VECTOR[SI]
		CMP	AX,VECTOR[DI]
		JA	CICLOBURB1		;DESCENDENTE
		;JBE	CICLOBURB1		;ASCENDENTE
		
		MOV	TEMP,AX			;POSICION SI A TEMP
		MOV	AX,VECTOR[DI]		
		MOV	VECTOR[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMP
		MOV	VECTOR[DI],AX		;INTERCAMBIO POSICION
		
		MOV	AX,POSI[SI]
		MOV	TEMP,AX			;POSICION SI A TEMP
		MOV	AX,POSI[DI]		
		MOV	POSI[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMP
		MOV	POSI[DI],AX		;INTERCAMBIO POSICION
		
		JMP	CICLOBURB1
		
FINPARADI:	ADD	SI,2		
		LOOP	CICLOBURB0
		RET
;****************************************************


;******************************************************
MAIN:           CALL    INICIO

		LLENAR_VECTOR	01,0	;DAT01 EN POSICION 0
		LLENAR_VECTOR	02,2	;DAT02 EN POSICION 2
		LLENAR_VECTOR	03,4	;DAT03 EN POSICION 4
		LLENAR_VECTOR	04,6	;DAT04 EN POSICION 6
                LLENAR_VECTOR   05,8    ;DAT05 EN POSICION 8
		LLENAR_VECTOR	06,10	;DAT06 EN POSICION 10
		LLENAR_VECTOR	07,12	;DAT07 EN POSICION 12
		LLENAR_VECTOR	08,14	;DAT08 EN POSICION 14
		LLENAR_VECTOR	09,16	;DAT09 EN POSICION 16
		LLENAR_VECTOR	10,18	;DAT010 EN POSICION 18
		
		MACROMENSAJE	MEN1
		GET_VIS_VECTOR	0
		GET_VIS_VECTOR	2
		GET_VIS_VECTOR	4
		GET_VIS_VECTOR	6
		GET_VIS_VECTOR	8
		GET_VIS_VECTOR	10
		GET_VIS_VECTOR	12
		GET_VIS_VECTOR	14
		GET_VIS_VECTOR	16
		GET_VIS_VECTOR	18
		
		MACROMENSAJE	MEN3
		MACROMENSAJE	POSI
		
		CALL	BURBUJA_16BITS

		MACROMENSAJE	MEN2
		GET_VIS_VECTOR	0
		GET_VIS_VECTOR	2
		GET_VIS_VECTOR	4
		GET_VIS_VECTOR	6
		GET_VIS_VECTOR	8
		GET_VIS_VECTOR	10
		GET_VIS_VECTOR	12
		GET_VIS_VECTOR	14
		GET_VIS_VECTOR	16
		GET_VIS_VECTOR	18

		MACROMENSAJE	MEN4
		MACROMENSAJE	POSI
		
                MOV     AH,4CH
                INT     21H

                END
