;                     UNIVERSIDAD DE MEDELLIN
;             	       Ingenieria de Sistemas

;**************************************************************************
; Asignatura         :   Arquitectura de Computadores
; Nombre del programa:   Pract1.ASM
; Autor              :   Jairo. M. Vergara
; Máquina            :   Computador compatible 80486
; Objetivo           :   Despliega un mensaje en el monitor.
;                        Programa escrito con el fin de mostrar
;                        la forma de presentar los informes
;**************************************************************************

; --------------------------------------------------------------------
; ZONA DE DECLARACIONES Y COMANDOS GENERALES
; --------------------------------------------------------------------
       .MODEL  SMALL          ; Modelo de memoria corto

; --------------------------------------------------------------------
; SEGMENTO DE CODIGO DEL PROGRAMA
; --------------------------------------------------------------------
	.CODE                    ; Area de código

	

INICIO:                      	    ; Etiqueta de comienzo de programa

	MOV	AX,@DATA            ; Permite el acceso a los datos inicializando
	MOV	DS,AX               ; el registro DS con la dirección adecuada.
	MOV	DX, OFFSET MENSAJE  ; Carga la dirección de mensaje a DX para
	MOV	AH,09H              ; poder desplegarlo con la funci¢n 9 de la
	INT	21H                 ; Int 21h (DS:DX contiene la direcci¢n de
        INT     21H
        MOV     AH,4CH              ; la cadena que se desplegar ).
	MOV	AX,4C00H            ; Regresa a MS-DOS por medio de la funci¢n
     			            ; 4c de la interrupción 21h.
	INT	21H                 ; El código de regreso es 0 porque no hubo
                                    ; error. En caso de existir se podría pasar
                                    ; un código diferente a 0 (ej. 4c01h).

; --------------------------------------------------------------------
; SEGMENTO DE DATOS DEL PROGRAMA
; --------------------------------------------------------------------
	.DATA                     ; Segmento de datos

        MENSAJE DB      'PRIMER PROGRAMA',10,13,'$'

; --------------------------------------------------------------------
; SEGMENTO DE PILA DEL PROGRAMA Y FINALIZACION
; --------------------------------------------------------------------
	.STACK                   ; Se necesita una PILA.
	END                      ; Fin del programa

;**************************************************************************

; --------------------------------------------------------------------
; OBSERVACIONES FINALES
; --------------------------------------------------------------------
; El programa corre conforme a lo esperado. Es necesario tener en cuenta
; que para visualizar cadenas se debe invocar la interrupcion 21 del
; DOS con el servicio 9 ubicando la direccion de la cadena en DS:DX y
; poniendo el signo $ al final de la cadena.

ÿ
