;                     UNIVERSIDAD DE MEDELLIN
;                      Ingenieria de Sistemas
;
;**************************************************************************
; Asignatura         :   Arquitectura de Computadores
; Nombre del programa:   PRACTICA_DIVISION.ASM
; Autor              :   Jorge Steven Lopez Arenas
; Maquina            :   Computador compatible 80486
; Objetivo           :   Practica 1 - Mostrar un menu con las opciones
;                        DIVISION REAL, DIVISION ENTERA y MODULO. El
;                        programa pide dos numeros de un solo digito y
;                        muestra el resultado de la operacion elegida.
;**************************************************************************

        .MODEL  SMALL
        .386
        .STACK

        .DATA

N1      DB      ?               ;DIVIDENDO (0-9)
N2      DB      ?               ;DIVISOR   (0-9)
COCI    DB      ?               ;COCIENTE EN ASCII
RESI    DB      ?               ;RESIDUO EN ASCII
DEC1    DB      ?               ;PRIMER DECIMAL EN ASCII
DEC2    DB      ?               ;SEGUNDO DECIMAL EN ASCII

MENU    DB      10,13,'----------------------------------------',10,13
        DB      'MENU DE OPERACIONES',10,13
        DB      '1. DIVISION REAL',10,13
        DB      '2. DIVISION ENTERA',10,13
        DB      '3. MODULO',10,13
        DB      '----------------------------------------',10,13
        DB      'SELECCIONE UNA OPCION (1-3): $'

MN1     DB      10,13,'INGRESE EL DIVIDENDO (0-9): $'
MN2     DB      10,13,'INGRESE EL DIVISOR   (0-9): $'
MERRDIV DB      10,13,'ERROR: EL DIVISOR NO PUEDE SER 0',10,13,'$'
MERROPC DB      10,13,'OPCION INVALIDA',10,13,'$'

MRESR   DB      10,13,'RESULTADO (DIVISION REAL) = $'
MRESE   DB      10,13,'RESULTADO (DIVISION ENTERA) = $'
MRESM   DB      10,13,'RESULTADO (MODULO) = $'

MSALIR  DB      10,10,13,'DIGITE <S> PARA SALIR O CUALQUIER TECLA PARA CONTINUAR: $'

        .CODE
        ORG     0000
        JMP     MAIN

;****** INICIALIZAR EL SEGMENTO DE DATOS ***********
SEG_DAT:
        MOV     AX,@DATA
        MOV     DS,AX
        RET

;****** RUTINAS DE VISUALIZACION DE MENSAJES *******
VIS_MENU:
        MOV     DX,OFFSET MENU
        MOV     AH,09H
        INT     21H
        RET

VIS_MN1:
        MOV     DX,OFFSET MN1
        MOV     AH,09H
        INT     21H
        RET

VIS_MN2:
        MOV     DX,OFFSET MN2
        MOV     AH,09H
        INT     21H
        RET

VIS_ERRDIV:
        MOV     DX,OFFSET MERRDIV
        MOV     AH,09H
        INT     21H
        RET

VIS_ERROPC:
        MOV     DX,OFFSET MERROPC
        MOV     AH,09H
        INT     21H
        RET

VIS_RESR:
        MOV     DX,OFFSET MRESR
        MOV     AH,09H
        INT     21H
        RET

VIS_RESE:
        MOV     DX,OFFSET MRESE
        MOV     AH,09H
        INT     21H
        RET

VIS_RESM:
        MOV     DX,OFFSET MRESM
        MOV     AH,09H
        INT     21H
        RET

VIS_SALIR:
        MOV     DX,OFFSET MSALIR
        MOV     AH,09H
        INT     21H
        RET

;****** LECTURA DE UN CARACTER POR TECLADO **********
INGRESO:
        MOV     AH,01H
        INT     21H
        RET

;****** PIDE DIVIDENDO Y DIVISOR, VALIDA DIVISOR<>0 *
PEDIR_DATOS:
        CALL    VIS_MN1
        CALL    INGRESO
        AND     AL,0FH          ;ASCII -> VALOR NUMERICO
        MOV     N1,AL
        CALL    VIS_MN2
        CALL    INGRESO
        AND     AL,0FH
        MOV     N2,AL
        CMP     N2,0
        JNE     PEDIR_OK
        CALL    VIS_ERRDIV
        JMP     PEDIR_DATOS
PEDIR_OK:
        RET

;****** DIVISION REAL: COCIENTE + 2 DECIMALES *******
OP_REAL:
        CALL    PEDIR_DATOS
        MOV     AH,0
        MOV     AL,N1
        DIV     N2              ;AL=COCIENTE, AH=RESIDUO
        MOV     BL,AH           ;GUARDA RESIDUO PARA CALCULAR DECIMALES
        OR      AL,30H
        MOV     COCI,AL

        MOV     AL,BL
        MOV     BH,10
        MUL     BH              ;AX = RESIDUO*10
        DIV     N2              ;AL=1ER DECIMAL, AH=NUEVO RESIDUO
        MOV     BL,AH
        OR      AL,30H
        MOV     DEC1,AL

        MOV     AL,BL
        MOV     BH,10
        MUL     BH
        DIV     N2              ;AL=2DO DECIMAL
        OR      AL,30H
        MOV     DEC2,AL

        CALL    VIS_RESR
        MOV     AH,02H
        MOV     DL,COCI
        INT     21H
        MOV     DL,'.'
        INT     21H
        MOV     DL,DEC1
        INT     21H
        MOV     DL,DEC2
        INT     21H
        RET

;****** DIVISION ENTERA: SOLO EL COCIENTE ***********
OP_ENTERA:
        CALL    PEDIR_DATOS
        MOV     AH,0
        MOV     AL,N1
        DIV     N2
        OR      AL,30H
        MOV     COCI,AL
        CALL    VIS_RESE
        MOV     DL,COCI
        MOV     AH,02H
        INT     21H
        RET

;****** MODULO: SOLO EL RESIDUO *********************
OP_MODULO:
        CALL    PEDIR_DATOS
        MOV     AH,0
        MOV     AL,N1
        DIV     N2
        OR      AH,30H
        MOV     RESI,AH
        CALL    VIS_RESM
        MOV     DL,RESI
        MOV     AH,02H
        INT     21H
        RET

;*********** PROGRAMA PRINCIPAL *********************
MAIN:
        CALL    SEG_DAT

CICLO_MENU:
        CALL    VIS_MENU
        CALL    INGRESO

        CMP     AL,'1'
        JE      HACER_REAL
        CMP     AL,'2'
        JE      HACER_ENTERA
        CMP     AL,'3'
        JE      HACER_MODULO

        CALL    VIS_ERROPC
        JMP     CICLO_MENU

HACER_REAL:
        CALL    OP_REAL
        JMP     PREGUNTAR_SALIR

HACER_ENTERA:
        CALL    OP_ENTERA
        JMP     PREGUNTAR_SALIR

HACER_MODULO:
        CALL    OP_MODULO

PREGUNTAR_SALIR:
        CALL    VIS_SALIR
        CALL    INGRESO
        CMP     AL,'S'
        JE      SALIR
        JMP     CICLO_MENU

SALIR:
        MOV     AH,4CH
        INT     21H

        END
