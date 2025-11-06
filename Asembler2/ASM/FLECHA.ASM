;               INGENIERIA EN INSTRUMENTACION Y CONTROL
;                       SISTEMAS DIGITALES III

;PROGRAMA     :    CONTROL ON-OFF
;REALIZADO POR:    RICARDO  MU¥OZ JARAMILLO
;                  LEONARDO ZULUAGA PELAEZ
;                  WILFREDO MU¥OZ JARAMILLO
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;ZONA DE DECLARACION Y COMANDOS GENERALES
        .MODEL          SMALL
        .STACK          64

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; SEGMENTO DE CODIGO DE PROGRAMA

        .CODE
        ORG             0000
        JMP             PPAL          ;SALTA AL PROGRAMA PPAL

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;AREA SUBRUTINAS

CURSOR  MACRO           FILA,COLUMNA      ;MACRO PARA POSICIONAR CURSOR
        MOV             AH,02H            ;PETICION PARA  COLOCAR EL CURSOR
        MOV             BH,00             ;PAGINA 0
        MOV             DH,FILA           ;RENGLON
        MOV             DL,COLUMNA        ;COLUMNA
        INT             10H               ;INT QUE LLAMA AL BIOS
        ENDM

;-----------------------------------------------------------------
TEXTO   MACRO           MENSAJE           ;MACRO PARA PONER TEXTO
        MOV             DX,OFFSET MENSAJE
        MOV             AH,09             ;SERVICIO
        INT             21H               ;INTERRUPCION
        ENDM

;-----------------------------------------------------------------
                                          ;RECORRE PANTALLA PARA CAMBIO
COLOR:  MOV             AX,0600H          ;DE COLOR
        MOV             BH,17H            ;ATRIBUTO, AZUL(1) BLANCO(7)
        MOV             CX,0000H          ;ESQUINA SUPERIOR
        MOV             DX,184FH          ;ESQUINA INFERIOR
        INT             10H
        RET

COLOR1: MOV             AX,0600H
        MOV             BH,1CH
        MOV             CX,0110H
        MOV             DX,0156H
        INT             10H
        RET
COLOR2: MOV             AX,0600H
        MOV             BH,15H
        MOV             CX,0708H
        MOV             DX,0719H
        INT             10H
        RET
;COLOR1: MOV             AX,0600H
        MOV             BH,14H
        MOV             CX,0809H
        MOV             DX,0819H
        INT             10H
        RET
COLOR3: MOV             AX,0600H
        MOV             BH,1AH
        MOV             CX,0B09H
        MOV             DX,0B19H
        INT             10H
        RET
COLOR4: MOV             AX,0600H
        MOV             BH,1BH
        MOV             CX,1802H
        MOV             DX,182AH
        INT             10H
        RET
COLOR5: MOV             AX,0600H
        MOV             BH,1EH
        MOV             CX,1130H
        MOV             DX,1248H
        INT             10H
        RET
;----------------------------------------------------------------
                                          ;MUESTRA DATO3
VER3:   MOV             AH,02H
        MOV             DL,DATO3
        INT             21H
        RET

VER4:   MOV             AH,02H            ;MUESTRA DATO4
        MOV             DL,DATO4
        INT             21H
        RET

VER1:   MOV             AH,02H            ;MUESTRA DATO1
        MOV             DL,DATO1
        INT             21H
        RET

VER2:   MOV             AH,02H            ;MUESTRA DATO2
        MOV             DL,DATO2
        INT             21H
        RET

;----------------------------------------------------------------

MENSA   PROC            NEAR             ;SUBRUTINA PARA COLOCAR MENSAJES
        CALL            COLOR1
        CALL            COLOR5
        CURSOR          01,25             ;POSICIONA CURSOR
        TEXTO           MENSAJE1          ;MUESTRA MENSAJE
        CURSOR          02,25
        TEXTO           RAYADO
        CURSOR          07,15
        CALL            COLOR2
        TEXTO           MENSAJE2
        CURSOR          08,15
        CALL            COLOR3
        TEXTO           MENSAJE3
        CALL            COLOR4
        CURSOR          11,15
        TEXTO           MENSAJE4
        CURSOR          14,05
        TEXTO           MENSAJE5
        CURSOR          16,05
        TEXTO           MENSAJE6
        CURSOR          17,05
        TEXTO           MENSAJE7
        CURSOR          18,05
        TEXTO           MENSAJE8
        CURSOR          17,60
        TEXTO           MENSAJE9
        CURSOR          21,05
        TEXTO           MENSAJE10
        CURSOR          22,05
        TEXTO           MENSAJE11
        CURSOR          23,05
        TEXTO           MENSAJE12
        CURSOR          24,05
        TEXTO           MENSAJE13
        CURSOR          18,58
        TEXTO           MENSAJE14
        CURSOR          18,63
        TEXTO           MENSAJE14
        RET
MENSA   ENDP

;------------------------------------------------------------------

TIEMPO: MOV             AH,2CH               ;SUBRUTINA PARA LA HORA
        INT             21H
        MOV             HORAS,CH
        MOV             MINUTOS,CL
        MOV             SEGUNDOS,DH
        CURSOR          18,55
        MOV             AL,HORAS
        XOR             AH,AH
        CALL            MOSTR
        CURSOR          18,60
        MOV             AL,MINUTOS
        XOR             AH,AH
        CALL            MOSTR
        CURSOR          18,65
        MOV             AL,SEGUNDOS
        XOR             AH,AH
        CALL            MOSTR
        RET

MOSTR:  XOR             CX,CX
        MOV             BX,10
CICLO:  XOR             DX,DX
        DIV             BX
        PUSH            DX
        INC             CX
        OR              AX,AX
        JNZ             CICLO
CICLO2: MOV             DH,00H
        POP             DX
        MOV             AH,6H
        ADD             DL,30H
        MOV             DH,00H
        INT             21H
        LOOP            CICLO2
        RET

;-------------------------------------------------------------

SALIR:
                                      ;SUBRUTINA PARA SALIR DEL PROGRAMA
        CURSOR          25,01
        MOV             AX,4C00H
        INT             21H
        RET


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SALE:   JMP             SALIR
PPAL:   MOV             AX,@DATA      ;DEFINE SEGMENTO DE DATOS
        MOV             DS,AX
        MOV             ES,AX
        CALL            COLOR         ;LLAMA SUBRUTINA COLOR
        CALL            MENSA         ;LLAMA SUBRUTINA MENSAJES

LEE1:  
        CURSOR          08,27
        MOV             AH,07H        ;LEE SETPOINT DATO1
        MOV             DL,0FFH
        INT             21H
        MOV             DATO1,AL
        AND             AL,30H        ;COMPARA SI ES CARACTER O NUMERO
        CMP             AL,30H
        JE              SIGUE
        JMP             LEE1

SIGUE:  CALL            VER1
        
LEE2:   CURSOR          08,28         ;LEE SETPOINT DATO2
        MOV             AH,07H
        MOV             DL,0FFH
        INT             21H
        MOV             DATO2,AL
        AND             AL,30H
        CMP             AL,30H        ;COMPARA SI ES CARACTER O NUMERO
        JE              SIGUE1
        JMP             LEE2

SIGUE1: CALL            VER2

        CURSOR          07,27
        MOV             DATO3,35H     ;INICIALIZA VARIABLE EN 55
        CALL            VER3
        CURSOR          07,28
        MOV             DATO4,35H
        CALL            VER4

LEER:   CALL            TIEMPO        ;LAMA SUBRUTINA TIEMPO PARA LA HORA
        MOV             AH,06H        ;ESCANEA TECLADO
        MOV             DL,0FFH
        INT             21H
        CMP             AL,'Q'        ;SI ES Q SALE DEL PROGRAMA
        JE              SALE
        CMP             AL,48H        ;DETECTA TECLA INCREMENTO
        JE              INCREM
        CMP             AL,50H        ;DETECTA TECLA DECREMENTO
        JE              DECREM
        JMP             COMPAR

INCREM: CMP             DATO4,39H
        JE              IDATO4        ;SALTE A INCREMENTE DATO3
        INC             DATO4         ;INCREMENTA DATO4
        CURSOR          07,28
        CALL            VER4
        JMP             LEER

IDATO4: MOV             DATO4,30H     ;INICIALIZA DATO4 CON 0
        CURSOR          07,28
        CALL            VER4
        CMP             DATO3,39H
        JE              MDATO3        ;SI ES 9 SALTE A MODIFIQUE DATO3
        INC             DATO3
        CURSOR          07,27
        CALL            VER3
        JMP             LEER

MDATO3: MOV             DATO3,30H     ;INICIALIZA DATO3
        CURSOR          07,27
        CALL            VER3
        JMP             LEER
;------------------------------------------------------------------------

DECREM: CMP             DATO4,30H
        JE              DDATO4        ;SALTE A DECREMENTE DATO3
        DEC             DATO4
        CURSOR          07,28
        CALL            VER4
        JMP             LEER

DDATO4: MOV             DATO4,39H     ;INICIALIZA DATO4 CON 9
        CURSOR          07,28
        CALL            VER4
        CMP             DATO3,30H
        JE              CDATO3        ;SI ES 9 SALTE A CAMBIE DATO3
        DEC             DATO3
        CURSOR          07,27
        CALL            VER3
        JMP             LEER

CDATO3: MOV             DATO3,39H     ;INICIALIZA DATO4
        CURSOR          07,27
        CALL            VER3
        JMP             LEER


COMPAR: MOV             AL,DATO1      ;COMPARA VARIABLE Y SET POINT
        CMP             DATO3,AL      ;Y DA UNA SALIDA
        JG              OFF           ;SI D3 MAYOR D1, VA OFF
        JL              ON            ;SI D3 MENOR D1, VA ON
        MOV             AL,DATO2
        CMP             DATO4,AL
        JG              OFF           ;SI D4 MAYOR D2, VA OFF
        JL              ON            ;SI D4 MENOR D2, VA ON
        CURSOR          11,27
        TEXTO           MENSAJE20     ;MUESTRA OFF
        JMP             LEER

ON:     CURSOR          11,27         ;MUESTRA ON
        TEXTO           MENSAJE18
        JMP             LEER

OFF:    CURSOR          11,27         ;MUESTRA OFF
        TEXTO           MENSAJE19
        JMP             LEER


;SEGMENTO DE DATOS DEL PROGRAMA
;-------------------------------------------------------------------------

        .DATA
        RAYADO          DB      '---------------------------','$'
        MENSAJE1        DB      'SIMULADOR DE CONTROL ON-OFF','$'
        MENSAJE2        DB      'VARIABLE  :','$'
        MENSAJE3        DB      'SET POINT :','$'
        MENSAJE4        DB      'SALIDA    :','$'
        MENSAJE5        DB      'REALIZADO POR:','$'
        MENSAJE6        DB      'RICARDO MU¥OZ JARAMILLO','$'
        MENSAJE7        DB      'LEONARDO ZULUAGA PELAEZ','$'
        MENSAJE8        DB      'WILFREDO MU¥OZ JARAMILLO','$'
        MENSAJE9        DB      'HORA','$'
        MENSAJE10       DB      'ENTRE VALOR DEL SET POINT','$'
        MENSAJE11       DB      'INCREMENTA VBLE FLECHA ARRIBA','$'
        MENSAJE12       DB      'DECREMENTA VBLE FLECHA ABAJO','$'
        MENSAJE13       DB      'PRESIONE "Q" PARA SALIR','$'
        MENSAJE14       DB      ':','$'
        MENSAJE18       DB      ' ON','$'
        MENSAJE19       DB      'OFF','$'
        MENSAJE20       DB      'OFF','$'
        DATO1           DB      ?
        DATO2           DB      ?
        DATO3           DB      ?
        DATO4           DB      ?
        HORAS           DB      ?
        MINUTOS         DB      ?
        SEGUNDOS        DB      ?
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;SEGMENTO DE PILA DEL PROGRAMA Y FINALIZACION
        .STACK
        END
