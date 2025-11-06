        .MODEL  SMALL
        .386
        .STACK
        .DATA
NUME1   DB      00H
DENO1   DB      00H
NUME2   DB      00H
DENO2   DB      00H
NUM1    DB      00H
NUM2    DB      00H
RESULT  DB      00H
RESID   DB      01H
MCD     DB      00H
UNIMCD  DB      00H
MCM     DB      00H
DECMCM  DB      00H
UNIMCM  DB      00H
K1      DB      00H
K2      DB      00H
K3      DB      00H
K4      DB      00H
K5      DB      00H
UNISUM  DB      00H
DECSUM  DB      00H
MENS1   DB      10,13,'EL MCD ES = ','$'
MENS2   DB      10,13,'EL MCM ES = ','$'
MENS3   DB      10,13,'INGRESE EL NUMERADOR 1   = ','$'
MENS4   DB      10,13,'INGRESE EL DENOMINADOR 1 = ','$'
MENS5   DB      10,13,'INGRESE EL NUMERADOR 2   = ','$'
MENS6   DB      10,13,'INGRESE EL DENOMINADOR 2 = ','$'
MENS7   DB      10,13,'LA SUMA ES = ','$'
MENS8   DB      10,13,'LA RESTA ES = ','$'
DIVI    DB      ' / ','$'
        .CODE
        ORG     000
        JMP     MAIN

INICIO: MOV     AX,@DATA
        MOV     DS,AX
        RET

;***********************************************************
RUT_MCD:
        MOV     RESID,01H
        MOV     AL,NUM1
        CMP     AL,NUM2
        JB      MENOR
CICLO1:
        MOV     AL,RESID
        CMP     AL,00H
        JE      EQUALCERO
        MOV     AH,00H
        MOV     AL,NUM1
        DIV     NUM2
        MOV     RESID,AH
        MOV     DL,NUM2
        MOV     NUM1,DL
        CMP     RESID,00H
        JNE     RES_EQUAL_CERO
        JMP     CICLO1

RES_EQUAL_CERO:
        MOV     DL,RESID
        MOV     NUM2,DL
        JMP     CICLO1

EQUALCERO:
        MOV     DL,NUM2
        MOV     MCD,DL
        OR      DL,30H
        MOV     UNIMCD,DL
        RET


MENOR:  MOV     AL,RESID
        CMP     AL,00H
        JE      EQUALCERO1
        MOV     AH,00H
        MOV     AL,NUM2
        DIV     NUM1
        MOV     RESID,AH
        MOV     DL,NUM1
        MOV     NUM2,DL
        CMP     RESID,00H
        JNE     RES_EQUAL_CERO1
        JMP     CICLO1

RES_EQUAL_CERO1:
        MOV     DL,RESID
        MOV     NUM1,DL
        JMP     CICLO1

EQUALCERO1:
        MOV     DL,NUM1
        MOV     MCD,DL
        OR      DL,30H
        MOV     UNIMCD,DL
        RET
;***********************************************************

;***********************************************************
RUT_MCM:
        MOV     MCM,00H
        MOV     AL,DENO1
        MOV     NUM1,AL
        MOV     AL,DENO2
        MOV     NUM2,AL
        MOV     AH,00H
        MOV     AL,NUM1
        MUL     NUM2
        DIV     MCD
        MOV     MCM,AL
        AAM
        OR      AX,3030H
        MOV     DECMCM,AH
        MOV     UNIMCM,AL
        RET
;***********************************************************

;***********************************************************
VISUAL_MCD_MCM:
        MOV     DX,OFFSET MENS1
        MOV     AH,09H
        INT     21H
        MOV     DL,UNIMCD
        MOV     AH,02H
        INT     21H
        MOV     DX,OFFSET MENS2
        MOV     AH,09H
        INT     21H
        MOV     DL,DECMCM
        MOV     AH,02H
        INT     21H
        MOV     AH,02H
        MOV     DL,UNIMCM
        INT     21H
        RET
;***********************************************************

;***********************************************************
CAPTURA:
        MOV     AH,09H
        MOV     DX,OFFSET MENS3
        INT     21H
        MOV     AH,01H
        INT     21H
        AND     AL,0FH
        MOV     NUME1,AL
        MOV     AH,09H
        MOV     DX,OFFSET MENS4
        INT     21H
        MOV     AH,01H
        INT     21H
        AND     AL,0FH
        MOV     DENO1,AL
        MOV     NUM1,AL
        MOV     AH,09H
        MOV     DX,OFFSET MENS5
        INT     21H
        MOV     AH,01H
        INT     21H
        AND     AL,0FH
        MOV     NUME2,AL
        MOV     AH,09H
        MOV     DX,OFFSET MENS6
        INT     21H
        MOV     AH,01H
        INT     21H
        AND     AL,0FH
        MOV     DENO2,AL
        MOV     NUM2,AL
        RET
;***********************************************************


;***********************************************************
SUMA:   MOV     AL,MCM
        MOV     AH,00H
        DIV     DENO1
        MOV     K1,AL
        MOV     AH,00H
        MOV     AL,MCM
        DIV     DENO2
        MOV     K2,AL
        MOV     AH,00H
        MOV     AL,K1
        MUL     NUME1
        MOV     K3,AL
        MOV     AH,00H
        MOV     AL,K2
        MUL     NUME2
        MOV     K4,AL
        ADD     AL,K3
        MOV     K5,AL   ;RESULTADO SUMA
        AAM
        OR      AX,3030H
        MOV     DECSUM,AH
        MOV     UNISUM,AL
        MOV     AH,09H
        MOV     DX,OFFSET MENS7
        INT     21H
        MOV     AH,02H
        MOV     DL,DECSUM
        INT     21H
        MOV     DL,UNISUM
        INT     21H
        MOV     AH,09H
        MOV     DX,OFFSET DIVI
        INT     21H
        MOV     AH,02H
        MOV     DL,DECMCM
        INT     21H
        MOV     DL,UNIMCM
        INT     21H
        RET
;***********************************************************

;***********************************************************
RESTA:  MOV     AL,MCM
        MOV     AH,00H
        DIV     DENO1
        MOV     K1,AL
        MOV     AH,00H
        MOV     AL,MCM
        DIV     DENO2
        MOV     K2,AL
        MOV     AH,00H
        MOV     AL,K1
        MUL     NUME1
        MOV     K3,AL
        MOV     AH,00H
        MOV     AL,K2
        MUL     NUME2
        MOV     K4,AL
        MOV     AL,K3
        SUB     AL,K4
        MOV     K5,AL   ;RESULTADO RESTA
        AAM
        OR      AX,3030H
        MOV     DECSUM,AH
        MOV     UNISUM,AL
        MOV     AH,09H
        MOV     DX,OFFSET MENS8
        INT     21H
        MOV     AH,02H
        MOV     DL,DECSUM
        INT     21H
        MOV     DL,UNISUM
        INT     21H
        MOV     AH,09H
        MOV     DX,OFFSET DIVI
        INT     21H
        MOV     AH,02H
        MOV     DL,DECMCM
        INT     21H
        MOV     DL,UNIMCM
        INT     21H
        RET
;***********************************************************

;***********************************************************
MAIN:   CALL    INICIO
        CALL    CAPTURA
        CALL    RUT_MCD
        CALL    RUT_MCM
        CALL    VISUAL_MCD_MCM
        CALL    SUMA
        CALL    RESTA
        MOV     AH,4CH
        INT     21H

        END
