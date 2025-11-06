       TITLE    DIVISION DE NUMEROS ASCII
                .MODEL  SMALL
                .CODE
                ORG     100H
        BEGIN:  JMP     SHORT MAIN
;++++++++++++++++++++++++++++++++++++++++++++++++++++
                DIVDND  DB      '4B2C'              ;DATOS
                DIVSOR  DB      'A'
                QUOTNT  DB      4  DUP(0)
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        MAIN    PROC    NEAR
                MOV     CX,4
                SUB     AH,AH
                AND     DIVSOR,0FH
                LEA     SI,DIVDND
                LEA     DI,QUOTNT
        A20:
                LODSB
                AND     AL,0FH
                AAD
                DIV     DIVSOR
                STOSB
                LOOP    A20
                INT     21H
        MAIN    ENDP
                END     BEGIN
