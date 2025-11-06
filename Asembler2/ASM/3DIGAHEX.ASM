;PROGRAMA QUE RECIBE UN NUMERO DE TRES DIGITOS EN ASCII Y HACE LA
;CONVERSION A HEXADECIMAL, LA CONVERSION QUEDA EN LA VARIABLE NUM

        .MODEL  SMALL
        .386
        .STACK

        .DATA
NUM     DW      0000H

        .CODE
        ORG     0000
        JMP     MAIN

INICIO: MOV     AX,@DATA
        MOV     DS,AX
        RET

INGRESO:
        MOV     AH,01H
        INT     21H     ;CENTENA
        AND     AX,0FH
        MOV     DX,AX
        MOV     AX,100
        MUL     DX
        MOV     NUM,AX
        MOV     AH,01H  ;DECENA
        INT     21H
        AND     AX,0FH
        MOV     DX,AX
        MOV     AX,10
        MUL     DX
        ADD     NUM,AX
        MOV     AH,01H
        INT     21H     ;UNIDAD
        AND     AX,000FH
        ADD     NUM,AX
        MOV     BX,NUM
        RET

SALIR:  MOV     AH,4CH
        INT     21H

MAIN:   CALL    INICIO
        CALL    INGRESO
        JMP     SALIR

        END






