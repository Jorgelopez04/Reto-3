.MODEL  SMALL
.386
.DATA

MENU    DB        '                 ษอออออออออออออออออออออออออออออออออออออป',10,13
        DB        '                 บ            MENU PRINCIPAL           บ',10,13
        DB        '                 ศอออออออออออออออออออออออออออออออออออออผ',10,13
        DB        '                 ษอออออออออออออออออออออออออออออออออออออป',10,13
        DB        '                 บ [1] REGISTRAR VISITA                บ',10,13
        DB        '                 บ [2] VERIFICAR VISITA A MEDICO       บ',10,13
        DB        '                 บ [3] LISTA DE MEDICOS                บ',10,13
        DB        '                 บ [4] LISTA DE PRODUCTOS              บ',10,13
        DB        '                 บ [5] SALIR                           บ',10,13
        DB        '                 บ                                     บ',10,13
        DB        '                 บ ___                                 บ',10,13
        DB        '                 บ                                     บ',10,13                
        DB        '                 ศอออออออออออออออออออออออออออออออออออออผ',10,13,'$'


FOO		DB		  'BIEN',10,13,'$'

OPMENU	DB		  'OPCION:$'



MIDVIS	DB	'INGRESE SU CODIGO DE IDENTIFICACION:$'
MIDMED	DB	'INGRESE EL CODIGO DEL MEDICO A VISISTAR:$'
MPROD	DB	'INGRESE CODIGO PRODUCTO:$'
PPRO	DB	'DESEA INGRESAR OTRO PRODUCTO (S/N):$'

SALTO	DB	10,13,'$'








LECTURA	DB	23 DUP('0')

.STACK

.CODE
ORG    000
MOV     AX,@DATA
MOV     DS,AX
JMP MAIN


;MACROS MOSTRAR MENSAJES
SMSG	MACRO	MENS
		MOV	AH,09H
		MOV	DX,OFFSET MENS
		INT	21H
ENDM

MOSTRAR	MACRO	MEN
		MOV	AH,02H
		MOV	DX,MEN
		INT	21H
ENDM
MOST2	MACRO	DEC1,UNI1
		MOV	AH,02H
		MOV	DX,DEC1
		INT	21H
		MOV	AH,02H
		MOV	DX,UNI1
		INT	21H
ENDM
;FIN MACROS MOSTRAR MENSAJES


;MACRO PERMITIR COPIAR N TECLAS


LETN	MACRO	NUMTEC
	LOCAL	SIGUIEN,SIC
	MOV	CX,16
	MOV	SI,0
SIC:	MOV	LECTURA[SI],0
	INC	SI
	LOOP	SIC
	MOV	SI,0
	MOV	CX,NUMTEC
SIGUIEN:
	MOV	AH,01H
	INT	21H
	MOV	LECTURA[SI],AL
	INC	SI
	LOOP	SIGUIEN
	MOV	LECTURA[SI],'$'	


ENDM


;FIN MACRO PERMITIR COPIAR N TECLAS

;RUTINA PARA ESCANEAR EL TECLADO
TECLA:   MOV    AH,01   ;CODIGO ASCII DE TECLA SE ALMACENA EN AL
         MOV    DL,0FFH
         INT    21H

MEN1:
		MOV	AH,09H
		MOV	DX,OFFSET FOO
		INT	21H
		RET


MEN2:
		MOV	AH,09H
		MOV	DX,OFFSET OPMENU
		INT	21H
		RET

        
FIN:	MOV	AX,4C00H
     	INT	21H
     	RET
        
COLOR: 	MOV     AH,06H
        MOV     AL,00H
        MOV     BH,011110000B
        MOV     CX,0000H
        MOV     DX,8F8FH
        INT     10H
        RET
        
CURSOR	MACRO FILA,COL
		PUSH AX
		PUSH BX
		PUSH DX
		MOV AH, 02H
		MOV DH, FILA
		MOV DL, COL
		MOV BH, 0
		INT 10H
		POP DX
		POP BX
		POP AX
ENDM        


VISITA:
		CURSOR	20,16
		SMSG	MIDVIS
		LETN	10
		RET

MAIN:
		CALL	COLOR
		CURSOR	4,0
        SMSG	MENU
        CURSOR	14,20
        CALL	TECLA
        CMP		AL,'1'
        JB		VISITA
        CALL	FIN
END
ÿ
