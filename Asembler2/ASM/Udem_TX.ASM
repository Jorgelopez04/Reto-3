;PROGRAMA REALIZADO POR: JAIRO VERGARA
;COMUNICACION SERIAL
;TRANSMITIR CADENA DE CARACTERES POR EL PUERTO SERIAL

        .MODEL  SMALL
        .386
        .STACK

        .DATA
TXDATO  DB      10,13,'ARQUITECTURA DE COMPUTADORES'  ;CADENA A TRANSMITIR
        DB      '- UNIVERSIDAD DE MEDELLIN','*','$'

MINICIO	DB	'LA CADENA QUE ESTA TRANSMITIENDO SERIALMENTE ES: ',10,13,'$'

COM1    EQU     3F8H    ;PUERTO SERIAL COM1
MCR     EQU     3FCH    ;REG CONTROL DEL MODEM, BIT1=DTR, BIT0=DSR
LSR     EQU     3FDH    ;REG. ESTADO DE LINEA
MSR     EQU     3FEH    ;REG. ESTADO DEL MODEM

;********* MACROS *******************************************
;MACRO PARA CONFIGURAR PUERTO DE COMNICACION SERIAL
;Y = 0 PARA COM1, = 1 PARA COM2
COM     MACRO   Y
        MOV     AH,00           ;SERVICIO DE CONFIGURACION PUERTO SERIAL
        MOV     AL,11100011B    ;9600 BPS, NO PARIDAD, 1 BIT DE PARADA
        MOV     DX,Y
        INT     14H
        ENDM

;MACRO PARA VISUALIZAR MENSAJE POR PANTALLA
MENSAJE	MACRO	MENS
	MOV	AH,09H
	MOV	DX,OFFSET MENS
	INT	21H
	ENDM
;****************************************************************

         .CODE

        ORG     000
        MOV     AX,@DATA
        MOV     DS,AX
        JMP     MAIN

;***********************************************************
;SUBRUTINA DE TRANSMISION DE UNA CADENA DE CARACTERES
TX:      PUSHA
         MOV    SI, OFFSET TXDATO
TXD:     MOV    DX,MCR         ;TRANSMISOR LISTO PARA COMUNICARSE
         MOV    AL,00000011B
         OUT    DX,AL
         MOV    DX,MSR          ;VERIFICAR SI EL RECEPTOR ESTA LISTO
         MOV    CX,2FFFH
NOLISTO: IN     AL,DX
         AND    AL,00110000B
         CMP    AL,00110000B
         JZ     LISTO
         LOOP   NOLISTO
LISTO:   MOV    DX,LSR          ;VERIFICAR SI REGISTRO DE TRANSMISION
         MOV    CX,2FFFH        ;ESTA VACIO
NVACIO:  IN     AL,DX
         TEST   AL,5
         JNZ     VACIO
         LOOP   NVACIO
VACIO:   MOV    DX,COM1         ;CARGAR BYTE A TRANSMITIR EN EL REGISTRO THR
         MOV    AL,[SI]
         OUT    DX,AL
         INC    SI               ;DIRECCIONAR PUNTERO PROXIMO DATO
         MOV    AL,'*'           ;CARACTER DE CONTROL DE FIN DE TRAMA
         CMP    AL,[SI]
         JNZ    TXD
         MOV    SI,OFFSET TXDATO ;INICIALIZAR PUNTERO DE MEMORIA DE DATOS
         POPA
         RET
;***********************************************************

;***********************************************************
TECLA:   MOV    AH,06           ;CODIGO ASCII DE TECLA SE ALMACENA EN AL
         MOV    DL,0FFH
         INT    21H
         RET
;***********************************************************

;***********************************************************
;PROGRAMA PRINCIPAL
MAIN:   MENSAJE	MINICIO
	MENSAJE	TXDATO
	COM     00      ;CONFIGURAR PUERTO SERIAL COM1
MAIN2:  CALL    TX      ;TRANSMITIR CADENA DE CARACTERES
MAIN1:  CALL    TECLA   ;ESCANEO DE TECLADO
        CMP     AL,1BH  ;TECLA 'ESC' PARA SALIR
        JE      FIN
        JMP     MAIN2
FIN:    MOV     AH,4CH  ;SERVICIO PARA FINALIZAR PROGRAMA
        INT     21H
;***********************************************************

        END

ÿ
ÿ
