                .MODEL  SMALL
                .386
                .CODE
                MOV     AX,0123
                ADD     AX,0025         ;SUMAR EL VALOR 0025H A AX
                MOV     BX,AX           ;MOVER CONTENIDO DE AX A BX
                ADD     BX,AX           ;MOVER EL CONTENIDO DE AX A BX
                MOV     CX,BX           ;MOVER EL CONTENIDO DE BX A CX
                SUB     CX,AX           ;RESTAR EL CONTENIDO DE AX AL DE CX
                SUB     AX,AX           ; LIMPIAR AX
                NOP                     ;NO OPERAR (NO HACER NADA)
                END
