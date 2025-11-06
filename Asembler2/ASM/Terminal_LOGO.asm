;***************************************************************************
;*		SEMESTRE 2008-1
;*		PROGRAMA REALIZADO POR: 
;*					CARLOS ANDRES VALENCIA BUITRAGO
;*					ANDRES FELIPE GUERRA YEPES
;*					CAROLINA MOZQUERA
;**************************************************************************					
;*				COMUNICACION SERIAL
;*		PRACTICA DE ASEMBLER - INDUSTRIAL FARMACEUTICA UDEM
;**************************************************************************

.MODEL  SMALL
.386

;*********************INICIO DECLARACION DE VARIABLES**********************************
.DATA
;**************************INICIO DEFINICION DE DATOS***********************************

;************************DIBUJAR LOGO********************************

        LOGO2   DB      'ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
	LOGO3	DB	'³ ³  ³  ³  ³ ³','$'
	LOGO4	DB	'ÀÄÂÄÄÄÄÄÄÄÄÂÄÙ','$'
	LOGO5	DB	' ÚÙ        À¿','$'
	LOGO6	DB	' ³ ÚÄÄÄÄÄÄ¿ ³ ','$' 
	LOGO7	DB	' ³ ³ UdeM ³ ³ ','$'
	LOGO8	DB	' ³ ÀÄÄÄÄÄÄÙ ³ ','$'
	LOGO9	DB	' À¿        ÚÙ ','$'
	LOGO10	DB	'  ÃÄÄÄÄÄÄÄÄ´  ','$'
	LOGO11	DB	'  ÀÄÄÄÄÄÄÄÄÙ  ','$'

;****************************DIBUJAR TABLA INICIO**************************************

	T_INI0	DB	10,13,'     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
	T_INI1	DB	10,13,'     ³ QUE DESEA HACER?    ³','$'
	T_INI2	DB	10,13,'     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
	HECHO1	DB	10,13,'     ³1. Listar visitadores              ³','$'
	T_INI3  DB    	10,13,'     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´','$'
	HECHO2	DB	10,13,'     ³2. Listar medicos                  ³','$'
	HECHO3	DB	10,13,'     ³3. Listar productos                ³','$'
	HECHO4	DB	10,13,'     ³4. Registrar visita                ³','$'
	HECHO5	DB	10,13,'     ³5. Registro medico                 ³','$'
	T_INI4	DB	10,13,'     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'
;************************DIBUJAR TABAL*************************


	T_SUP  	DB      10,13,'ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'	
      T_ENC1  	DB      10,13,'³ CODIGO    ³ NOMBRE      ³','$'
      T_DIV1  	DB      10,13,'ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´','$'
      T_INF   	DB      10,13,'ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'
	



SALIO		DB	'PARA SALIR PRESIONE "Esc"','$'
CUR_FIL	DB	0
CUR_COL	DB	0
TITULO  DB      	10,13,'                   BIENVENIDOS A LA INDUSTRIAL FARMACEUTICA UDEM','$'
LISVIS		DB	10,13,'    LISTADO DE VISITADORES','$'
LISMED		DB	10,13,'    LISTADO DE MEDICOS','$'
LISPRO		DB	10,13,'    LISTADO DE PRODUCTOS','$'	
REALIZADO	DB	10,13,'                 TERMINAL','$'
MENS3		DB	10,13,' DIGITE "Q" PARA SALIR O "S" PARA CONTINUAR','$'
SALTO		DB	10,13,'$'
ESCOPC   	DB     	10,13, '         LISTADO DE VISITADORES[1],# LISTADO DE MEDICOS[2],$'
ESCOPC1 	DB	10,13,' LISTA DE PRODUCTOS [3], REGISTRAR VISITA[4],REGISTRO DE MEDICO[5]: $'	;ESCOGER OPCION
ERROR		DB	10,13,'ASEGURESE QUE EL VISITADOR, MEDICO O PRODUCTO EXISTA','$'
HORA		DB	?
MINUTO		DB	?
SEGUNDO		DB	?
BINVALL  	DW      0000
ASCVAL 		DB      4 DUP(00H),'*'; SE QUITO $ ANTES DE *
ASCVALL  	DB      5 DUP(00H),'$'
BINVAL  	DW      0000
DIA1		DB	?
DIA2		DB	?
MES1		DB	?
MES2		DB	?
ANO1		DB	?
ANO2		DB	?
HOR1		DB	?
HOR2		DB	?
MIN1		DB	?
MIN2		DB	?
SEC1		DB	?
SEC2		DB	?
TEMP		DB	?
PIN		DB	7 DUP(00),'*';6
NADA		DB	'      ','$'
NAD		DB	'  ','$'
TXDATO		DB	?
RXDATO		DB	00H ; MEMORIA DONDE SE ALMACENA DATO RECIBIDO
PESO		DB	00H ; MEMORIA DONDE SE ALMACENA DATO RECIBIDO
CODVIS		DB	10,13,' INGRESE EL CODIGO DEL VISITADOR: $'
CODMED		DB	10,13,' INGRESE EL CODIGO DEL CODIGO MEDICO: $'
NUMPRO		DB	10,13,' # PRODUCTOS A PROMOCIONAR: $'
CODPRO		DB	10,13,' CODIGO PRODUCTO: $'
VECTENV		DB	60 DUP(00),'$'
ERRORMED	DB	10,13,' EL MEDICO QUE INGRESASTE NO EXISTE','$'
ERRORVIS	DB	10,13,' EL VISITADOR QUE INGRESASTE NO EXISTE $'
ERRORPRO	DB	10,13,' EL PRODUCTO O PRODUCTOS QUE INGRESASTE NO EXISTE(N)','$'
CODACEPT	DB	10,13,' CODIGO DE ACEPTACION: ','$'
DIGMED		DB	10,13,' CODIGO MEDICO: ','$'
	T_SUP3  DB      10,13,'ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿','$'	
     	T_ENC3	DB      10,13,'³ CODIGO    ³ MEDICO  ³ VISITAS   ³','$'
	T_INF3 	DB      10,13,'ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ','$'

	T_SUP7	DB	10,13,'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿','$'	
     	T_ENC7	DB      10,13,'³ VISITADOR   ³  PDTOS ³ PRODUCTO  ³ FECHA    ³','$'
	T_INF7 	DB      10,13,'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ','$'
ESPACIO		DB	'     ','$'
TEMPP		DW	?
COM1    EQU     3F8H    ;DIRECCION DEL PUERTO SERIAL (COM1)
MCR     EQU     3FCH    ;REG CONTROL DEL MODEM, BIT1=DTR, BIT0=DSR
LSR     EQU     3FDH    ;REG. ESTADO DE LINEA
MSR     EQU     3FEH    ;REG. ESTADO DEL MODEM

FIL_COL	MACRO F,C
	MOV	CUR_FIL,F
	MOV	CUR_COL,C
ENDM

;*************************************************************

MACC	MACRO	VECVISTA
	LOCAL	SIVT,CTI,CSTO,IRSALT,G
	MOV	DI,0
	MOV	SI,0
	MOV	AH,02H

SIVT:	MOV	AH,02H
	CMP	VECVISTA[DI],'%'
	JE	CSTO
	CMP	VECVISTA[DI],'+'
	JE	CSTO
	CMP	VECVISTA[DI],'&'
	JE	IRSALT
	CMP	VECVISTA[DI],'¦'
	JE	CTI
	MOV	DL,VECVISTA[DI]
	INT	21H
	INC	DI
	JMP	SIVT

CSTO:	MENS	ESPACIO
	INC	DI
	MOV	AH,02H
	JMP	SIVT
	
IRSALT:	MENS	ESPACIO
	MOV	DI,20
	MOV	DL,VECVISTA[DI]
	MOV	AH,02H
	INT	21H
	INC	DI
	CMP	VECVISTA[DI],'#'
	JE	G
	MENS	SALTO
	MENS	T_SUP7
	MENS	T_ENC7
	MENS	T_INF7
	MENS	SALTO
	;MOV	AH,02H
	JMP	CSTO
CTI:	MOV	SI,DI
	INC	SI
	CMP	VECVISTA[SI],'#'
	JE	G
	ADD	DI,2
	MENS	SALTO
	MENS	ESPACIO
	MOV	AH,02H
	JMP	SIVT
G:	
	ENDM
	
;************************* FIN DEFINICION DE DATOS**************
.CODE
ORG     0000
MOV     AX,@DATA
MOV     DS,AX
JMP     MAIN
;************************************************************************
;********* MACRO *******************************************
;MACRO PARA CONFIGURAR PUERTO DE COMNICACION SERIAL
;Y = 0 PARA COM1, = 1 PARA COM2
COM     MACRO   Y
        MOV     	AH,00           ;SERVICIO DE CONFIGURACION PUERTO SERIAL
        MOV     	AL,11100011B    ;9600 BPS, NO PARIDAD, 1 BIT DE PARADA
        MOV     	DX,Y
        INT     	14H
        ENDM
;**************************************************************

;***********************INICIO MACRO PARA MOSTRAR MENSAJES POR PANTALLA*******
MENS	MACRO	MS
	MOV	AH,09H
       	LEA     DX,MS
	INT	21H	
	ENDM
;*******************************************************************

;*********MACRO DE RETARDO O DELAY**************
DELAY   MACRO   T1,T2
        LOCAL   DELA2,DELA1
       
        MOV     BL,T1
DELA2:  MOV     CX,T2
DELA1:  LOOP    DELA1
        DEC     BL
        JNZ     DELA2
      
        ENDM
;****************************************************************
;***********************************************************

;SUBRUTINA DE TRANSMISION DE UNA CADENA DE CARACTERES
TX	 MACRO	TRIR
	 LOCAL	TXD,NOLISTO,LISTO,NVACIO,VACIO
         	MOV    SI, OFFSET TRIR
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
         MOV    SI,OFFSET TRIR ;INICIALIZAR PUNTERO DE MEMORIA DE DATOS
         ENDM
;***********************************************************
;****************************************************************
;RUTINA QUE RECIBE UN DATO SERIALMENTE EN AL Y LO ALMACENA EN RXDATO
RX:     	
		MOV     AH,02   ;SERVICIO DE LECTURA POR EL PUERTO SERIAL
        	MOV    	DX,00   ;SELECCIONAR COM1
       		INT     14H
		MOV	PESO,AL
        	DELAY   0FH,03FFH  ;ESPERA PARA RECIBIR PROXIMO DATO
		RET
;****************************************************************


;************POSICIONAR CURSOR EN LA MITAD DE LA PANTALLA*********
PCUR:	MOV	AH,02H
	MOV	BH,00H
	MOV	DH,15H
	MOV	DL,47H
	INT	10H
	RET
;****************************************************************************************

;**********RUTINA PARA MOSTRAR LA HORA EN PANTALLA*****************
MRELOJ:	MOV	AH,02H
		MOV	DL,HOR1
		INT	21H
		MOV	DL,HOR2
		INT	21H 
		MOV	DL,':'
		INT	21H 
		MOV	DL,MIN1
		INT	21H 
		MOV	DL,MIN2
		INT	21H 
		MOV	DL,':'
		INT	21H 
		MOV	DL,SEC1
		INT	21H 
		MOV	DL,SEC2
		INT	21H 
		MOV	DL,00H
		INT	21H  
		RET
;***********************************************************
;********INICIO - CAPTURAR HORA DE SISTEMA********
CAPTHOR:MOV	AH,2CH
	INT	21H
	MOV	HORA,CH
	MOV	MINUTO,CL
	MOV	SEGUNDO,DH
	MOV	AX,0000H
	MOV	AL,CH
	MOV     BINVAL,AX
     	CALL    BINASCII
	MOV	AL,ASCVAL[3]
	MOV	HOR2,AL
	MOV	PIN[1],AL
	CMP	ASCVAL[2],00H
	JE	HOR
	MOV	AL,ASCVAL[2]
	MOV	HOR1,AL
	MOV	PIN[0],AL
	JMP	MIN
HOR:	MOV	PIN[0],'0'
	MOV	HOR1,'0'
MIN:	MOV	AX,0000H
	MOV	AL,MINUTO
	MOV     BINVAL,AX
        CALL    BINASCII
	MOV	AL,ASCVAL[3]
	MOV	MIN2,AL
	MOV	PIN[3],AL
	CMP	ASCVAL[2],00H
	JE	MINU
	MOV	AL,ASCVAL[2]
	MOV	MIN1,AL
	MOV	PIN[2],AL
	JMP	SEC
MINU:	MOV	PIN[2],'0'
	MOV	MIN1,'0'
SEC:	MOV	AX,0000H
	MOV	AL,SEGUNDO
	MOV    	BINVAL,AX
      	CALL    BINASCII
	MOV	AL,ASCVAL[3]
	MOV	SEC2,AL
	MOV	PIN[5],AL
	CMP	ASCVAL[2],00H
	JE	SECU
	MOV	AL,ASCVAL[2]
	MOV	SEC1,AL
	MOV	PIN[4],AL
	JMP	FINA
SECU:	MOV	PIN[4],'0'
	MOV	SEC1,'0'
FINA:
	RET
;********FIN - CAPTURAR HORA DEL SISTEMA*********
CAPFECHA:
        MOV     AH,2AH
        INT     21H
        MOV     AX,0
        MOV     AL,DL           ;DIA
        AAM
        OR      AX,3030H
        MOV     DIA1,AH
        MOV     DIA2,AL
        MOV     TEMP,':'
        
        MOV     AX,0
        MOV     AL,DH    ;MES
        AAM
        OR      AX,3030H
        MOV     MES1,AH
        MOV     MES2,AL
	MOV     BINVAL,CX    ;A¥O
        CALL    BINASCIII
        MOV     SI,1
        MOV     BL,ASCVALL[3]
	MOV     ANO1,BL
	MOV	BL,ASCVALL[4]
	MOV     ANO2,BL
        RET        
;**********************************************************
BINASCIII:       
	LEA     SI,ASCVALL
        MOV     CX,5
        MOV     AL,00H
C100:   MOV     [SI],AL
        INC     SI
        LOOP    C100
        MOV     CX,10
        LEA     SI,ASCVALL+4
        MOV     AX,BINVAL
C200:   CMP     AX,CX
        JB      C300
        XOR     DX,DX
        DIV     CX
        OR      DL,30H
        MOV     [SI],DL
        DEC     SI
        JMP     C200
C300:    OR      AL,30H
        MOV     [SI],AL
        RET
;**********************************************************
BINASCII:
       LEA     SI,ASCVAL
       MOV     CX,4
       MOV     AL,00H
C10:   MOV     [SI],AL
       INC     SI
       LOOP    C10
       MOV     CX,10
       LEA     SI,ASCVAL+3
       MOV     AX,BINVAL
C20:   CMP     AX,CX
       JB      C30
       XOR     DX,DX
       DIV     CX
       OR      DL,30H
       MOV     [SI],DL
       DEC     SI
       JMP     C20
C30:   OR      AL,30H
       MOV     [SI],AL
       RET
;****************************************************
OPCION1:MOV	AH,07H
	INT	21H
	RET
VERPANT:MOV	AH,02H
	MOV	DL,AL
	INT	21H
	RET
;******************MAIN***************************
MAIN:	
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	COM    	00     		 ;CONFIGURAR PUERTO SERIAL COM1
	MENS	SALTO
	MENS 	TITULO
	MENS 	SALTO
MAIN1:	MENS	T_INI0
	MENS	T_INI1
	MENS	T_INI2
	MENS	HECHO1
	MENS	T_INI3
	MENS	HECHO2
	MENS	T_INI3
	MENS	HECHO3
	MENS	T_INI3
	MENS	HECHO4
	MENS	T_INI3
	MENS	HECHO5
	MENS	T_INI4
	CALL	LOGO
	FIL_COL	22,46
	CALL	SET_CURSOR
	MENS	SALIO
	CALL	TECLA
	CMP	AL,'1'
	JE	LVIS		;PROX ;LVIS	 ;LVIS: LISTA VISITADORES 
	CMP	AL,'2'
	JE	LMED
	CMP	AL,'3'
	JE	LPRO
	CMP	AL,'4'
	JE	REGI
	CMP	AL,'5'
	JE	TRAERMED
	MENS 	SALTO

MRE:	CALL	PCUR			;PCUR: POSICIONAR CURSOR
	CALL	CAPTHOR
	CALL	MRELOJ			;MRE: MOSTRAR RELOJ
	JMP	FIN
;************************************************
LOGO:
		FIL_COL	8,54
	CALL	SET_CURSOR
	MENS	LOGO2
	FIL_COL	9,54
	CALL	SET_CURSOR
	MENS	LOGO3
	FIL_COL	10,54
	CALL	SET_CURSOR
	MENS	LOGO4
	FIL_COL	11,54
	CALL	SET_CURSOR
	MENS	LOGO5
	FIL_COL	12,54
	CALL	SET_CURSOR
	MENS	LOGO6
	FIL_COL	13,54
	CALL	SET_CURSOR
	MENS	LOGO7
	FIL_COL	14,54
	CALL	SET_CURSOR
	MENS	LOGO8
	FIL_COL	15,54
	CALL	SET_CURSOR
	MENS	LOGO9
	FIL_COL	16,54
	CALL	SET_CURSOR
	MENS	LOGO10
	FIL_COL	17,54
	CALL	SET_CURSOR
	MENS	LOGO11
RET
;***************************************************
TRAERMED:
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS 	TITULO
	MENS 	SALTO
	MENS	DIGMED
	MOV	VECTENV[0],'@'
	MOV	DI,1
	MOV	SI,0
TRAMED:	CMP	SI,8
	JE	ENIX
	CALL	OPCION1
	CMP	AL,0DH
	JE	ENIX
	CMP	AL,30H
	JB	REGI1
	CMP	AL,39H
	JA	REGI1
	CALL	VERPANT
	MOV	VECTENV[DI],AL
	INC	DI
	INC	SI
	JMP	TRAMED
ENIX:	
	MOV	VECTENV[DI],'+'
	INC	DI		; LINEA PUESTA, SI PRESENTA ERROR BORRARLA
	MOV	VECTENV[DI],'*'
	MOV	TEMPP,DI
	TX	VECTENV
	CALL	LIMVECTENV
	MENS	SALTO
PEZ:	MOV	DI,0
XRX:	CALL	RX
	CMP	PESO,'}'
	JE	ERRORMEDICO
	CMP	PESO,'#'
	JE	YA	
	MOV	VECTENV[DI],AL
	INC	DI
	JMP	XRX

ERRORMEDICO:	
		MENS	ERRORMED
		MENS	SALTO
		JMP	IFIN

YA:	MOV	VECTENV[DI],'#'
	MENS	SALTO
	MENS	T_SUP3
	MENS	T_ENC3	
	MENS	T_INF3
	MENS	SALTO
	MACC	VECTENV
	CALL	LIMVECTENV
	MENS	SALTO
	JMP	IFIN

VACTXDATO:	MOV	DI,0
VACT:		CMP	DI,TEMPP
		JE	YSA
		MOV	TXDATO[DI],00H
		INC	DI
		JMP	VACT
YSA:		MOV	TXDATO[DI],00H
		RET
;***************************************************
REGI:	
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS 	TITULO
	MENS 	SALTO
	MENS	CODVIS
	MOV	VECTENV[0],'='
	MOV	DI,1
	MOV	SI,0
REGI1:	CMP	SI,8
	JE	TRI
	CALL	OPCION1		;CODIGO VISITANTE
	CMP	AL,0DH
	JE	TRI
	CMP	AL,30H
	JB	REGI1
	CMP	AL,39H
	JA	REGI1
	CALL	VERPANT
	MOV	VECTENV[DI],AL
	INC 	DI
	INC	SI
	JMP	REGI1	
TRI:	MOV	VECTENV[DI],'%'
	INC DI
	MENS	CODMED
	MOV	SI,0
REGI2:	CMP	SI,8
	JE	TRI1
	CALL	OPCION1		;CODIGO MEDICO
	CMP	AL,0DH
	JE	TRI1
	CMP	AL,30H
	JB	REGI2
	CMP	AL,39H
	JA	REGI2
	CALL	VERPANT
	MOV	VECTENV[DI],AL
	INC	DI
	INC	SI
	JMP	REGI2
TRI1:	MOV	VECTENV[DI],'%'
	INC DI
	MENS	SALTO
	MENS	NUMPRO
REGI3:	CALL	OPCION1		; NUMERO DE PRODUCTOS
	CMP	AL,31H
	JB	REGI3
	CMP	AL,33H
	JA	REGI3
	CALL	VERPANT	
	MOV	VECTENV[DI],AL
	INC	DI
	AND	AL,0FH
	MOV	AH,00H
	MOV	CX,AX
TRI2:	MOV	VECTENV[DI],'%'
	INC 	DI
	
REGPRO:	MENS	CODPRO		;CODIGO PRODUCTO
	MOV	SI,0
REGI4:	CALL	OPCION1
	CMP	AL,30H
	JB	REGI4
	CMP	AL,39H
	JA	REGI4
	CMP	AL,0DH
	JE	TRI3
	CALL	VERPANT	
	MOV	VECTENV[DI],AL
	INC	DI
	INC	SI
	CMP	SI,3
	JE	TRI3
	JMP	REGI4
TRI3:	MOV	VECTENV[DI],'-'  ;CAMBIADO
	INC 	DI		;CAMBIADO
	DEC	CX
	CMP	CX,0
	JE	TRI4
	JMP	REGPRO

REGI5:	CALL	RECTEC
	CMP	AL,0DH
	JE	TRI4
	MOV	VECTENV[DI],AL
	INC	DI
	JMP	REGI5
TRI4:	DEC	DI	;CAMBIADO
	MOV	VECTENV[DI],'+'
	INC	DI
	CALL	CAPFECHA
	CALL	CAPTHOR
	MOV	BL,DIA1
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	BL,DIA2
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	VECTENV[DI],'/'
	INC	DI
	MOV	BL,MES1
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	BL,MES2
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	VECTENV[DI],'/'
	INC	DI
	MOV	BL,ANO1
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	BL,ANO2
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	VECTENV[DI],'_'
	INC	DI
	MOV	BL,HOR1
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	BL,HOR2
	MOV	VECTENV[DI],BL
	INC	DI	
	MOV	VECTENV[DI],':'
	INC	DI
	MOV	BL,MIN1	
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	BL,MIN2
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	VECTENV[DI],':'
	INC	DI
	MOV	BL,SEC1
	MOV	VECTENV[DI],BL
	INC	DI
	
	MOV	BL,SEC2
	MOV	VECTENV[DI],BL
	INC	DI
	MOV	VECTENV[DI],'&'
	INC	DI
	MOV	VECTENV[DI],'*'
	MENS  	SALTO
	TX	VECTENV
CIC:	CALL	RX
	CMP	PESO,'â'
	JE	ERRVIS
	CMP	PESO,'Z'
	JE	ERRMED
	CMP	PESO,'W'
	JE	ERRPRO
	CMP	PESO,'Q'
	JE	RECCOD	; RECIBIR CODIGO DE ACEPTACION
	JMP	CIC
ERRVIS:	MENS	ERRORVIS
	MENS	SALTO
	JMP	IFIN	;SE CAMBIO FIN POR IFIN
ERRMED:	
	MENS	ERRORMED
	MENS	SALTO
	JMP	IFIN
ERRPRO:	MENS	ERRORPRO
	MENS	SALTO
	JMP	IFIN

RECCOD:	
	MENS	CODACEPT
RECCOD1:CALL 	RX
	CMP    	AL,00H  ;SI NO LLEGA NINGUN CARACTER AL=00H
        JE    	FIA
	MOV	DL,PESO
	MOV	AH,02H
	INT	21H
	JMP	RECCOD1

FIA:	MENS	SALTO
	CALL	LIMVECTENV
	JMP	IFIN

;******AÑADIDO PARA VACIAR VECTOR QUE SE ENVIA UN REGISTRO NUEVO*****	
LIMVECTENV:	MOV	DI,0
LVE:		CMP	DI,61
		JE	FINLIMVEC
		MOV	VECTENV[DI],00H
		INC	DI
		JMP	LVE
FINLIMVEC:	RET
;*****FIN AÑADIDO PARA VACIAR VECTOR QUE SE ENVIA UN REGISTRO NUEVO**
;***************************************************

SET_CURSOR:
	PUSH	AX
	PUSH	BX
	PUSH	DX
	MOV	AH,02H
	MOV	BH,00
	MOV	DH,CUR_FIL
	MOV	DL,CUR_COL
	INT	10H
	POP	DX
	POP	BX
	POP	AX
	RET	
;***************************************************
RECTEC:	MOV	AH,01H
	INT	21H
	RET
;***************************************************
LVIS:	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS	TITULO
	MENS	SALTO
	MENS	LISVIS
	MENS	SALTO
	MENS	T_SUP
	MENS	T_ENC1
	MENS	T_INF
	CALL	LOGO
	FIL_COL	8,3
	CALL	SET_CURSOR
	MOV	TXDATO[0],'/'
	MOV	TXDATO[1],'*'
	TX	TXDATO
	MENS	SALTO
	MENS	NAD
PROX:	
	CALL	RX
	CMP	PESO,'%'
	JE	ESPA		;DEJAR ESPACIO
	CMP	PESO,'&'
	JE	SALT		;IFIN;SALT	;SALTAR UN RENGLON 
	CALL	VISUAL
	JMP	PROX
ESPA:	MENS	NADA
	JMP	PROX
SALT:	
	MENS	SALTO
	MENS	NAD
	JMP	PROX
IFIN:	
	MENS	MENS3
IFIN2:
	CALL	TECLA
	CMP	AL,'Q'
	JE	FIN
	CMP	AL,'S'
	JE	MAIN
	JMP	IFIN2

;***************************************************
;****************************************************************
; RUTINA PARA VISUALIZAR EL DATO RECIBIDO POR PANTALLA
VISUAL:  	
		MOV    	AL,PESO
         	CMP    	AL,00H  ;SI NO LLEGA NINGUN CARACTER AL=00H
         	JE    	SLI
		CMP	AL,'?'
		JE	IFIN
         	MOV    	DL,AL
         	MOV    	AH,02   ;SERVICIO PARA MOSTRAR CARACTER POR PANTALLA
         	INT    	21H
SLI:		
         	RET
;****************************************************************
LMED:	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS	TITULO
	MENS	SALTO
	MENS	LISMED
	MENS	SALTO
	MENS	T_SUP
	MENS	T_ENC1
	MENS	T_INF
	CALL	LOGO
	FIL_COL	8,3
	CALL	SET_CURSOR
	MOV	TXDATO[0],'('
	MOV	TXDATO[1],'*'
	TX	TXDATO
	MENS	SALTO
	MENS	NAD
PROXM:	
	CALL	RX
	CMP	PESO,'%'
	JE	ESPAM		;DEJAR ESPACIO
	CMP	PESO,'&'
	JE	SALTM		;IFIN;SALT	;SALTAR UN RENGLON 
	CALL	VISUAL
	JMP	PROXM
ESPAM:	MENS	NADA
	JMP	PROXM
SALTM:	MENS	SALTO
	MENS	NAD
	JMP	PROXM
IFINM:	JMP 	FIN
;***************************************************
LPRO:	FIL_COL	0,0
	CALL	SET_CURSOR
	CALL	COLOR
	MENS	LISPRO
	MENS	T_SUP
	MENS	T_ENC1
	MENS	T_INF
	CALL	LOGO
	FIL_COL	4,3
	CALL	SET_CURSOR
	MOV	TXDATO[0],'¡'
	MOV	TXDATO[1],'*'
	TX	TXDATO
	MENS	SALTO
	MENS	NAD
PROXP:	CALL	RX
	CMP	PESO,'%'
	JE	ESPAP		;DEJAR ESPACIO
	CMP	PESO,'&'
	JE	SALTP;IFIN;SALT	;SALTAR UN RENGLON 
	CALL	VISUAL
	JMP	PROXP
ESPAP:	MENS	NADA
	JMP	PROXP
SALTP:	MENS	SALTO
	MENS	NAD
	JMP	PROXP
IFINP:	JMP 	FIN
;***************************************************
;************************************************************************
COLOR:  		MOV     	AH,06H
        		MOV     	AL,00H              ;toda la pantalla
        		MOV     	BH,00010111B        ;Atributo de color bit7: Intermitencia
        		MOV     	CX,0000H            ;Posicion Inicial
        		MOV     	DX,184fH            ;Posicion Final
        		INT     	10H
			RET
			;JMP	MAIN
;*************************************************************************
;*********************************************        	
FIN:		MOV	AX,4C00H
     		INT	21H
;*********************************************
;****************************************************************
;RUTINA PARA ESCANEAR EL TECLADO
TECLA:   	MOV    	AH,07H   ;CODIGO ASCII DE TECLA SE ALMACENA EN AL
         	INT    	21H
        	RET
;****************************************************************

.STACK
END
