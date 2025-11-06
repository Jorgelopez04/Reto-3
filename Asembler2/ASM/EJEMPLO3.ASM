        .MODEL  SMALL
        .386
        .CODE
        MOV     AX,@DATA
        MOV     DS,AX
        MOV     DX,OFFSET TEXTO
        MOV     AH,9
        INT 21H
        MOV     AX,4C00H
        INT 21H
        .DATA
        TEXTO DB 'HOLA COMO ESTAS.$'
        .STACK
        END
