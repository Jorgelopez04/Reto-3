;*************************************************************************************
;PROGRAMA PARA DIVIDIR DOS NUMEROS DE UN SOLO DIGITO
;*************************************************************************************

                .MODEL  SMALL
                .386
                .STACK
                .DATA
        N1      DB      ?
        N2      DB      ?
        RES     DB      ?
        COCI    DB      ?
        RESI    DB      ?
        MN      DB      10,13,'DIVISION DE DOS NUMEROS DE UN SOLO DIGITO$'
        MNA     DB     10,10,13,'TENGA EN CUENTA QUE DIVIDENDO DEBE SER MAYOR QUE DIVISOR$'
        MN1     DB     10,10,13,'INGRESE DIVIDENDO :  $'
        MN2     DB      10,13,'INGRESE DIVISOR:  $'
        MRES    DB     10,10,13,'EL RESULTADO ES, COCIENTE: $'
	MRESI	DB	10,13,'RESIDUO: $'

        .CODE
        ORG     0000
        JMP     MAIN

        SEG_DAT:
                MOV     AX,@DATA
                MOV     DS,AX
                RET

        VIS_MN:
                MOV     DX,OFFSET MN
                MOV     AH,09H
                INT     21H
                RET
        VIS_MNA:
                MOV     DX,OFFSET MNA
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
        VIS_MRES:
                MOV     DX,OFFSET MRES
                MOV     AH,09H
                INT     21H
                RET

	VIS_MRESI:
                MOV     DX,OFFSET MRESI
                MOV     AH,09H
                INT     21H
                RET

        INGRESO:
                MOV     AH,01H
                INT     21H
                RET

        SALIR:
                MOV     AH,4CH
                INT     21H
		

        DIVISION:
                CALL    VIS_MN1
                CALL    INGRESO
                AND     AL,0FH
                MOV     N1,AL
                CALL    VIS_MN2
                CALL    INGRESO
                AND     AL,0FH
                MOV     N2,AL
                MOV     AH,00
		MOV	AL,N1
                DIV     N2		;AX = AX / MEM, COCIENTE:AL Y RESIDUO:AH
                
		OR      AX,3030H
                MOV     RESI,AH
                MOV     COCI,AL
                CALL    VIS_MRES
                MOV     DL,COCI
                MOV     AH,02H
                INT     21H
		
                CALL    VIS_MRESI
		MOV     DL,RESI
                MOV     AH,02H
                INT     21H
		RET
                
                

        MAIN:   CALL    SEG_DAT
                CALL    VIS_MN
                CALL    VIS_MNA
                CALL    DIVISION
		JMP    SALIR
        
		END




