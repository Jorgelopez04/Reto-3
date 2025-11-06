       .MODEL  SMALL
       .386
       .CODE

        NOP
        NOP

        MOV     AX,1850
        MOV     BX,01FFH
        ADD     AX,BX
        MOV     CX,0AF28H
        MOV     DH,05H
        MOV     DL,0FFH
        SUB     CX,DX
        MOV     AX,0
        MOV     AX,50
        END
