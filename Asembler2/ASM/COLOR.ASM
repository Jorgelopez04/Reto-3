;********RUTINA PARA DEFINIR ATRIBUTO DE COLOR E INTERMITENCIA*****
;BH(2,1,0)--> TEXTO
;BH(6,5,4)--> FONDO
;BH(3)--> INTENSIDAD
;BH(7)--> INTERMITENCIA SI=1,ACTIVO ; SI=0, INACTIVO
;BH(3,2,1,0)
;   0 0 0 0     NEGRO
;   0 0 0 1     AZUL
;   0 0 1 0     VERDE
;   0 0 1 1     CIAN
;   0 1 0 0     ROJO
;   0 1 0 1     MAGENTA
;   0 1 1 0     CAFE
;   0 1 1 1     BLANCO
;   1 0 0 0     GRIS
;   1 0 0 1     AZUL CLARO
;   1 0 1 0     VERDE CLARO
;   1 0 1 1     CIAN CLARO
;   1 1 0 0     ROJO CLARO
;   1 1 0 1     MAGENTA CLARO
;   1 1 1 0     AMARILLO
;   1 1 1 1     BLANCO BRILLANTE

COLOR:  MOV     AH,06H
        MOV     AL,00H              ;toda la pantalla
        MOV     BH,00110100B        ;Atributo de color bit7: Intermitencia
        MOV     CX,0000H            ;Posicion Inicial
        MOV     DX,0F2FH            ;Posicion Final
        INT     10H
        RET
