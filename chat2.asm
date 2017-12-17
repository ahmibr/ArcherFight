     
        .MODEL SMALL
        .STACK 64
        .DATA 
;====================Data====================

line db 80 dup('-'),'$'
name1 db 09,"Abdelrahman:",10,13,'$'
name2 db 09,"Ahmed:",10,13,'$'
;============================================

        .code
MAIN    PROC FAR
        MOV AX,@DATA
        MOV DS,AX 

        call portInitialize
        call screenInitialization
;Check that Data Ready
 j:
		mov dx , 3FDH		; Line Status Register
	CHK:	in al , dx 
  		AND al , 1
  		JZ CHK

 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx
        mov ah,02 
        ; cmp al,13
        ; jne print
        ; mov dl,10
        ; int 21h
        ; mov dl,13
        ; int 21h
        ; jmp j
        print:
  		mov dl , al
        int 21h

    jmp j
MAIN    ENDP

portInitialize                PROC 

;Set Divisor Latch Access Bit
mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access Bit
out dx,al			;Out it
;Set LSB byte of the Baud Rate Divisor Latch register.
mov dx,3f8h			
mov al,0ch			
out dx,al
;Set MSB byte of the Baud Rate Divisor Latch register.
mov dx,3f9h
mov al,00h
out dx,al
;Set port configuration
mov dx,3fbh
mov al,00011011b
; 0:Access to Receiver buffer, Transmitter buffer
; 0:Set Break disabled
; 011:Even Parity
; 0:One Stop Bit
; 11:8bits
out dx,al
ret
portInitialize                ENDP

screenInitialization                PROC 
mov AH, 06 ; 06-Scroll up \\ 07-Scroll down
        MOV AL, 00 ; Entire Page
        MOV BH, 07 ; Normal Attribute or Color Attributes
        MOV CH, 00 ; Starting Row
        MOV Cl, 00 ; Starting Col
        MOV DH, 24 ; End Row
        MOV DL, 79 ; End Col
        INT 10H

        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 00 ; Col Pos
        MOV DH, 00 ; Row Pos
        INT 10H
        
        mov ah,09
        mov dx,offset name2
        int 21H

        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 0 ; Col Pos
        MOV DH, 12 ; Row Pos
        INT 10H

        mov ah,09
        mov dx,offset line
        int 21H

        mov ah,09
        mov dx,offset name1
        int 21H
        ret
screenInitialization                ENDP


        END MAIN         
