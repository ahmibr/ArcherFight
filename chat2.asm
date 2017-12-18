moveCursor macro row,column 
MOV AH, 02 ; Set Cursor option
MOV BH, 00 ; Page 0
MOV DL, column ; Col Pos
MOV DH, row; Row Pos
INT 10H
endm moveCursor     

        .MODEL SMALL
        .STACK 64
        .DATA 
;====================Data====================

val db ?
line db 80 dup('-'),'$'
name1 db "Abdelrahman",'$'
name2 db "Ahmed",'$'
footerMessage1 db "To end chatting with ",'$'
footerMessage2 db " Press F3",'$'
cursor1row db 14
cursor1column db 00
cursor2row db 01
cursor2column db 00
;============================================

        .code
MAIN    PROC FAR
        MOV AX,@DATA
        MOV DS,AX 

        call portInitialize
        call screenInitialization

        read:
        moveCursor cursor1row,cursor1column
        mov AH, 01 ; ZF =0 if key pressed, else ZF=1 AL: ASCII Code, AH: Scancode
        int 16H
        jz readSerial

        mov AH, 01 ; AL = ASCII of Char
        int 21H
        mov val,al
        call getCursorPos
        mov cursor1row,DH
        mov cursor1column,dl
        cmp dh,23
        jne sendSerial
        dec DH
        dec cursor1row
        mov ch,14
        call scroll
        sendSerial:
        ; mov AH, 00 ; AL: ASCII Code, AH: Scancode
        ; int 16H
        ; mov val,al
        ; moveCursor cursor1row,cursor1column
        ; mov ah,07
        ; mov dl,val
        ; int 21h

;If empty put the VALUE in Transmit data register
  	mov dx , 3F8H		; Transmit data register
  	mov  al,val
  	out dx , al 

        readSerial:
        mov dx , 3FDH		; Line Status Register
	in al , dx 
  	AND al , 1
  	JZ read

 ;If Ready read the VALUE in Receive data register
  	mov dx , 03F8H
  	in al , dx
        moveCursor cursor2row,cursor2column 
        mov ah,02
        cmp al,13
        jne print
        mov dl,10
        int 21h
        mov dl,13
        int 21h
        call getCursorPos
        mov cursor2row,DH
        mov cursor2column,dl
        cmp dh,12
        jne read
        mov ch,01
        dec DH
        dec cursor2row
        call scroll
        jmp read
        print:
  	mov dl , al
        int 21h
        call getCursorPos
        mov cursor2row,DH
        mov cursor2column,dl
        cmp dh,12
        jz foo
        jmp read
        foo:
        dec dh
        dec cursor2row
        mov ch,01
        call scroll
        jmp read

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

        mov ah,02
        mov dl,':'
        int 21H

        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 0 ; Col Pos
        MOV DH, 12 ; Row Pos
        INT 10H

        mov ah,09
        mov dx,offset line
        int 21H

        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 0 ; Col Pos
        MOV DH, 23 ; Row Pos
        INT 10H

        mov ah,09
        mov dx,offset line
        int 21H

        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 0 ; Col Pos
        MOV DH, 24 ; Row Pos
        INT 10H

        mov ah,09
        mov dx,offset footerMessage1
        int 21H


        mov ah,09
        mov dx,offset name2
        int 21H

        mov ah,09
        mov dx,offset footerMessage2
        int 21H


        MOV AH, 02 ; Set Cursor option
        MOV BH, 00 ; Page 0
        MOV DL, 0 ; Col Pos
        MOV DH, 13 ; Row Pos
        INT 10H

        mov ah,09
        mov dx,offset name1
        int 21H

        mov ah,02
        mov dl,':'
        int 21H
        

        ret
screenInitialization                ENDP

getCursorPos PROC
MOV AH, 03 ; DH: Row, DL: Col , CX : Shape of Cursor
MOV BH, 00 ; Page 0 (Currently Viewed Page)
INT 10H
ret
getCursorPos ENDP

scroll PROC
MOV AH, 06 ; 06-Scroll up \\ 07-Scroll down
MOV AL, 01 ; Entire Page
MOV BH, 07 ; Normal Attribute or Color Attributes
MOV Cl, 00 ; Starting Col
MOV DL, 79 ; End Col
INT 10H
ret
scroll ENDP

        END MAIN         