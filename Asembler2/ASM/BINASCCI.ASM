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
BINVAL          DW      0000

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

;******************************************************
MAIN:           CALL    INICIO
                MOV     BINVAL,0FFFFH
                CALL    BINASCII
		MOV	AH,09H
		MOV	DX,OFFSET ASCVAL
		INT	21H
                MOV     AH,4CH
                INT     21H

                END
