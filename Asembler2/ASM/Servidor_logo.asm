;***************************************************************************
;*		SEMESTRE 2008-1
;*		PROGRAMA REALIZADO POR: 
;*					CARLOS ANDRES VALENCIA BUITRAGO
;*					ANDRES FELIPE GUERRA YEPES
;*					CAROLINA MOSQUERA
;**************************************************************************					
;*				COMUNICACION SERIAL
;*		PRACTICA DE ASEMBLER - INDUSTRIAL FARMACEUTICA UDEM
;**************************************************************************

	.MODEL  SMALL
	.386

;**************************************************************************
	.DATA
;**************************INICIO DEFINICION DE DATOS***********************************

;*********************DIBUJAR TABLA MENU***************

	T_INI0	DB	10,13,'     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
	T_INI1	DB	10,13,'     ³ QUE DESEA HACER?    ³','$'
	T_INI2	DB	10,13,'     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
	HECHO1	DB	10,13,'     ³1. Listar visitadores              ³','$'
	T_INI3  DB    	10,13,'     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´','$'
	HECHO2	DB	10,13,'     ³2. Listar medicos                  ³','$'
	HECHO3	DB	10,13,'     ³3. Listar productos                ³','$'
	HECHO4	DB	10,13,'     ³4. Visita por codigo de empleado   ³','$'
	HECHO5	DB	10,13,'     ³5. Visita por codigo de aceptacion ³','$'
	HECHO6	DB	10,13,'     ³6. Vista ascendente de empleados   ³','$'
	HECHO7	DB	10,13,'     ³7. Vista descendente de medicos    ³','$'
	HECHO8	DB	10,13,'     ³8. Vista total de visitas          ³','$'
	T_INI4	DB	10,13,'     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'

;***********************DIBUJAR TABLA VISITADORES***********************
	T_TIT2	DB	  10,13,'	LISTADO DE VISITADORES	','$'
	T_SUP  	DB      10,13,'ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'	
      	T_ENC1  	DB      10,13,'³ CODIGO    ³ NOMBRE          ³','$'
      	T_DIV1  	DB      10,13,'ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´','$'
      	T_INF   	DB      10,13,'ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'

;**********************DIBUJAR TABLA MEDICOS*******************************

	T_TIT3	DB	  '	LISTADO DE MEDICOS	 ','$'

;**********************DIBUJAR TABLA PRODUCTOS*****************************

	T_TIT4	DB	  '	LISTADO DE PRODUCTOS	 ','$'
      	T_ENC2  DB      10,13,'³ CODIGO ³ PRODUCTO              ³','$'
	T_SUP2 	DB      10,13,'ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
      	T_DIV2 	DB      10,13,'ÃÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´','$'
	HECHO9	DB	10,13,'³        ³                       ³','$'		
	T_INI5	DB	10,13,'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'

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

;**********************DIBUJAR TABLA CODIGO VISITADOR***********************

	T_SUP3 	DB      10,13,'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿','$'
      	T_ENC3  DB      10,13,'³ CODIGO   ³ NOMBRE  ³ VISITAS ³','$'
      	T_DIV3 	DB      10,13,'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ','$'

;*********** PARA EL BURBUJA**********
VECTOR	DW	10 DUP (0000)
TEMPP		DW	?
POSI		DW	'0','1','2','3','4','5','6','7','8','9','$'
POSIVIS	DW	'0','1','2','3','4','$'
DAT01		DW	0
DAT02		DW	0	
DAT03		DW	0
DAT04		DW	0
DAT05		DW	0
DAT06		DW	0
DAT07		DW	0
DAT08		DW	0
DAT09		DW	0
DAT10		DW	0
VIS01		DW	0
VIS02		DW	0
VIS03		DW	0
VIS04		DW	0
VIS05		DW	0

;*************************************
CUR_FIL		DB	0
CUR_COL		DB	0
ESPACIO		DB	'    ','$'	
ESPACIO1		DB	'    ','$'
ESPACIO2		DB	'        ','$'
TITULO            DB   	10,13,'                BIENVENIDOS A LA INDUSTRIAL FARMACEUTICA UDEM','$'
VISCOD		DB	10,13,'           INGRESE EL CODIGO DEL EMPLEADO QUE DESEEA VER','$'
PECODO		DB	10,13,'           INGRESE EL CODIGO DE ACEPTACION QUE DESEEA VER','$'
MENASC		DB	10,13,'           VISTA ASCENDENTE DE EMPLEADOS','$'
MENDES		DB	10,13,'           VISTA DESCENDENTE DE MEDICOS','$'
VISITADOR1     	DB    '71311160%CARLOS&$  '
			DB	'0                                                                              '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','$'

VISITADOR2      	DB    '71311161%MAURICIO&$'
			DB	'0                                                                              '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','$'
VISITADOR3        DB    '71311162%MARIA&$   '
			DB	'0                                                                              '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','$'
VISITADOR4        DB    '71311163%JAIME&$   '
			DB	'0                                                                             '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','$'
VISITADOR5      	DB    '71311164%PAULA&?$  '
			DB	'0                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','$'
MEDICO1          	DB    '98726540%CESAR&$   '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO2         	DB    '98726541%RODRIGO&$ '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO3         	DB    '98726542%JAVIER&$  '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO4         	DB    '98726543%PAOLA&$   '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO5         	DB    '98726544%CAROLINA&$'
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO6         	DB    '98726545%VICTORIA&$'
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO7         	DB    '98726546%ALBERTO&$ '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO8         	DB    '98726547%TATIANA&$ '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO9         	DB    '98726548%NATALIA&$ '
			DB	'0#"                                                                               '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
MEDICO10        	DB    '98726549%JORGE&?$  '
			DB	'0#"                                                                              '
			DB	'                                                                               '
			DB	'                                                                               '
			DB	'                                                                               ','*'
PRODUCTO1	DB	'100%ACEITE DE RECINO&$'
PRODUCTO2	DB	'101%ACEITE DE ALMENDRAS&$'
PRODUCTO3	DB	'102%AGUA DEL CARMEN&$'
PRODUCTO4	DB	'103%AGUA OXIGENADA&$'
PRODUCTO5	DB	'104%ARTIFLEX&$'
PRODUCTO6	DB	'105%ASPIRINA 500&$'
PRODUCTO7	DB	'106%BEFOL&$'
PRODUCTO8	DB	'107%BICARBONATO DE SODIO&$'
PRODUCTO9	DB	'108%BETAVIT KIDS&$'
PRODUCTO10	DB	'109%CALDEVAL&$'
PRODUCTO11	DB	'110%CAPRIMIDA D&$'
PRODUCTO12	DB	'111%TIROXIN 50&$'
PRODUCTO13	DB	'112%CARBOSAN D&$'
PRODUCTO14	DB	'113%CIPCAL 500&$'
PRODUCTO15	DB	'114%CITRIPAL&$'
PRODUCTO16	DB	'115%COLLAGEN&$'
PRODUCTO17	DB	'116%COMPLEJO B&$'
PRODUCTO18	DB	'117%DIABION&$'
PRODUCTO19	DB	'118%GLICERINA&$'
PRODUCTO20	DB	'119%DOLEX&?$'

SALIO		DB	'PARA SALIR PRESIONE "Esc"','$'
MENS3		DB	'DIGITE "Q" PARA SALIR O "S" PARA CONTINUAR','$'
SALTO		DB	10,13,' ','$'
		DB	10,13,'ASCENDENTE EMPLEADOS[6],DESCENDENTE MEDICO[7],TOTAL VISITAS[8]: $'
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
PIN		DB	7 DUP(00),'*';6
NADA		DB	'                     ','$'
RXDATO   	DB      00H    ;MEMORIA DONDE SE ALMACENA DATO RECIBIDO
VECIN		DB	60 DUP(00)
ERROR		DB	10,13,' NO EXISTE EL VISITADOR','$'
ERRORCOD	DB	10,13,' NO EXISTE EL CODIGO DE OPERACION','$'
OK		DB	10,13,' SI EXISTE EL VISITADOR','$'
OKM		DB	10,13,' SI EXISTE EL MEDICO','$'
ERRORM		DB	10,13,' NO EXISTE EL MEDICO','$'
OKP		DB	10,13,' SI EXISTE EL PRODUCTO','$'
ERRORP		DB	10,13,' NO EXISTE EL PRODUCTO','$'
TEMP		DB	?
VECTENV		DB	5 DUP(00)
TMP		DB	?
HORA1		DB	?
HORA2		DB	?
HORA		DB	?
MIN		DB	?
SEC		DB	?
DIA		DB	?
MES		DB	?
DIAMES	DB	?
ANO		DB	?
DMA		DB	?
VIS		DB	?
MED		DB	?
PVIS1		DB	?	;PVIS : PUNTERO VISITADOR ULTIMA POSICION ESCRITA
PVIS2		DB	?
PVIS3		DB	?
PVIS4		DB	?
PVIS5		DB	?
PMED1		DB	?
PMED2		DB	?
PMED3		DB	?
PMED4		DB	?
PMED5		DB	?
PMED6		DB	?
PMED7		DB	?
PMED8		DB	?
PMED9		DB	?
PMED10	DB	?
CODVIS	DB	10,13,' CODIGO VISITADOR:  $'
CODOPE	DB	10,13,' CODIGO ACEPTACION:  $'
VECCOM	DB	10 DUP(00)
MENSNCN	DB	10,13,'  CODIGO         NOMBRE                  VISITAS','$'  
NUMTOVIS	DB	10,10,13,' EL NUMERO TOTAL DE VISITAS POR TODOS LOS VISITADORES HAN SIDO:','$'
MENSOPE	DB	10,13,'  CODIGO    NOMBRE 	MEDICO     PTOS  CODPRO      FECHA','$'    

;************************TABLA CODIGO DE OPERACION***********************

T_LIN		DB	10,13,'ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
T_ENC8	DB	10,13,'³ CODIGO  ³ NOMBRE  ³   MEDICO  ³ PTOS ³    CODPRO   ³      FECHA       ³','$'
T_INF2   	DB    10,13,'ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'

T_LIN1	DB	10,13,'ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿','$'
T_ENC9	DB	10,13,'³ MEDICO  ³ PRO ³ CODPRO  ³       FECHA       ³','$'
T_INF3   	DB    10,13,'ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ','$'


COM1    EQU     3F8H    ;PUERTO SERIAL COM1
MCR     EQU     3FCH    ;REG CONTROL DEL MODEM, BIT1=DTR, BIT0=DSR
LSR     EQU     3FDH    ;REG. ESTADO DE LINEA
MSR     EQU     3FEH    ;REG. ESTADO DEL MODEM

;************************* FIN DEFINICION DE DATOS*********************************

;***********MACRO UBICAION***************************
RAYA	MACRO	F
	MENS	HECHO9
	FIL_COL	F,4
	CALL	SET_CURSOR
ENDM
;****************MACRO BURBUJA****************************
;******************************************************
LLENAR_VECTOR	MACRO	Y,POS
		MOV 	SI,POS
		MOV	AX,DAT&Y
		MOV	VECTOR[SI],AX
		ENDM
;******************************************************
LLENAR_VECTORVIS	MACRO	Y,POS
		MOV 	SI,POS
		MOV	AX,VIS&Y
		MOV	VECTOR[SI],AX
		ENDM

;**********MACRO MOSTRAR MEDICO EN FORMA DESCENDENTE***********
TS	MACRO	BURMED
	LOCAL ES1,FINME,DEJESP,MOTR
	MOV	DI,0
ES1:	CMP	DI,20
	JE	FINME
	CMP	BURMED[DI],'%'
	JE	DEJESP
	CMP	BURMED[DI],'&'
	JE	DEJESP
	CMP	BURMED[DI],'$'
	JE	DEJESP
	CMP	BURMED[DI],'?'
	JE	MOTR
	MOV	DL,BURMED[DI]
	MOV	AH,02H
	INT	21H
	INC	DI
	JMP	ES1
DEJESP:MENS	ESPACIO
	 INC	DI
	 JMP	ES1
MOTR:	MOV	DL,00H
	MOV	AH,02H
	INT	21H
	INC	DI
	JMP	ES1
FINME:
ENDM
;****FIN MACRO MOSTRAR MEDICO EN FORMA DESCENDENTE***********

;******************************************************
GET_VIS_VECTOR	MACRO	POS
		MOV 	SI,POS
		MOV	AX,VECTOR[SI]
		MOV	BINVAL,AX
            CALL  BINASCIEE
		MACROMENSAJE	ASCVALL
		ENDM
;******************************************************
MACROMENSAJE	MACRO	M           
		MOV	AH,09H
		MOV	DX,OFFSET M
		INT	21H
		ENDM

;****************FIN MACRO BURBUJA**********************
;MACRO DE RETARDO O DELAY
DELAY   MACRO   T1,T2
        LOCAL   DELA2,DELA1
        MOV     BL,T1
DELA2:  MOV     CX,T2
DELA1:  LOOP    DELA1
        DEC     BL
        JNZ     DELA2
        ENDM

;MACRO PARA VISUALIZAR MENSAJES
MENS	MACRO	MS
	MOV	AH,09H
	MOV	DX,OFFSET MS
	INT	21H	
	ENDM

;MACRO PARA CONFIGURAR PUERTO DE COMNICACION SERIAL
;Y = 0 PARA COM1, = 1 PARA COM2
COM     MACRO   Y
        MOV     AH,00           ;SERVICIO DE CONFIGURACION PUERTO SERIAL
        MOV     AL,11100011B    ;9600 BPS, NO PARIDAD, 1 BIT DE PARADA
        MOV     DX,Y
        INT     14H
        ENDM
;**************************************************
;***********************INICIO MACRO PARA MOSTRAR MENSAJES POR PANTALLA*******
MENS	MACRO	MS
		MOV	AH,09H
       	 LEA       DX,MS
		INT	21H	
	ENDM
;*******************************************************************
;********************MACRO MOSTRAR VISITADORES,MEDICOS,PRODUCTOS***********
ML	MACRO	VECT
	LOCAL	LPRO1,ARR,P
	MENS 	SALTO
	MOV	BX,0
	MOV 	AH,02H
	MOV	DL,00H
	INT	21H
	INT	21H


LPRO1:	
	MOV	DL,VECT[BX]
	CMP	DL,'&'
	JE	P
	CMP	DL,'%'
	JE	ARR
	CMP	DL,'$'
	JE	P
	INT	21H
	INC	BX
	JMP	LPRO1
ARR:	MOV	DL,00H
	INT	21H
	INT	21H	
	INT	21H
	INT	21H
	INT	21H
	INC	BX
	JMP	LPRO1
P:
	ENDM
;*****************************************************************
;**********MACRO ENVIAR REGISTRO DE MEDICOS***********************
ENVIFOK	MACRO	COMP
	LOCAL	KLM,SIES,OTROMED	
	MOV	DI,0
KLM:	MOV	AL,COMP[DI]
	CMP	AL,'%'
	JE	SIES
	CMP	AL,VECIN[DI]
	JNE	OTROMED
	INC	DI
	JMP	KLM
SIES:	MOV	TEMP,'A'
OTROMED:
ENDM		
;*****************************************************************
;********************MACRO MOSTRAR REGISTRO VISITADORES***********
MRV	MACRO	VECTO
	LOCAL	LPRO10,ARR1,PP,AA,CONTN,MUST,SINMEN,FN,ARR2
	MENS 	SALTO
	MENS	T_SUP3
	MENS	T_ENC3 
	MENS	T_DIV3
	MENS 	SALTO
	MOV	CL,0
	MOV	BX,0
	MOV 	AH,02H
	MOV	DL,00H
	INT	21H
LPRO10:	
	MOV	DL,VECTO[BX]
	CMP	DL,'&'
	JE	PP
	CMP	DL,'%'
	JE	ARR1
	CMP	DL,'+'
	JE	ARR2
	CMP	DL,'¦'
	JE	AA
	CMP	DL,'$'
	JE	FN
	INT	21H
	INC	BX
	JMP	LPRO10
ARR1:		
	MENS	ESPACIO	
	MOV	AH,02H
	INC	BX
	JMP	LPRO10
ARR2:	
	MENS	ESPACIO	
	MOV	AH,02H
	INC	BX
	JMP	LPRO10
PP:	MOV	DL,00H
	MENS	ESPACIO
	MOV	AH,02H
	MOV	BX,19
	JMP	LPRO10
AA:	MOV	SI,BX
	INC	SI
	CMP	VECTO[SI],'0'
	JE	CONTN
	CMP	VECTO[SI],'1'
	JE	CONTN
	
CONTN:
	CMP	CL,0
	JE	MUST
	JMP	SINMEN
MUST:	
	MENS	T_LIN1
	MENS	T_ENC9
	MENS	T_INF3
SINMEN:
	MENS	SALTO
	MOV	AH,02H
	ADD	BX,4
	INC	CL
	JMP	LPRO10
FN:	MENS	SALTO
	JMP	IFIN
ENDM

;**************************************************************
TX	 MACRO	TRIR1		;///esTE PEDASO ES EL Q SE QUITARIA////
	 LOCAL	TXD,NOLISTO,LISTO,NVACIO,VACIO
         MOV    SI, OFFSET TRIR1
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
LISTO:  MOV    DX,LSR          ;VERIFICAR SI REGISTRO DE TRANSMISION
         MOV    CX,2FFFH        ;ESTA VACIO
NVACIO: IN     AL,DX
         TEST   AL,5
         JNZ     VACIO
         LOOP   NVACIO
VACIO:MOV    DX,COM1         ;CARGAR BYTE A TRANSMITIR EN EL REGISTRO THR
      MOV    AL,[SI]
      OUT    DX,AL
      INC   SI               ;DIRECCIONAR PUNTERO PROXIMO DATO
	MOV   AL,'"'           ;CARACTER DE CONTROL DE FIN DE TRAMA
      CMP   AL,[SI]
      JNZ   TXD
	MOV   SI,OFFSET TRIR1 ;INICIALIZAR PUNTERO DE MEMORIA DE DATOS
      ENDM
;********************************************************************
;MACRO PARA TRANSMITIR INFORMACION
TX1	 MACRO	TRIR
	 LOCAL	TXD1,NOLISTO1,LISTO1,NVACIO1,VACIO1,GAT,PER
         MOV    SI, OFFSET TRIR
TXD1:    MOV    DX,MCR         ;TRANSMISOR LISTO PARA COMUNICARSE
         MOV    AL,00000011B
         OUT    DX,AL
         MOV    DX,MSR          ;VERIFICAR SI EL RECEPTOR ESTA LISTO
         MOV    CX,2FFFH
NOLISTO1: IN     AL,DX
         AND    AL,00110000B
         CMP    AL,00110000B
         JZ     LISTO1
         LOOP   NOLISTO1
LISTO1:  MOV    DX,LSR          ;VERIFICAR SI REGISTRO DE TRANSMISION
         MOV    CX,2FFFH        ;ESTA VACIO
NVACIO1: IN     AL,DX
         TEST   AL,5
         JNZ     VACIO1
         LOOP   NVACIO1
VACIO1:MOV    DX,COM1         ;CARGAR BYTE A TRANSMITIR EN EL REGISTRO THR
      MOV    AL,[SI]
      OUT    DX,AL
      INC   SI               ;DIRECCIONAR PUNTERO PROXIMO DATO
	CMP	TEMP,'A'
	JE	GAT
	MOV   AL,'$'           ;CARACTER DE CONTROL DE FIN DE TRAMA
      CMP   AL,[SI]
      JNZ   TXD1
	JMP	PER
GAT:	MOV	AL,'"'
	CMP   AL,[SI]
	JNZ   TXD1
PER:
	MOV   SI,OFFSET TRIR ;INICIALIZAR PUNTERO DE MEMORIA DE DATOS

      ENDM
;********************
FIL_COL MACRO F,C
	MOV	CUR_FIL,F
	MOV	CUR_COL,C
ENDM
;********************
;**********************************************
;************MACRO BUSCAR VISITADOR PARA CODIGO OPERACION************		
MACC		MACRO	VECVISTA,VECCOM
		LOCAL	SIVT,CTI,YEST,MINFOOPE,TRUC,CARR1,CPP,CAA,COMCOD1,CARR2
		MOV	DI,0
		MOV	SI,0
SIVT:		CMP	VECVISTA[20],'¦'
		JNE	COMCOD1
		MOV	AL,VECVISTA[SI]
		CMP	AL,'.'
		JE	COMCOD1
		CMP	AL,'¦'
		JE	CTI
		INC	SI
		JMP	SIVT
CTI:		INC	SI
		CMP	VECVISTA[SI],'.'
		JE	COMCOD1
		MOV	AL,VECCOM[DI]
		CMP	AL,VECVISTA[SI]
		JNE	YEST
		INC	SI	
		INC	DI
		MOV	AL,VECCOM[DI]
		CMP	AL,VECVISTA[SI]
		JNE	YEST
		INC	SI	
		INC	DI
		MOV	AL,VECCOM[DI]
		CMP	AL,VECVISTA[SI]
		JNE	YEST
		JMP	MINFOOPE

YEST:		
		MOV	DI,0
		INC	SI
		CMP	VECVISTA[SI],'.'
		JE	COMCOD1
		JMP	SIVT	

MINFOOPE:	INC	SI
		MENS	T_LIN
		MENS	T_ENC8
		MENS	T_INF2
		MENS	SALTO
		MOV	AH,02H
		MOV	BX,0
TRUC:	MOV	DL,VECVISTA[BX]
	CMP	DL,'&'
	JE	CPP
	CMP	DL,'%'
	JE	CARR1
	CMP	DL,'¦'
	JE	CAA
	CMP	DL,'$'
	JE	CAA
	CMP	DL,'+'
	JE	CARR2
	INT	21H
	INC	BX
	JMP	TRUC
CARR1:MENS	ESPACIO1
	MOV	AH,02H
	INC	BX
	JMP	TRUC
CARR2:FIL_COL	11,54
	CALL	SET_CURSOR
	MOV	AH,02H
	INC	BX
	JMP	TRUC
CPP:	MENS	ESPACIO1
	MOV	AH,02H
	MOV	BX,SI
	JMP	TRUC
CAA:	MENS	SALTO
	MENS	SALTO
	JMP	IFIN	
	
COMCOD1:
ENDM
;*****************FIN MACRO CODIGO OPERACION**************

.CODE
ORG     0000
MOV     AX,@DATA
MOV     DS,AX
JMP     MAIN

;************CODIGO BURBUJA**********************
;****************************************************
BURBUJA_16BITS:	MOV	SI,0
		MOV	DI,0
		MOV	CX,10
CICLOBURB0:	MOV	DI,SI
CICLOBURB1:	ADD	DI,2
		CMP	DI,20
		JE	FINPARADI
		
		MOV	AX,VECTOR[SI]
		CMP	AX,VECTOR[DI]
		JA	CICLOBURB1		;DESCENDENTE
		;JBE	CICLOBURB1		;ASCENDENTE
		
		MOV	TEMPP,AX			;POSICION SI A TEMP
		MOV	AX,VECTOR[DI]		
		MOV	VECTOR[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMPP
		MOV	VECTOR[DI],AX		;INTERCAMBIO POSICION
		
		MOV	AX,POSI[SI]
		MOV	TEMPP,AX			;POSICION SI A TEMP
		MOV	AX,POSI[DI]		
		MOV	POSI[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMPP
		MOV	POSI[DI],AX		;INTERCAMBIO POSICION
		
		JMP	CICLOBURB1
		
FINPARADI:	ADD	SI,2		
		LOOP	CICLOBURB0
		RET
;****************************************************
BURBUJA_16BITS_VIS:	MOV	SI,0
		MOV	DI,0
		MOV	CX,5
CICLOBURB00:MOV	DI,SI
CICLOBURB11:ADD	DI,2
		CMP	DI,10
		JE	FINPARADII
		
		MOV	AX,VECTOR[SI]
		CMP	AX,VECTOR[DI]
		;JA	CICLOBURB11		;DESCENDENTE
		JBE	CICLOBURB11		;ASCENDENTE
		
		MOV	TEMPP,AX			;POSICION SI A TEMPP
		MOV	AX,VECTOR[DI]		
		MOV	VECTOR[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMPP
		MOV	VECTOR[DI],AX		;INTERCAMBIO POSICION
		
		MOV	AX,POSIVIS[SI]
		MOV	TEMPP,AX			;POSICION SI A TEMPP
		MOV	AX,POSIVIS[DI]		
		MOV	POSIVIS[SI],AX		;ACTUALIZO POSICION DI A SI
		MOV	AX,TEMPP
		MOV	POSIVIS[DI],AX		;INTERCAMBIO POSICION
		
		JMP	CICLOBURB11
		
FINPARADII:	ADD	SI,2		
		LOOP	CICLOBURB00
		RET

;***************FIN CODIGO BURBUJA***************

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
;SUBRUTINA DE TRANSMISION DE UNA CADENA DE CARACTERES
;******************************************************
;***********************************************************
;****************************************************************
;RUTINA QUE RECIBE UN DATO SERIALMENTE EN AL Y LO ALMACENA EN RXDATO
RX:                ;GUARDAR EN LA PILA TODOS LOS REGISTROS
        MOV     AH,02   ;SERVICIO DE LECTURA POR EL PUERTO SERIAL
        MOV     DX,00   ;SELECCIONAR COM1
        INT     14H
	CMP	AL,'$'
	JE	IRT
	CMP	AL,00H
	JE	IRT
        MOV     RXDATO,AL  ;ALMACENAR DATO RECIBIDO EN RXDATO
        DELAY   0FH,03FFH  ;ESPERA PARA RECIBIR PROXIMO DATO
                       ;RECUPERAR DE LA PILA TODOS LOS REGISTROS
IRT:   MOV     RXDATO,AL   
	 RET
;****************************************************************
;*************************************************
CAPFECHASUM:
        MOV     AH,2AH
        INT     21H
;DIA	
        MOV     AX,0
        MOV     AL,DL           ;DIA
        AAM
        ;OR      AX,3030H
       
	MOV	DIA1,AH
	MOV	DIA2,AL
	MOV	AH,00
	MOV	AL,DIA1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,DIA2
	MOV	DIA,AL
	
;MES
       MOV     AX,0
        MOV     AL,DH    ;MES
        AAM
        ;OR      AX,3030H
    
	MOV	MES1,AH
	MOV	MES2,AL
	MOV	AH,00
	MOV	AL,MES1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,MES2
	MOV	MES,AL
	
	MOV	AL,DIA
	ADD	AL,MES
	MOV	DIAMES,AL
	

;***************************************************************
;AÑO      
	MOV     BINVAL,CX    ;A¥O
	;MOV	AL,CL
        	CALL    BINASCIE
        	MOV     BL,ASCVALL[2]
	AND	BL,0FH
        	MOV     ANO1,BL
        	MOV     BL,ASCVALL[3]
	AND	BL,0FH
        	MOV     ANO2,BL
        	MOV	AH,02H
	MOV	DL,ANO1
	INT	21H
	MOV	DL,ANO2
	INT	21H
	
	MOV	AH,00
	MOV	AL,ANO1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,ANO2
	MOV	ANO,AL
	MOV	AL,ANO
	ADD	AL,DIAMES
	MOV	DMA,AL
	RET

CAPHORASUM:
	MOV	AH,2CH
	INT	21H

	MOV     AX,0
        MOV     AL,CH		;HORA
        AAM
       ; OR      AX,3030H
	
        MOV	HORA1,AH
	MOV	HORA2,AL
	MOV	AH,00
	MOV	AL,HORA1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,HORA2
	MOV	HORA,AL
;*********************************
	MOV     AX,0
        MOV     AL,CL		;MINUTOS
        AAM
        ;OR      AX,3030H

	MOV	MIN1,AH
	MOV	MIN2,AL
	MOV	AH,00
	MOV	AL,MIN1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,MIN2
	MOV	MIN,AL
;********************************
	MOV     AX,0
        MOV     AL,DH		;SEGUNDOS
        AAM
        ;OR      AX,3030H
        
	MOV	SEC1,AH
	MOV	SEC2,AL
	MOV	AH,00
	MOV	AL,SEC1
	MOV	TMP,10
	MUL	TMP
	ADD	AL,SEC2
	MOV	SEC,AL
	
	MOV	AL,HORA
	ADD	AL,DMA
	ADD	AL,MIN
	ADD	AL,SEC

	MOV	AH,0
	MOV	BINVAL,AX
      CALL  BINASCIEE
	
	CMP	ASCVALL[2],'1'
	JE	MKL
	CMP	ASCVALL[2],'2'
	JE	MKL
	MOV	ASCVALL[2],'0'
MKL:
RET
;*************************************************
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
	JE	HORR
	MOV	AL,ASCVAL[2]
	MOV	HOR1,AL
	MOV	PIN[0],AL
	JMP	MINN
HORR:	MOV	PIN[0],'0'
	MOV	HOR1,'0'
MINN:	MOV	AX,0000H
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
	JMP	SECC
MINU:	MOV	PIN[2],'0'
	MOV	MIN1,'0'
SECC:	MOV	AX,0000H
	MOV	AL,SEGUNDO
	MOV    BINVAL,AX
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
;****************************************************
BINASCIE:
       LEA     SI,ASCVALL
       MOV     CX,4
       MOV     AL,00H
C101:   MOV     [SI],AL
       INC     SI
       LOOP    C101
       MOV     CX,10
       LEA     SI,ASCVALL+3
       MOV     AX,BINVAL
C201:   CMP     AX,CX
       JB      C301
       XOR     DX,DX
       DIV     CX
       OR      DL,30H
       MOV     [SI],DL
       DEC     SI
       JMP     C201
C301:   OR      AL,30H
       MOV     [SI],AL
       RET
;******************************************************
;***************************************************
BINASCIII:       
	LEA     SI,ASCVAL
        MOV     CX,5
        MOV     AL,00H
C100:    MOV     [SI],AL
        INC     SI
        LOOP    C100
        MOV     CX,10
        LEA     SI,ASCVALL+4
        MOV     AX,BINVAL
C200:    CMP     AX,CX
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
;********FIN - CAPTURAR HORA DEL SISTEMA*******************
;***************************************************
BINASCIEE:       
	LEA     SI,ASCVALL
        MOV     CX,5
        MOV     AL,00H
C1000:    MOV     [SI],AL
        INC     SI
        LOOP    C1000
        MOV     CX,10
        LEA     SI,ASCVALL+4
        MOV     AX,BINVAL
C2000:    CMP     AX,CX
        JB      C3000
        XOR     DX,DX
        DIV     CX
        OR      DL,30H
        MOV     [SI],DL
        DEC     SI
        JMP     C2000
C3000:    OR      AL,30H
        MOV     [SI],AL
        RET
;********FIN - CAPTURAR HORA DEL SISTEMA*********
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
;******************MAIN***************************
MAIN:	MOV	PVIS1,20
	MOV	PVIS2,20
	MOV	PVIS3,20
	MOV	PVIS4,20
	MOV	PVIS5,20
	MOV	PMED1,20
	MOV	PMED2,20
	MOV	PMED3,20
	MOV	PMED4,20
	MOV	PMED5,20
	MOV	PMED6,20
	MOV	PMED7,20
	MOV	PMED8,20
	MOV	PMED9,20
	MOV	PMED10,20

MAIN1:	MOV	TEMP,'B'
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR	
	COM     00      ;CONFIGURAR PUERTO SERIAL COM1
	MENS 	TITULO
	MENS 	SALTO

ECT:

	MENS	T_INI0
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
	MENS	T_INI3
	MENS	HECHO6
	MENS	T_INI3
	MENS	HECHO7
	MENS	T_INI3
	MENS	HECHO8
	MENS	T_INI4
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
	FIL_COL	22,46
	CALL	SET_CURSOR
	MENS	SALIO
SREC:	CALL	RX
	CMP	RXDATO,'/'
	JE	ENVVIS		;ENVIAR A LA TERMINAL LOS VISITADORES
	CMP	RXDATO,'('
	JE	ENVMED		;ENVIAR A LA TERMINAL LOS MEDICOS
	CMP	RXDATO,'¡'
	JE	ENVPRO		;ENVIAR A LA TERMINAL LOS PRODUCTOS
	CMP	RXDATO,'='
	JE	COMPROBAR
	CMP	RXDATO,'@'
	JE	ENNIXMED
	CALL	TECLA		;CAPTURAR TECLA EN EL SERVIDOR
	CMP	AL,'1'
	JE	LVIS	 	;LISTA VISITADORES EN EL SERVIDOR
	CMP	AL,'2'
	JE	LMED		;LISTA MEDICOS EN EL SERVIDOR
	CMP	AL,'3'
	JE	LPRO		;LISTA PRODUCTOS EN EL SERVIDOR
	CMP	AL,'4'
	JE	VTAVIS	;VISITA REGISTRADA DE CUALQUIER VISITADOR
	CMP	AL,'5'
	JE	VTACOD
	CMP	AL,'8'
	JE	TOTVISITAS	; VER VISITAS TOTALES(SUMA DE TODOS LOS VISITADORES)
	CMP	AL,'7'
	JE	ORDENAR
	CMP	AL,'6'
	JE	ORDENAVIS
	CMP	AL,27		;EL CODIGO ASCII DEL 'Esc' ES EL 27 EN DEC O EL 1BH EN HEXA
	JE	FIN
	JMP	SREC
MRE:	CALL	PCUR			;PCUR: POSICIONAR CURSOR
	CALL	CAPTHOR
	CALL	MRELOJ			;MRE: MOSTRAR RELOJ
	;JMP	MRE
	JMP	FIN
;***************************************************
ENNIXMED:	MOV	DI,0
ENVIX:	CALL	RX
		CMP	RXDATO,00H
		JE	NOMAS	
		MOV	VECIN[DI],AL
		INC	DI
		JMP	ENVIX
NOMAS:	
		MOV	TEMP,'B'
		ENVIFOK	MEDICO1
		CMP		TEMP,'A'
		JE		ENVSI
		ENVIFOK	MEDICO2
		CMP		TEMP,'A'
		JE		ENVSI1
		ENVIFOK	MEDICO3
		CMP		TEMP,'A'
		JE		ENVSI2
		ENVIFOK	MEDICO4
		CMP		TEMP,'A'
		JE		ENVSI3
		ENVIFOK	MEDICO5
		CMP		TEMP,'A'
		JE		ENVSI4
		ENVIFOK	MEDICO6
		CMP		TEMP,'A'
		JE		ENVSI5
		ENVIFOK	MEDICO7
		CMP		TEMP,'A'
		JE		ENVSI6
		ENVIFOK	MEDICO8
		CMP		TEMP,'A'
		JE		ENVSI7
		ENVIFOK	MEDICO9
		CMP		TEMP,'A'
		JE		ENVSI8
		ENVIFOK	MEDICO10
		CMP		TEMP,'A'
		JE		ENVSI9
		
		MOV		VECTENV[0],'}'
		MOV		VECTENV[1],'$'
		TX1		VECTENV
		JMP		VACVECIN

VACVECIN:	MOV	DI,0
VACVECI:	CMP	DI,61
		JE	MAIN1
		MOV	VECIN[DI],00H
		INC	DI
		JMP	VACVECI
				
ENVSI:	TX1		MEDICO1
		MENS		MEDICO1
		JMP		VACVECIN
ENVSI1:	TX1		MEDICO2
		MENS		MEDICO2
		JMP		VACVECIN
ENVSI2:	TX1		MEDICO3
		MENS		MEDICO3
		JMP		VACVECIN
ENVSI3:	TX1		MEDICO4
		MENS		MEDICO4
		JMP		VACVECIN
ENVSI4:	TX1		MEDICO5
		MENS		MEDICO5
		JMP		VACVECIN
ENVSI5:	TX1		MEDICO6
		MENS		MEDICO6
		JMP		VACVECIN
ENVSI6:	TX1		MEDICO7
		MENS		MEDICO7
		JMP		VACVECIN
ENVSI7:	TX1		MEDICO8
		MENS		MEDICO8
		JMP		VACVECIN
ENVSI8:	TX1		MEDICO9
		MENS		MEDICO9
		JMP		VACVECIN
ENVSI9:	TX1		MEDICO10
		MENS		MEDICO10
		JMP		VACVECIN


;***************************************************
SET_CURSOR:	;///////RUTINA PARA POSICIONAR EL CURSOR EN LA FILA Y COLUMNA DESEADA///////
        PUSH    AX              ;salvamos registros
        PUSH    BX
	PUSH	DX
	MOV 	AH,02H		;Petición para designar el cursor
	MOV 	BH,00		;numero de pagina
	MOV 	DH,CUR_FIL	;fila
	MOV	DL,CUR_COL	;columna
	INT 	10H
	POP	DX		;Recuperamos registros
        POP     BX
        POP     AX
	RET
;***************************************************
VTACOD:	FIL_COL	1,1
		CALL	SET_CURSOR
		CALL	COLOR
		MENS 	TITULO
		MENS	SALTO
		MENS	PECODO
		MENS	SALTO
		MENS 	CODOPE
		MOV	DI,0
		MOV	SI,0
VTAOPE1:	CMP	SI,3
		JE	COMPCODD
		CALL	TEC;CAPTEC
		;CMP	AL,0DH
		;JE	COMPCODD
		CMP	AL,30H
		JB	VTAOPE1
		CMP	AL,39H
		JA	VTAOPE1
		CALL	VERPANT
		INC	SI
		MOV	VECCOM[DI],AL
		INC	DI
		JMP	VTAOPE1

COMPCODD:	MENS	SALTO
		MACC	VISITADOR1,VECCOM
		MACC	VISITADOR2,VECCOM
		MACC	VISITADOR3,VECCOM
		MACC	VISITADOR4,VECCOM
		MACC	VISITADOR5,VECCOM
		MENS	ERRORCOD
		MENS	SALTO
		MENS	SALTO
		JMP	IFIN
;***************************************************
TOTVISITAS:	FIL_COL	1,1
		CALL	SET_CURSOR
		CALL	COLOR
		MENS 	TITULO
		MOV	AL,VISITADOR1[19]
		AND	AL,0FH
		MOV	BL,VISITADOR2[19]
		AND	BL,0FH
		ADD	AL,BL		
		MOV	BL,VISITADOR3[19]
		AND	BL,0FH
		ADD	AL,BL
		MOV	BL,VISITADOR4[19]
		AND	BL,0FH
		ADD	AL,BL
		MOV	BL,VISITADOR5[19]
		AND	BL,0FH
		ADD	AL,BL
		MOV	AH,0
		MOV	BINVAL,AX
         	CALL  BINASCII		
		MENS	NUMTOVIS
		MOV	DL,ASCVAL[2]
		MOV	AH,02H
		INT	21H
		MOV	DL,ASCVAL[3]
		INT	21H
		MENS	SALTO
		MENS	SALTO
		JMP	IFIN
;**************************************************
VTAVIS:	FIL_COL	1,1
		CALL	SET_CURSOR
		CALL	COLOR
		MENS 	TITULO
		MENS	SALTO
		MENS	SALTO
		MENS	VISCOD
		MENS	SALTO
		MENS 	CODVIS
		MOV	DI,0
		MOV	SI,0
VTAVIS1:	CMP	SI,8
		JE	COMPARVIS1
		CALL	TEC;CAPTEC
		;CMP	AL,0DH
		;JE	COMPARVIS1
		CMP	AL,30H
		JB	VTAVIS1
		CMP 	AL,39H
		JA	VTAVIS1
		CALL	VERPANT
		INC	SI
		MOV	VECCOM[DI],AL
		INC	DI
		JMP	VTAVIS1
;**************************************************
;**************************************************
COMPARVIS1:	MOV	DI,0
COMP1:	MOV	BL,VISITADOR1[DI]
		CMP	BL,'%'
		JE	F1
		CMP	BL,VECCOM[DI]
		JE	CONT1
		MOV	DI,0
		JMP	COMPARVIS2
F1:		MRV	VISITADOR1
		JMP	IFIN
CONT1:	INC	DI
		JMP	COMP1

COMPARVIS2:	MOV	BL,VISITADOR2[DI]
		CMP	BL,'%'
		JE	F2
		CMP	BL,VECCOM[DI]
		JE	CONT2
		MOV	DI,0
		JMP	COMPARVIS3
F2:		MRV	VISITADOR2
		JMP	IFIN
CONT2:	INC	DI	
		JMP	COMPARVIS2
COMPARVIS3:	MOV	BL,VISITADOR3[DI]		
		CMP	BL,'%'
		JE	F3
		CMP	BL,VECCOM[DI]
		JE	CONT3
		MOV	DI,0
		JMP	COMPARVIS4
F3:		MRV	VISITADOR3
		JMP	IFIN
CONT3:	INC	DI
		JMP	COMPARVIS3

COMPARVIS4:	MOV	BL,VISITADOR4[DI]		
		CMP	BL,'%'
		JE	F4
		CMP	BL,VECCOM[DI]
		JE	CONT4
		MOV	DI,0
		JMP	COMPARVIS5
F4:		MRV	VISITADOR4
		JMP	IFIN
CONT4:	INC	DI
		JMP	COMPARVIS4
COMPARVIS5:	MOV	BL,VISITADOR5[DI]		
		CMP	BL,'%'
		JE	F5
		CMP	BL,VECCOM[DI]
		JE	CONT5
		MOV	DI,0
		JMP	ERVISI		; NO EXISTE EL VISITADOR
F5:		MRV	VISITADOR5
		JMP	IFIN
CONT5:	INC	DI
		JMP	COMPARVIS5

ERVISI:	MENS	SALTO
		MENS	ERROR
		MENS	SALTO
		MENS	SALTO
		JMP	IFIN
;**************************************************
;***************************************************

;***************************************************
COMPROBAR:	MOV	DI,0
		MOV	SI,0
COMPROBAR1:	CALL	RX
		CMP	AL,'&'
		JE	PON
		MOV	VECIN[DI],AL
		INC	DI
		JMP	COMPROBAR1
PON:		MOV	VECIN[DI],'$'
		MENS	SALTO
		JMP	COMPARAR
;***************************************************
COMPARAR:	MOV	DI,0
COMPARAR1:	MOV	BL,VISITADOR1[DI]
		CMP	BL,'%'
		JE	S1
		CMP	BL,VECIN[DI]
		JE	SIGA
		MOV	DI,0
		JMP	COMPARAR2
S1:		MOV	VIS,1
		JMP	OKVIS
SIGA:		INC	DI
		JMP	COMPARAR1
COMPARAR2:	MOV	BL,VISITADOR2[DI]
		CMP	BL,'%'
		JE	S2
		CMP	BL,VECIN[DI]
		JE	SIGA1
		MOV	DI,0
		JMP	COMPARAR3
S2:		MOV	VIS,2
		JMP	OKVIS
SIGA1:	INC	DI	
		JMP	COMPARAR2
COMPARAR3:	MOV	BL,VISITADOR3[DI]		
		CMP	BL,'%'
		JE	S3
		CMP	BL,VECIN[DI]
		JE	SIGA2
		MOV	DI,0
		JMP	COMPARAR4
S3:		MOV	VIS,3
		JMP	OKVIS
SIGA2:	INC	DI
		JMP	COMPARAR3
COMPARAR4:	MOV	BL,VISITADOR4[DI]		
		CMP	BL,'%'
		JE	S4
		CMP	BL,VECIN[DI]
		JE	SIGA3
		MOV	DI,0
		JMP	COMPARAR5
S4:		MOV	VIS,4
		JMP	OKVIS
SIGA3:	INC	DI
		JMP	COMPARAR4
COMPARAR5:	MOV	BL,VISITADOR5[DI]		
		CMP	BL,'%'
		JE	S5
		CMP	BL,VECIN[DI]
		JE	SIGA4
		MOV	DI,0
		JMP	ERVIS
S5:		MOV	VIS,5
		JMP	OKVIS
SIGA4:	INC	DI
		JMP	COMPARAR5
ERVIS:	MENS	SALTO
		MENS	SALTO
		MENS	SALTO
		MOV	VECTENV[0],'â'
		MOV	VECTENV[1],'$'
		TX1	VECTENV
		MOV	VECTENV[0],00H
		MOV	VECTENV[1],00H
		JMP	MAIN1;IFIN	
OKVIS:	MOV	BX,0
		INC	DI
		MOV	SI,DI
COMPARAR6:	MOV	CL,MEDICO1[BX]
		CMP	CL,'%'
		JE	M1
		CMP	CL,VECIN[DI]
		JE	SIGA5
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR7
M1:		MOV	MED,0
		JMP	OKMED	
SIGA5:	INC	DI
		INC	BX
		JMP	COMPARAR6
COMPARAR7:	MOV	CL,MEDICO2[BX]
		CMP	CL,'%'
		JE	M2
		CMP	CL,VECIN[DI]
		JE	SIGA6
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR8
M2:		MOV	MED,1
		JMP	OKMED
SIGA6:	INC	DI
		INC	BX
		JMP	COMPARAR7
COMPARAR8:	MOV	CL,MEDICO3[BX]
		CMP	CL,'%'
		JE	M3
		CMP	CL,VECIN[DI]
		JE	SIGA7
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR9
M3:		MOV	MED,2
		JMP	OKMED
SIGA7:	INC	DI
		INC	BX
		JMP	COMPARAR8
COMPARAR9:	MOV	CL,MEDICO4[BX]
		CMP	CL,'%'
		JE	M4
		CMP	CL,VECIN[DI]
		JE	SIGA8
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR10
M4:		MOV	MED,3
		JMP	OKMED
SIGA8:	INC	DI
		INC	BX
		JMP	COMPARAR9
COMPARAR10:	MOV	CL,MEDICO5[BX]
		CMP	CL,'%'
		JE	M5
		CMP	CL,VECIN[DI]
		JE	SIGA9
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR11
M5:		MOV	MED,4
		JMP	OKMED
SIGA9:	INC	DI
		INC	BX
		JMP	COMPARAR10
COMPARAR11:	MOV	CL,MEDICO6[BX]
		CMP	CL,'%'
		JE	M6
		CMP	CL,VECIN[DI]
		JE	SIGA10
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR12
M6:		MOV	MED,5
		JMP	OKMED
SIGA10:	INC	DI
		INC	BX
		JMP	COMPARAR11
COMPARAR12:	MOV	CL,MEDICO7[BX]
		CMP	CL,'%'
		JE	M7
		CMP	CL,VECIN[DI]
		JE	SIGA11
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR13
M7:		MOV	MED,6
		JMP	OKMED
SIGA11:	INC	DI
		INC	BX
		JMP	COMPARAR12
COMPARAR13:	MOV	CL,MEDICO8[BX]
		CMP	CL,'%'
		JE	M8
		CMP	CL,VECIN[DI]
		JE	SIGA12
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR14
M8:		MOV	MED,7
		JMP	OKMED
SIGA12:	INC	DI
		INC	BX
		JMP	COMPARAR13
COMPARAR14:	MOV	CL,MEDICO9[BX]
		CMP	CL,'%'
		JE	M9
		CMP	CL,VECIN[DI]
		JE	SIGA13
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR15
M9:		MOV	MED,8
		JMP	OKMED
SIGA13:	INC	DI
		INC	BX
		JMP	COMPARAR14
COMPARAR15:	MOV	CL,MEDICO10[BX]
		CMP	CL,'%'
		JE	M10
		CMP	CL,VECIN[DI]
		JE	SIGA14
		MOV	DI,SI
		MOV	BX,0
		JMP	ERMED	;COMPARAR16
M10:		MOV	MED,9
		JMP	OKMED
SIGA14:	INC	DI
		INC	BX
		JMP	COMPARAR15
ERMED:	MOV	VECTENV[0],'Z'
		MOV	VECTENV[1],'$'
		TX1	VECTENV
		JMP	MAIN1;IFIN		
OKMED:	MOV	BX,0
		INC	DI
		INC	DI
		INC	DI
		MOV	SI,DI
COMPARAR16:	MOV	CL,PRODUCTO1[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA15
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR17		
SIGA15:	INC	DI
		INC	BX	
		JMP	COMPARAR16
COMPARAR17:	MOV	CL,PRODUCTO2[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA16
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR18	
SIGA16:	INC	DI
		INC	BX
		JMP	COMPARAR17
COMPARAR18:	MOV	CL,PRODUCTO3[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA17
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR19	
SIGA17:	INC	DI
		INC	BX
		JMP	COMPARAR18
COMPARAR19:	MOV	CL,PRODUCTO4[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA18
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR20
SIGA18:	INC	DI
		INC	BX
		JMP	COMPARAR19
COMPARAR20:	MOV	CL,PRODUCTO5[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA19
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR21
SIGA19:		INC	DI
		INC	BX
		JMP	COMPARAR20
COMPARAR21:	MOV	CL,PRODUCTO6[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA20
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR22
SIGA20:		INC	DI
		INC	BX
		JMP	COMPARAR21
COMPARAR22:	MOV	CL,PRODUCTO7[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA21
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR23
SIGA21:		INC	DI
		INC	BX
		JMP	COMPARAR22
COMPARAR23:	MOV	CL,PRODUCTO6[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA22
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR24
SIGA22:		INC	DI
		INC	BX
		JMP	COMPARAR23
COMPARAR24:	MOV	CL,PRODUCTO7[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA23
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR25
SIGA23:		INC	DI
		INC	BX
		JMP	COMPARAR24
COMPARAR25:	MOV	CL,PRODUCTO8[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA24
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR26
SIGA24:		INC	DI
		INC	BX
		JMP	COMPARAR25
COMPARAR26:	MOV	CL,PRODUCTO9[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA25
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR27
SIGA25:		INC	DI
		INC	BX
		JMP	COMPARAR26
COMPARAR27:	MOV	CL,PRODUCTO10[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA26
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR28
SIGA26:		INC	DI
		INC	BX
		JMP	COMPARAR27
COMPARAR28:	MOV	CL,PRODUCTO11[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA27
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR29
SIGA27:		INC	DI
		INC	BX
		JMP	COMPARAR28
COMPARAR29:	MOV	CL,PRODUCTO12[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA28
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR30
SIGA28:		INC	DI
		INC	BX
		JMP	COMPARAR29
COMPARAR30:	MOV	CL,PRODUCTO13[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA29
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR31
SIGA29:		INC	DI
		INC	BX
		JMP	COMPARAR30
COMPARAR31:	MOV	CL,PRODUCTO14[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA30
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR32
SIGA30:		INC	DI
		INC	BX
		JMP	COMPARAR31
COMPARAR32:	MOV	CL,PRODUCTO15[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA31
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR33
SIGA31:		INC	DI
		INC	BX
		JMP	COMPARAR32
COMPARAR33:	MOV	CL,PRODUCTO16[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA32
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR34
SIGA32:		INC	DI
		INC	BX
		JMP	COMPARAR33
COMPARAR34:	MOV	CL,PRODUCTO17[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA33
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR35
SIGA33:		INC	DI
		INC	BX
		JMP	COMPARAR34
COMPARAR35:	MOV	CL,PRODUCTO18[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA34
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR36
SIGA34:		INC	DI
		INC	BX
		JMP	COMPARAR35
COMPARAR36:	MOV	CL,PRODUCTO19[BX]
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA35
		MOV	DI,SI
		MOV	BX,0
		JMP	COMPARAR37
SIGA35:	INC	DI
		INC	BX
		JMP	COMPARAR36
COMPARAR37:	MOV	CL,PRODUCTO20[BX]		
		CMP	VECIN[DI],'+'
		JE	BIENPRO
		CMP	CL,'%'
		JE	OKPRO
		CMP	CL,VECIN[DI]
		JE	SIGA36
		MOV	DI,SI
		MOV	BX,0
		JMP	ERPRO
SIGA36:	INC	DI
		INC	BX
		JMP	COMPARAR37
ERPRO:	MOV	VECTENV[0],'W'
		MOV	VECTENV[1],'$'
		TX1	VECTENV
		JMP	MAIN1;IFIN
OKPRO:	INC	DI	;
		MOV	BX,0
		MOV	SI,DI	;
		JMP	COMPARAR16
BIENPRO:	MOV	VECTENV[0],'Q'; ENVIA Q PARA CONFIRMAR REGISTRO
		MOV	VECTENV[1],'$'
POL:		CALL	CAPFECHASUM
		MENS	SALTO
		CALL	CAPHORASUM
		MOV	VECTENV[0],'Q'
		MOV	AL,ASCVALL[2]
		MOV	VECTENV[1],AL
		MOV	AL,ASCVALL[3]
		MOV	VECTENV[2],AL
		MOV	AL,ASCVALL[4]
		MOV	VECTENV[3],AL
		MOV	VECTENV[4],'$'
		TX1	VECTENV
		JMP	BUSCARINGV
		
;***************************************************
;***************************************************
BUSCARINGV:	CMP	VIS,1
		JE	INVIS1
		CMP	VIS,2
		JE	INVIS2	
		CMP	VIS,3
		JE	INVIS3
		CMP	VIS,4
		JE	INVIS4
		CMP	VIS,5
		JE	INVIS5
	
INVIS1:	MOV	BL,PVIS1
		MOV	BH,0
		MOV	SI,BX
		MOV	DI,9
	MOV	VISITADOR1[SI],'¦'
	MOV	AL,ASCVALL[2]
	INC	SI
	MOV	VISITADOR1[SI],AL
	MOV	AL,ASCVALL[3]
	INC	SI
	MOV	VISITADOR1[SI],AL
	MOV	AL,ASCVALL[4]
	INC	SI
	MOV	VISITADOR1[SI],AL
IV1:	INC	SI
	CMP	VECIN[DI],'$'
	JE	CODACEP1
	MOV	AL,VECIN[DI]
	MOV	VISITADOR1[SI],AL
	INC	DI
	JMP	IV1

INVIS2:	MOV	BL,PVIS2
		MOV	BH,0
		MOV	SI,BX
		MOV	DI,9
	MOV	VISITADOR2[SI],'¦'
	INC	SI
	MOV	AL,ASCVALL[2]
	MOV	VISITADOR2[SI],AL
	INC	SI
	MOV	AL,ASCVALL[3]
	MOV	VISITADOR2[SI],AL
	INC	SI
	MOV	AL,ASCVALL[4]
	MOV	VISITADOR2[SI],AL
IV2:	INC	SI
	CMP	VECIN[DI],'$'
	JE	CODACEP2
	MOV	AL,VECIN[DI]
	MOV	VISITADOR2[SI],AL
	INC	DI
	JMP	IV2

INVIS3:	MOV	BL,PVIS3
		MOV	BH,0
		MOV	SI,BX
		MOV	DI,9
	MOV	VISITADOR3[SI],'¦'
	INC	SI
	MOV	AL,ASCVALL[2]
	MOV	VISITADOR3[SI],AL
	INC	SI
	MOV	AL,ASCVALL[3]
	MOV	VISITADOR3[SI],AL
	INC	SI
	MOV	AL,ASCVALL[4]
	MOV	VISITADOR3[SI],AL
IV3:	INC	SI
	CMP	VECIN[DI],'$'
	JE	CODACEP3
	MOV	AL,VECIN[DI]
	MOV	VISITADOR3[SI],AL
	INC	DI
	JMP	IV3

INVIS4:	MOV	BL,PVIS4
		MOV	BH,0
		MOV	SI,BX
		MOV	DI,9
	MOV	VISITADOR4[SI],'¦'
	INC	SI
	MOV	AL,ASCVALL[2]
	MOV	VISITADOR4[SI],AL
	INC	SI
	MOV	AL,ASCVALL[3]
	MOV	VISITADOR4[SI],AL
	INC	SI
	MOV	AL,ASCVALL[4]
	MOV	VISITADOR4[SI],AL
IV4:	INC	SI
	CMP	VECIN[DI],'$'
	JE	CODACEP4
	MOV	AL,VECIN[DI]
	MOV	VISITADOR4[SI],AL
	INC	DI
	JMP	IV4

INVIS5:	MOV	BL,PVIS5		
		MOV	BH,0
		MOV	SI,BX
		MOV	DI,9
	MOV	VISITADOR5[SI],'¦'
	INC	SI
	MOV	AL,ASCVALL[2]
	MOV	VISITADOR5[SI],AL
	INC	SI
	MOV	AL,ASCVALL[3]
	MOV	VISITADOR5[SI],AL
	INC	SI
	MOV	AL,ASCVALL[4]
	MOV	VISITADOR5[SI],AL
IV5:	INC	SI
	CMP	VECIN[DI],'$'
	JE	CODACEP5
	MOV	AL,VECIN[DI]
	MOV	VISITADOR5[SI],AL
	INC	DI
	JMP	IV5


CODACEP1:	MOV	VISITADOR1[SI],'¦'
		MOV	BX,SI
		MOV	PVIS1,BL
		MOV	DL,VISITADOR1[19]
		INC	DL
		MOV	VISITADOR1[19],DL
		INC	SI
		INC	VIS01
		MOV	VISITADOR1[SI],'.'
		JMP	BUSCARINGM
CODACEP2:	MOV	VISITADOR2[SI],'¦'
		MOV	BX,SI
		MOV	PVIS2,BL
		MOV	DL,VISITADOR2[19]
		INC	DL
		MOV	VISITADOR2[19],DL
		INC	SI
		INC	VIS02
		MOV	VISITADOR2[SI],'.'
		JMP	BUSCARINGM
CODACEP3:	MOV	VISITADOR3[SI],'¦'
		MOV	BX,SI
		MOV	PVIS3,BL
		MOV	DL,VISITADOR3[19]
		INC	DL
		MOV	VISITADOR3[19],DL
		INC	SI
		INC	VIS03
		MOV	VISITADOR3[SI],'.'
		JMP	BUSCARINGM
CODACEP4:	MOV	VISITADOR4[SI],'¦'
		MOV	BX,SI
		MOV	PVIS4,BL
		MOV	DL,VISITADOR4[19]
		INC	DL
		MOV	VISITADOR4[19],DL
		INC	SI
		INC	VIS04
		MOV	VISITADOR4[SI],'.'
		JMP	BUSCARINGM
CODACEP5:	MOV	VISITADOR5[SI],'¦'
		MOV	BX,SI
		MOV	PVIS5,BL
		MOV	DL,VISITADOR5[19]
		INC	DL
		MOV	VISITADOR5[19],DL
		INC	SI
		INC	VIS05
		MOV	VISITADOR5[SI],'.'
		JMP	BUSCARINGM

BUSCARINGM:	CMP	MED,0
		JE	INMED0
		CMP	MED,1
		JE	INMED1
		CMP	MED,2
		JE	INMED2
		CMP	MED,3
		JE	INMED3
		CMP	MED,4
		JE	INMED4
		CMP	MED,5
		JE	INMED5
		CMP	MED,6
		JE	INMED6
		CMP	MED,7
		JE	INMED7
		CMP	MED,8
		JE	INMED8
		CMP	MED,9
		JE	INMED9

INMED0:	MOV	BL,PMED1
		MOV	BH,0
		MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO1[SI],'¦'
IM1:	INC	SI
	CMP	DI,8
	JE	Q1
	MOV	AL,VECIN[DI]
	MOV	MEDICO1[SI],AL
	INC	DI
	JMP	IM1

Q1:	MOV 	DI,17
P1:	CMP	VECIN[DI],'$'
	JE	H1
	MOV	AL,VECIN[DI]
	MOV	MEDICO1[SI],AL
	INC	DI
	INC 	SI
	JMP	P1

H1:	MOV	MEDICO1[SI],'¦'
	INC	SI
	MOV	MEDICO1[SI],'#'	;MOV	MEDICO1[SI],'"'
	MOV	BX,SI
	MOV	PMED1,BL
	MOV	DL,MEDICO1[19]
	INC	DL
	INC	DAT01
	MOV	MEDICO1[19],DL
	INC	SI			;
	MOV	MEDICO1[SI],'"'	;
	JMP	TG


INMED1:MOV	BL,PMED2
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO2[SI],'¦'
IM2:	INC	SI
	CMP	DI,8
	JE	Q2
	MOV	AL,VECIN[DI]
	MOV	MEDICO2[SI],AL
	INC	DI
	JMP	IM2

Q2:	MOV 	DI,17
P2:	CMP	VECIN[DI],'$'
	JE	H2
	MOV	AL,VECIN[DI]
	MOV	MEDICO2[SI],AL
	INC	DI
	INC 	SI
	JMP	P2

H2:	MOV	MEDICO2[SI],'¦'
	INC	SI
	MOV	MEDICO2[SI],'#'
	MOV	BX,SI
	MOV	PMED2,BL
	MOV	DL,MEDICO2[19]
	INC	DL
	INC	DAT02
	MOV	MEDICO2[19],DL
	INC	SI			;
	MOV	MEDICO2[SI],'"'	;
	JMP	TG

INMED2:MOV	BL,PMED3
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO3[SI],'¦'
IM3:	INC	SI
	CMP	DI,8
	JE	Q3
	MOV	AL,VECIN[DI]
	MOV	MEDICO3[SI],AL
	INC	DI
	JMP	IM3

Q3:	MOV 	DI,17
P3:	CMP	VECIN[DI],'$'
	JE	H3
	MOV	AL,VECIN[DI]
	MOV	MEDICO3[SI],AL
	INC	DI
	INC 	SI
	JMP	P3

H3:	MOV	MEDICO3[SI],'¦'
	INC	SI
	MOV	MEDICO3[SI],'#'
	MOV	BX,SI
	MOV	PMED3,BL
	MOV	DL,MEDICO3[19]
	INC	DL
	INC	DAT03
	MOV	MEDICO3[19],DL
	INC	SI			;
	MOV	MEDICO3[SI],'"'	;
	JMP	TG

INMED3:MOV	BL,PMED4
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO4[SI],'¦'
IM4:	INC	SI
	CMP	DI,8
	JE	Q4
	MOV	AL,VECIN[DI]
	MOV	MEDICO4[SI],AL
	INC	DI
	JMP	IM4

Q4:	MOV 	DI,17
P4:	CMP	VECIN[DI],'$'
	JE	H4
	MOV	AL,VECIN[DI]
	MOV	MEDICO4[SI],AL
	INC	DI
	INC 	SI
	JMP	P4

H4:	MOV	MEDICO4[SI],'¦'
	INC	SI
	MOV	MEDICO4[SI],'#'
	MOV	BX,SI
	MOV	PMED4,BL
	MOV	DL,MEDICO4[19]
	INC	DL
	INC	DAT04
	MOV	MEDICO4[19],DL
	INC	SI			;
	MOV	MEDICO4[SI],'"'	;
	JMP	TG

INMED4:MOV	BL,PMED5
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO5[SI],'¦'
IM5:	INC	SI
	CMP	DI,8
	JE	Q5
	MOV	AL,VECIN[DI]
	MOV	MEDICO5[SI],AL
	INC	DI
	JMP	IM5

Q5:	MOV 	DI,17
P5:	CMP	VECIN[DI],'$'
	JE	H5
	MOV	AL,VECIN[DI]
	MOV	MEDICO5[SI],AL
	INC	DI
	INC 	SI
	JMP	P5

H5:	MOV	MEDICO5[SI],'¦'
	INC	SI
	MOV	MEDICO5[SI],'#'
	MOV	BX,SI
	MOV	PMED5,BL
	MOV	DL,MEDICO5[19]
	INC	DL
	INC	DAT05
	MOV	MEDICO5[19],DL
	INC	SI			;
	MOV	MEDICO5[SI],'"'	;
	JMP	TG

INMED5:MOV	BL,PMED6
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO6[SI],'¦'
IM6:	INC	SI
	CMP	DI,8
	JE	Q6
	MOV	AL,VECIN[DI]
	MOV	MEDICO6[SI],AL
	INC	DI
	JMP	IM6

Q6:	MOV 	DI,17
P6:	CMP	VECIN[DI],'$'
	JE	H6
	MOV	AL,VECIN[DI]
	MOV	MEDICO6[SI],AL
	INC	DI
	INC 	SI
	JMP	P6

H6:	MOV	MEDICO6[SI],'¦'
	INC	SI
	MOV	MEDICO6[SI],'#'
	MOV	BX,SI
	MOV	PMED6,BL
	MOV	DL,MEDICO6[19]
	INC	DL
	INC	DAT06
	MOV	MEDICO6[19],DL
	INC	SI			;
	MOV	MEDICO6[SI],'"'	;
	JMP	TG

INMED6:MOV	BL,PMED7
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO7[SI],'¦'
IM7:	INC	SI
	CMP	DI,8
	JE	Q7
	MOV	AL,VECIN[DI]
	MOV	MEDICO7[SI],AL
	INC	DI
	JMP	IM7

Q7:	MOV 	DI,17
P7:	CMP	VECIN[DI],'$'
	JE	H7
	MOV	AL,VECIN[DI]
	MOV	MEDICO7[SI],AL
	INC	DI
	INC 	SI
	JMP	P7

H7:	MOV	MEDICO7[SI],'¦'
	INC	SI
	MOV	MEDICO7[SI],'#'
	MOV	BX,SI
	MOV	PMED7,BL
	MOV	DL,MEDICO7[19]
	INC	DL
	INC	DAT07
	MOV	MEDICO7[19],DL
	INC	SI			;
	MOV	MEDICO7[SI],'"'	;
	JMP	TG

INMED7:MOV	BL,PMED8
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO8[SI],'¦'
IM8:	INC	SI
	CMP	DI,8
	JE	Q8
	MOV	AL,VECIN[DI]
	MOV	MEDICO8[SI],AL
	INC	DI
	JMP	IM8

Q8:	MOV 	DI,17
P8:	CMP	VECIN[DI],'$'
	JE	H8
	MOV	AL,VECIN[DI]
	MOV	MEDICO8[SI],AL
	INC	DI
	INC 	SI
	JMP	P8

H8:	MOV	MEDICO8[SI],'¦'
	INC	SI
	MOV	MEDICO8[SI],'#'
	MOV	BX,SI
	MOV	PMED8,BL
	MOV	DL,MEDICO8[19]
	INC	DL
	INC	DAT08
	MOV	MEDICO8[19],DL
	INC	SI			;
	MOV	MEDICO8[SI],'"'	;
	JMP	TG

INMED8:MOV	BL,PMED9
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO9[SI],'¦'
IM9:	INC	SI
	CMP	DI,8
	JE	Q9
	MOV	AL,VECIN[DI]
	MOV	MEDICO9[SI],AL
	INC	DI
	JMP	IM9

Q9:	MOV 	DI,17
P9:	CMP	VECIN[DI],'$'
	JE	H9
	MOV	AL,VECIN[DI]
	MOV	MEDICO9[SI],AL
	INC	DI
	INC 	SI
	JMP	P9

H9:	MOV	MEDICO9[SI],'¦'
	INC	SI
	MOV	MEDICO9[SI],'#'
	MOV	BX,SI
	MOV	PMED9,BL
	MOV	DL,MEDICO9[19]
	INC	DL
	INC	DAT09
	MOV	MEDICO9[19],DL
	INC	SI			;
	MOV	MEDICO9[SI],'"'	;
	JMP	TG

INMED9:MOV	BL,PMED10
	MOV	BH,0
	MOV	SI,BX
	MOV	DI,0
	MOV	MEDICO10[SI],'¦'
IM10:	INC	SI
	CMP	DI,8
	JE	Q10
	MOV	AL,VECIN[DI]
	MOV	MEDICO10[SI],AL
	INC	DI
	JMP	IM10

Q10:	MOV 	DI,17
P10:	CMP	VECIN[DI],'$'
	JE	H10
	MOV	AL,VECIN[DI]
	MOV	MEDICO10[SI],AL
	INC	DI
	INC 	SI
	JMP	P10

H10:	MOV	MEDICO10[SI],'¦'
	INC	SI
	MOV	MEDICO10[SI],'#'
	MOV	BX,SI
	MOV	PMED10,BL
	MOV	DL,MEDICO10[19]
	INC	DL
	INC	DAT10
	MOV	MEDICO10[19],DL
	INC	SI			;
	MOV	MEDICO10[SI],'"'	;
	JMP	TG

TG: 	CALL	VACIARVECIN
	JMP	MAIN1
VACIARVECIN:	MOV	DI,0
			MOV	CX,60
VACIARVECIN1:	MOV	VECIN[DI],00H
			INC	DI
			LOOP	VACIARVECIN1
			MOV	ASCVALL[2],00H
			MOV	ASCVALL[3],00H
			MOV	ASCVALL[4],00H
			RET
;***************************************************	
;***************************************************
ENVVIS:	TX1	VISITADOR1
	TX1	VISITADOR2
	TX1	VISITADOR3
	TX1	VISITADOR4
	TX1	VISITADOR5
	JMP	MAIN1

ENVMED:	TX1	MEDICO1
	TX1	MEDICO2
	TX1	MEDICO3
	TX1	MEDICO4
	TX1	MEDICO5
	TX1	MEDICO6
	TX1	MEDICO7	
	TX1	MEDICO8
	TX1	MEDICO9
	TX1	MEDICO10
	JMP	MAIN1

ENVPRO:	TX1	PRODUCTO1
	TX1	PRODUCTO2
	TX1	PRODUCTO3
	TX1	PRODUCTO4
	TX1	PRODUCTO5
	TX1	PRODUCTO6
	TX1	PRODUCTO7	
	TX1	PRODUCTO8
	TX1	PRODUCTO9
	TX1	PRODUCTO10
	TX1	PRODUCTO11
	TX1	PRODUCTO12
	TX1	PRODUCTO13
	TX1	PRODUCTO14
	TX1	PRODUCTO15
	TX1	PRODUCTO16
	TX1	PRODUCTO17
	TX1	PRODUCTO18
	TX1	PRODUCTO19
	TX1	PRODUCTO20
	JMP	MAIN1
;***************************************************
LVIS:	
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR	
	MENS	TITULO
	MENS	SALTO
	MENS	T_TIT2
	MENS	SALTO 
	MENS	T_SUP
	MENS	T_ENC1
	MENS	T_DIV1
	ML	VISITADOR1
	MENS	T_DIV1
	ML	VISITADOR2
	MENS	T_DIV1
	ML	VISITADOR3
	MENS	T_DIV1
	ML	VISITADOR4
	MENS	T_DIV1
	ML	VISITADOR5
	MENS	T_INF
	FIL_COL	12,33
	CALL	SET_CURSOR
	JMP	IFIN
;***************************************************
IFIN: 
	MENS	MENS3
	MOV	TEMP,'B'
IFIN2:
	CALL	TECLA
	CMP	AL,'Q'
	JE	FIN
	CMP	AL,'S'
	JE	MAIN1
	JMP	IFIN2
;***************************************************
LMED:	
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS	T_TIT3	
	MENS	T_SUP
	MENS	T_ENC1
	MENS	T_DIV1 
	ML	MEDICO1
	MENS	T_DIV1
	ML	MEDICO2
	MENS	T_DIV1
	ML	MEDICO3
	MENS	T_DIV1
	ML	MEDICO4
	MENS	T_DIV1
	ML	MEDICO5
	MENS	T_DIV1
	ML	MEDICO6
	MENS	T_DIV1
	ML	MEDICO7
	MENS	T_DIV1
	ML	MEDICO8
	MENS	T_DIV1
	ML	MEDICO9
	MENS	T_DIV1
	ML	MEDICO10
	MENS	T_INF
	FIL_COL	12,33
	CALL	SET_CURSOR
	JMP	IFIN

;***************************************************
LPRO:	
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	MENS	T_TIT4
	MENS	T_SUP2
	MENS	T_ENC2
	MENS	T_DIV2
	RAYA	4
	ML	PRODUCTO1
	RAYA	5
	ML	PRODUCTO2
	RAYA	6
	ML	PRODUCTO3
	RAYA	7
	ML	PRODUCTO4
	RAYA	8
	ML	PRODUCTO5
	RAYA	9
	ML	PRODUCTO6
	RAYA	10
	ML	PRODUCTO7
	RAYA	11
	ML	PRODUCTO8
	RAYA	12
	ML	PRODUCTO9
	RAYA	13
	ML	PRODUCTO10
	RAYA	14
	ML	PRODUCTO11
	RAYA	15
	ML	PRODUCTO12
	RAYA	16
	ML	PRODUCTO13
	RAYA	17
	ML	PRODUCTO14
	RAYA	18
	ML	PRODUCTO15
	RAYA	19
	ML	PRODUCTO16
	RAYA	20
	ML	PRODUCTO17
	RAYA	21
	ML	PRODUCTO18
	RAYA	22
	ML	PRODUCTO19
	RAYA	23
	ML	PRODUCTO20
	MENS	T_INI5
	FIL_COL	12,35
	CALL	SET_CURSOR
	JMP	IFIN

;***************************************************
;************************************************************************
COLOR:  MOV     AH,06H
        MOV     AL,00H              ;toda la pantalla
        MOV     BH,00010111B        ;Atributo de color bit7: Intermitencia
        MOV     CX,0000H            ;Posicion Inicial
        MOV     DX,184FH            ;Posicion Final
        INT     10H
        RET
;*************************************************************************
;*********************************************        	
FIN:		MOV	AX,4C00H
     		INT	21H
;*********************************************
TECLA:	MOV	AH,06H
	MOV	DL,0FFH
	INT	21H
	RET
TEC:	MOV	AH,07H
	INT	21H
	RET
VERPANT: 	MOV	AH,02H
		MOV	DL,AL
		INT	21H
		RET
;***********CAPTURAR TECLA********		
CAPTEC:	MOV    	AH,01H
	INT	21H
	RET
;*****************************************
;**********PARTE DEL CODIGO DEL BURBUJA******************
ORDENAR:
	FIL_COL	1,1
	CALL	SET_CURSOR
	CALL	COLOR
	LLENAR_VECTOR		01,0	;DAT01 EN POSICION 0
	LLENAR_VECTOR		02,2	;DAT02 EN POSICION 2
	LLENAR_VECTOR		03,4	;DAT03 EN POSICION 4
	LLENAR_VECTOR		04,6	;DAT04 EN POSICION 6
	LLENAR_VECTOR		05,8	;DAT05 EN POSICION 8
	LLENAR_VECTOR		06,10	;DAT06 EN POSICION 10
	LLENAR_VECTOR		07,12	;DAT07 EN POSICION 12
	LLENAR_VECTOR		08,14	;DAT08 EN POSICION 14
	LLENAR_VECTOR		09,16	;DAT09 EN POSICION 16
	LLENAR_VECTOR		10,18	;DAT010 EN POSICION 18
	CALL	BURBUJA_16BITS
	MENS	MENDES ;MENSNCN
	MENS	SALTO
	MENS	T_SUP3 
	MENS	T_ENC3
	MENS	T_DIV3 
	MENS	SALTO
	MOV	SI,0
CULB:	MOV	BX,POSI[SI]
	CMP	SI,20
	JE	VACVEC
	CMP	BX,'0'
	JE	ESM1
	CMP	BX,'1'
	JE	ESM2
	CMP	BX,'2'
	JE	ESM3
	CMP	BX,'3'
	JE	ESM4
	CMP	BX,'4'
	JE	ESM5
	CMP	BX,'5'
	JE	ESM6
	CMP	BX,'6'
	JE	ESM7
	CMP	BX,'7'
	JE	ESM8
	CMP	BX,'8'
	JE	ESM9
	CMP	BX,'9'
	JE	ESM10

ESM1:	TS	MEDICO1
	JMP	IFINA
ESM2:	TS	MEDICO2
	JMP	IFINA	
ESM3:	TS	MEDICO3	
	JMP	IFINA
ESM4:	TS	MEDICO4
	JMP	IFINA
ESM5:	TS	MEDICO5
	JMP	IFINA
ESM6:	TS	MEDICO6
	JMP	IFINA
ESM7:	TS	MEDICO7
	JMP	IFINA
ESM8:	TS	MEDICO8
	JMP	IFINA
ESM9:	TS	MEDICO9
	JMP	IFINA
ESM10:TS	MEDICO10	

IFINA:MENS	SALTO
	INC	SI
	INC	SI
	JMP	CULB
	
VACVEC:	MOV	DI,0
SVACVEC:	CMP	DI,11
		JE	VACPOSI
		MOV	VECTOR[DI],0000
		INC	DI
		JMP	SVACVEC

VACPOSI:	MOV	POSI[0],'0'
		MOV	POSI[2],'1'
		MOV	POSI[4],'2'
		MOV	POSI[6],'3'
		MOV	POSI[8],'4'
		MOV	POSI[10],'5'
		MOV	POSI[12],'6'
		MOV	POSI[14],'7'
		MOV	POSI[16],'8'
		MOV	POSI[18],'9'
		MENS	SALTO

JMP	IFIN
;************BURBUJA DE VISITADORES**********
ORDENAVIS:	FIL_COL	1,1
		CALL	SET_CURSOR
		CALL	COLOR
		LLENAR_VECTORVIS		01,0	;VIS01 EN POSICION 0
		LLENAR_VECTORVIS		02,2	;VIS02 EN POSICION 2
		LLENAR_VECTORVIS		03,4	;VIS03 EN POSICION 4
		LLENAR_VECTORVIS		04,6	;VIS04 EN POSICION 6
		LLENAR_VECTORVIS		05,8	;VIS05 EN POSICION 8
	MENS	MENASC
	MENS	SALTO
	CALL	BURBUJA_16BITS_VIS
	MENS	T_SUP3 
	MENS	T_ENC3
	MENS	T_DIV3 
	MENS	SALTO
	MOV	SI,0
ORDVIS:MOV	BX,POSIVIS[SI]
	CMP	SI,10
	JE	VACVECC
	CMP	BX,'0'
	JE	ESV1
	CMP	BX,'1'
	JE	ESV2
	CMP	BX,'2'
	JE	ESV3
	CMP	BX,'3'
	JE	ESV4
	CMP	BX,'4'
	JE	ESV5
	
ESV1:	TS	VISITADOR1
	JMP	IFINAV
ESV2:	TS	VISITADOR2
	JMP	IFINAV	
ESV3:	TS	VISITADOR3	
	JMP	IFINAV
ESV4:	TS	VISITADOR4
	JMP	IFINAV
ESV5:	TS	VISITADOR5
	JMP	IFINAV

IFINAV:MENS	SALTO
	INC	SI
	INC	SI
	JMP	ORDVIS

VACVECC:	MOV	DI,0
SVACVECC:	CMP	DI,11
		JE	VACPOSII
		MOV	VECTOR[DI],0000
		INC	DI
		JMP	SVACVECC

VACPOSII:	MOV	POSIVIS[0],'0'
		MOV	POSIVIS[2],'1'
		MOV	POSIVIS[4],'2'
		MOV	POSIVIS[6],'3'
		MOV	POSIVIS[8],'4'
		MENS	SALTO
		
JMP	IFIN

;********FIN BURBUJA VISITADORES**************
; FIN PARTE DEL CODIGO DEL BURBUJA***********************
.STACK
END
