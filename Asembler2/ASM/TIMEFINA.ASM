        .MODEL  SMALL
        .386
        .STACK
        .CODE

        ORG     0000
        JMP     MAIN

INICIO: MOV     AX,@DATA
        MOV     DS,AX
        RET

BINASCII:       
	LEA     SI,ASCVAL
        MOV     CX,5
        MOV     AL,00H
C10:    MOV     [SI],AL
        INC     SI
        LOOP    C10
        MOV     CX,10
        LEA     SI,ASCVAL+4
        MOV     AX,BINVAL
C20:    CMP     AX,CX
        JB      C30
        XOR     DX,DX
        DIV     CX
        OR      DL,30H
        MOV     [SI],DL
        DEC     SI
        JMP     C20
C30:    OR      AL,30H
        MOV     [SI],AL
        RET

CURSORXY:
	MOV	AH,02H
	MOV	BH,0
        MOV     DH,10    ;FILA
        MOV     DL,20    ;COLUMNA
	INT	10H
	RET


CAPFECHA:
        MOV     AH,2AH
        INT     21H
	MOV	DI,0
        MOV     AX,0
        MOV     AL,DL           ;DIA
        AAM
        OR      AX,3030H
        MOV     FECHA[DI],AH
	INC	DI
        MOV     FECHA[DI],AL
        INC	DI
        MOV     FECHA[DI],'\'
	INC	DI
        
        MOV     AX,0
        MOV     AL,DH           ;MES
        AAM
        OR      AX,3030H
        MOV     FECHA[DI],AH
        INC	DI
        MOV     FECHA[DI],AL
        INC	DI
        MOV     FECHA[DI],'\'
	INC	DI
   
        MOV     BINVAL,CX       ;A¥O
        CALL    BINASCII
        MOV     SI,1
        MOV     CX,4
CICLOCOPY:
        MOV     BL,ASCVAL[SI]
        MOV     FECHA[DI],BL
        INC     SI
	INC	DI
        LOOP    CICLOCOPY
	MOV	AL,'-'
	MOV	FECHA[DI],AL
        RET

		
	
MAIN:	CALL	INICIO
MAIN1:  CALL    CURSORXY
	CALL	CAPFECHA
	CALL	VIS_MENS	
	MOV	DX,OFFSET DIA
	
VIS_MENS:
	MOV	AH,09H
	INT	21H
	RET


	MOV	AH,06H
	MOV	DL,0FFH
	INT	21H
        CMP     AL,1BH
	JNE	MAIN1
	
	MOV	AH,4CH
	INT	21H

	.DATA
ASCVAL  DB      5 DUP(00H),'$'
BINVAL  DB      0000
FECHA   DB      10 DUP(00H),'$'
DIA	DB	10,13,'DIA :    $'
MES	DB	10,13,'MES :   $'	
ANO	DB	10,13,'ANO :     $'
	

	END




