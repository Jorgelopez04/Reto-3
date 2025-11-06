;RUTINA DE CONVERSION DE BINARIO DE 16 BITS A ASCII
;EL VALOR BINARIO O HEX A CONVERTIR SE DEBE CARGAR EN BINVAL(16 BITS)
;LUEGO SE DEBE INVOCAR LA RUTINA BINASCII Y AL RETORNAR EL VALOR 
;CONVERTIDO EN ASCII QUEDA ALMACENADO EN EL VECTOR ASCVAL

;EJEMPLO SI:
;BINVAL=03FFH Y SE INVOCA BINASCII --> ASCVAL='1023'

                .MODEL  SMALL
                .STACK
                .386

                .DATA
ASCVAL          DB      5 DUP(00H),'$'
BINVAL          DW      4 DUP(00H),'$'
MENSAJE         DB      10,10,13,'INGRESE LOS NUMERO EN HEXAGESIMAL:   ','$'
MENSAJE1	DB	10,10,13,'EL VALOR EN ASCII ES:    ','$'
;VECTOR          DB      5 DUP(00H),'$'
                .CODE
                ORG     0000
                JMP     MAIN

;****************************************************
INICIO:         MOV     AX,@DATA
                MOV     DS,AX
                RET
;****************************************************

;****************************************************
VIS_MENS:
	MOV	AH,09H
	INT	21H
	RET
;****************************************************

;****************************************************
INGRESO:	MOV	AH,01H
		INT	21H
		RET
;******************************************************

;*****************************************************
LLENAR_BINVAL:
        	MOV	DI,0
                MOV     CX,4
                MOV     DX,OFFSET MENSAJE
	        CALL	VIS_MENS
CICLO:	        CALL	INGRESO
                MOV     BINVAL[DI],AL
	        INC	DI
	        LOOP	CICLO
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

;******************************************************
MAIN:           CALL    INICIO
                CALL    LLENAR_BINVAL
                CALL    BINASCII
		;MOV	AH,09H
		MOV	DX,OFFSET ASCVAL
		CALL	VIS_MENS
		;INT	21H
                MOV     AH,4CH
                INT     21H

                END
