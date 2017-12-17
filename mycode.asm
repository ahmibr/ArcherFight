include graphics.inc     ;graphics and animation
include math.inc         ;fill the array of points
include welcomescreen.inc  ;welcome screen module
     
        .MODEL SMALL
        .STACK 64
        .DATA 


;===========Welcome screen varialbles==========
        
welcome_message1    db 'Please enter your name:$'
welcome_message2    db 'Press Enter key to continue$'
prog_op1	db '*To start chatting press F1$'
prog_op2	db '*To start Archer game press Enter$'
prog_op3	db '*To start the program press ESC$'   
firstPlayerName db 16 dup('$')        ;will be taken from welcome page          
secondPlayerName db 'Abdelrahman','$' ;Fixed for now, untill phase 2

;==============================================


;==============Graphics constants============== 

;Left health bar           
healthbarcolumn1 EQU 21
healthbarrow1    EQU 17
heart1row EQU  2
heart1column EQU 1

;Right health bar
healthbarcolumn2 EQU 205
healthbarrow2    EQU 17
heart2row EQU  2
heart2column EQU 24
health1 dw 100
health2 dw 100 
  
topBarRow EQU 27
lowBarRow EQU 150
powerBarRow EQU 159

;Boundaries
minRow EQU 30  
maxRow EQU 147

maxRightCharacter EQU 302  ;320-18(width of char) 
minRightCharacter EQU 167   

maxLeftCharacter EQU 135
minLeftCharacter EQU 0        

;Wall
wallendRow  dw 150
wheight dw 30
up db 1  ;level 2

;=============================================


;=============Coordinates=====================

;---Characters---

;left
leftCharacterRow dw 113
leftCharacterColumn dw 0
prevleftCharacterRow dw 113        ;used for clearing
prevleftCharacterColumn dw 0      ;used for clearing

;right
rightCharacterRow dw 113
rightCharacterColumn dw 302
prevrightCharacterRow dw 113       ;used for clearing
prevrightCharacterColumn dw 302    ;used for clearing


;---Arrows----

;left
firstPlayerarrowRow dw 130   ;used for rebase arrow
firstPlayerarrowColumn dw 22 ;used for rebase arrow
currentArrow1Row dw 130
currentArrow1Column dw 22
prevArrow1Row dw 130         ;used for clearing
prevArrow1Column dw 22       ;used for clearing

;right
secondPlayerarrowRow dw 130  ;used for rebase arrow
secondPlayerarrowColumn dw 297     ;used for rebase arrow
currentArrow2Row dw 130
currentArrow2Column dw 297 
prevArrow2Row dw 130         ;used for clearing
prevArrow2Column dw 297      ;used for clearing

;============================================

mes db 'ezayk?','$'
mes2 db 'A7la status bar deh wla eh','$'
player1won db "Player1 Won",'$'
player2won db "Player2 Won",'$'
drawCase db "Draw",'$'
leftinfo db "P:xx A:xx",'$'
rightinfo db "P:xx A:xx",'$'    


;=============Calculation variables==========
arrow1inair db 0
arrow2inair db 0  

sin_t   db 02h,03h,05h,07h,09h,0Ah,0Ch,0Eh,010h,011h,013h,015h,016h,018h,01Ah,01Ch,01Ch,01Fh,021h,022h,024h,025h,027h,029h,02Ah,02Ch,02Dh,02Fh,030h,032h,034h,035h,036h,038h,038h,03Bh,03Ch,03Eh,03Fh,040h,042h,043h,044h,045h,047h,048h,049h,04Ah,04Bh,04Dh,04Eh,04Fh,050h,051h,052h,053h,054h,055h,056h,057h,057h,058h,059h,05Ah,05Bh,05Bh,05Ch,05Dh,05Dh,05Eh,05Fh,05Fh,060h,060h,061h,061h,061h,062h,062h,062h,063h,063h,063h,063h,064h,064h,064h,064h,064h,064h,064h,064h,064h,064h,064h,063h,063h,063h,063h,062h,062h,062h,061h,061h,061h,060h,060h,05Fh,05Fh,05Eh,05Dh,05Dh,05Ch,05Bh,05Bh,05Ah,059h,058h,057h,057h,056h,055h,054h,053h,052h,051h,050h,04Fh,04Eh,04Dh,04Bh,04Ah,049h,048h,047h,045h,044h,043h,042h,040h,03Fh,03Eh,03Ch,03Bh,038h,038h,036h,035h,034h,032h,030h,02Fh,02Dh,02Ch,02Ah,029h,027h,025h,024h,022h,021h,01Fh,01Ch,01Ch,01Ah,018h,016h,015h,013h,011h,010h,0Eh,0Ch,0Ah,09h,07h,05h,03h,02h
cos_t   db 064h,064h,064h,064h,064h,063h,063h,063h,063h,062h,062h,062h,061h,061h,061h,060h,060h,05Fh,05Fh,05Eh,05Dh,05Dh,05Ch,05Bh,05Bh,05Ah,059h,058h,057h,057h,056h,055h,054h,053h,052h,051h,050h,04Fh,04Eh,04Dh,04Bh,04Ah,049h,048h,047h,045h,044h,043h,042h,040h,03Fh,03Eh,03Ch,03Bh,038h,038h,036h,035h,034h,032h,030h,02Fh,02Dh,02Ch,02Ah,029h,027h,025h,024h,022h,021h,01Fh,01Ch,01Ch,01Ah,018h,016h,015h,013h,011h,010h,0Eh,0Ch,0Ah,09h,07h,05h,03h,02h
tan_t   dw 02h,03h,05h,07h,09h,0Bh,0Ch,0Eh,010h,012h,013h,015h,017h,019h,01Bh,01Ch,01Fh,020h,022h,024h,026h,028h,02Ah,02Dh,02Fh,031h,033h,035h,037h,039h,03Ch,03Eh,041h,043h,046h,049h,04Bh,04Eh,051h,054h,057h,05Ah,05Dh,061h,064h,068h,06Bh,06Fh,072h,077h,07Bh,080h,085h,08Ah,08Fh,094h,09Ah,0A0h,0A6h,0ADh,0B4h,0BCh,0C4h,0CCh,0D6h,0E1h,0ECh,0F8h,0105h,0113h,0122h,0134h,0147h,015Dh,0175h,0191h,01B1h,01D6h,0202h,0237h,0277h,02C8h,032Eh,03B7h,0477h,0596h,0773h,0B30h,01661h
arr_x1  dw 31 dup(?)
arr_y1  dw 31 dup(?)    
arr_size1 dw 0

arr_x2  dw 31 dup(?)
arr_y2  dw 31 dup(?)
arr_size2 dw 0   

help_flag  db 5
help_delay dw 0FFh ;every thee arrow shoot 
help_col   db 0   
help_step  db 0

a       dd ?
b       dd 4AC4A0h
scall   dd ?
d       dw 1Eh
size db 1Eh
theta1  dw 30
speed1  db 50 
theta2  dw 30
speed2  db 50
temp1   dd ?
temp2   dd ?
temp3   dd ?
temp4   dw ? 
temp5   db ?
x       dw ?
y       dw ?
dirc    db 0h
Xo1     dw 34h
Yo1     dw 49h 
Xo2     dw 32h
Yo2     dw 49h
;============================================

        .code
MAIN    PROC FAR
        MOV AX,@DATA
        MOV DS,AX 

        welcomeScreen firstPlayerName ;welcome screen to take player 1 name

        call initiateGame ;restart variables and call graphics macros
        
        ;=====================================================
        start:
        
        ;Check if game is over
        cmp health1,00
        je done
        cmp health2,00
        je done
        
        read_input:
        mov si,offset arr_x1
        mov di,offset arr_x2 
        xor ax,ax   ;mov ax,0     
        
        mov ah,1
        int 16h
        jnz get_input
        jmp drawing_loop  
        
get_input:
        mov ah,0
        int 16h
        
;call_function: ;player_2 controls typen only once becuase their ascii is not affected by capslook
        cmp ah,48h ;Keypad Up
        je  inct2
        cmp ah,50h ;Keypad Down
        je  dect2
        cmp ah,4Dh ;Keypad Right
        je  rmp2
        cmp ah,4Bh ;Keypad Left
        je  lmp2
        cmp al,2Bh ; + key
        je  incs2
        cmp al,2Dh ; - key
        je  decs2
        cmp al,0Dh ; enter key
        je  shp2
        ;===end of player_1 controls===
        
        ;player_2 controls typen 2 times becuase their ascii is affected by capslook
        cmp al,57h ; W key
        je  inct1 
        cmp al,77h ; w key
        je  inct1 
        cmp al,53h ; S key
        je  dect1  
        cmp al,73h ; s key
        je  dect1 
        cmp al,44h ; D key
        je  rmp1
        cmp al,64h ; d key
        je  rmp1 
        cmp al,41h ; A key
        je  lmp1   
        cmp al,61h ; a key
        je  lmp1
        cmp al,48h ; H key
        je  incs1
        cmp al,68h ; h key
        je  incs1
        cmp al,47h ; G key
        je  decs1
        cmp al,67h ; g key
        je  decs1
        cmp al,20h ; space key
        je  shp1
        ;end of player_1 controls
              
        jmp read_input
        
;start player1 control functions        
inct1:  cmp theta1,75
        je  read_input
        add theta1,5     
        call print_left_info
        jmp drawing_loop 
        
dect1:  cmp theta1,15
        je  read_input
        sub theta1,5
        call print_left_info    
        
        jmp drawing_loop
        
rmp1:   
        ;check if moving will go out of boundaries
        mov ax,leftCharacterColumn 
        add ax,5
        cmp ax,maxLeftCharacter
        ja  read_input
        add leftCharacterColumn,5
        
        mov ax,firstPlayerarrowColumn
        cmp ax,currentArrow1Column
        jne changeArrow1pos1
        add currentArrow1Column,5 
        
        changeArrow1pos1:
        add firstPlayerarrowColumn,5
        jmp drawing_loop  
        
lmp1:   
        ;check if moving will go out of boundaries
        mov ax,leftCharacterColumn
        sub ax,5
        js  read_input
        sub leftCharacterColumn,5
        
        mov ax,firstPlayerarrowColumn
        cmp ax,currentArrow1Column
        jne changeArrow1pos2
        sub currentArrow1Column,5 
        
        changeArrow1pos2:
        sub firstPlayerarrowColumn,5
        jmp drawing_loop
        
incs1:  cmp speed1,41h
        je  read_input
        add speed1,5
        call print_left_info
        
        jmp drawing_loop
        
decs1:  cmp speed1,19h
        je  read_input
        sub speed1,5
        call print_left_info
        
        jmp drawing_loop  
        
shp1:   ;mov dirc,1 ;possibly meaning less
        mov ax,firstPlayerarrowColumn
        cmp ax,currentArrow1Column
        jne read_input
        
        mov dirc,0   ;left player
        mov ax,200
        sub ax,firstPlayerarrowRow
        mov Yo1,ax
        mov ax,firstPlayerarrowColumn
        mov Xo1,ax
        cal_prabola arr_x1,arr_y1,theta1,speed1,dirc,Yo1,Xo1 ;calculate for left player
        mov arr_size1,31
        mov arrow1inair,1
        jmp drawing_loop
;end player1 control functions                                         
                
;start player2 control functions                
inct2:  cmp theta2,75
        je  read_input
        add theta2,5
        call print_right_info
        
        jmp drawing_loop
       
dect2:  cmp theta2,15
        je  read_input
        sub theta2,5
        call print_right_info
        
        jmp drawing_loop
                
rmp2:   mov ax,rightCharacterColumn
        add ax,5
        cmp ax,maxRightCharacter
        ja  read_input
        add rightCharacterColumn,5
        
        mov ax,secondPlayerarrowColumn
        cmp ax,currentArrow2Column
        jne changeArrow2pos1
        add currentArrow2Column,5
        
        changeArrow2pos1: 
        add secondPlayerarrowColumn,5
        jmp drawing_loop  
        
lmp2:   
        mov ax,rightCharacterColumn
        sub ax,5
        cmp ax,minrightCharacter
        jl  read_input
        sub rightCharacterColumn,5
       
        mov ax,secondPlayerarrowColumn
        cmp ax,currentArrow2Column
        jne changeArrow2pos2
        sub currentArrow2Column,5
        
        changeArrow2pos2: 
        sub secondPlayerarrowColumn,5
        
        jmp drawing_loop

incs2:  cmp speed2,41h
        je  read_input
        add speed2,5
        call print_right_info
        
        jmp drawing_loop

decs2:  cmp speed2,19h
        je  read_input
        sub speed2,5
        call print_right_info
        
        jmp drawing_loop
             
shp2:   
        mov ax,secondPlayerarrowColumn
        cmp ax,currentArrow2Column
        jne read_input
        
        mov ax,320
        sub ax,secondPlayerarrowColumn
        mov Xo2,ax
        
        mov ax,200
        sub ax,secondPlayerarrowRow
        mov Yo2,ax
        
        mov dirc,1   ;right player
        cal_prabola arr_x2,arr_y2,theta2,speed2,dirc,Yo2,Xo2 ;calculate for right player
        mov arr_size2,31
        mov arrow2inair,1
;end player2 control functions            

drawing_loop: 
        cmp  arr_size1,0
        jne  arrow2out
        call resetArrow1
        
        arrow2out:
        cmp arr_size2,0
        jne  get_draw_points
        call resetArrow2 
        
        cmp  help_delay,0
        je   summon_help
        dec  help_delay 
                           
get_draw_points:  
        ;left player
        cmp arrow1inair,1
        jne getdraw2         
        
        mov si,offset arr_x1

        mov al,31
        sub ax,arr_size1
        mov ah,2
        mul ah
        mov ah,0
        add si,ax
        mov cx,[si]
        mov dx,[si+62]
        mov currentArrow1Column,cx
        mov currentArrow1Row,dx    
        dec arr_size1
        
        
        getdraw2:
        
        ;right player
        cmp arrow2inair,1
        jne check_left_arrow
        
        mov di,offset arr_x2
        
        mov al,31
        sub ax,arr_size2
        mov ah,2
        mul ah
        mov ah,0
        add di,ax

        mov cx,[di]
        mov dx,[di+62]                 
        mov currentArrow2Column,cx
        mov currentArrow2Row,dx
        dec arr_size2
        
check_left_arrow:        
        mov cx,currentArrow1Column
        mov dx,currentArrow1Row 
        call check_hit_larrow
               
check_right_arrow:        
        mov cx,currentArrow2Column
        mov dx,currentArrow2Row
        call check_hit_rarrow
        
draw:   
        drawWall wallendrow,wheight,07h 
        ;================ClearCharacters===
        
        mov ax,leftCharacterColumn
        cmp ax,prevleftCharacterColumn
        je checkRightChar
        clearLeftCharacter prevleftCharacterRow,prevleftCharacterColumn       
        checkRightChar:
        mov ax,rightCharacterColumn
        cmp ax,prevrightCharacterColumn
        je clearstuff
        clearRightCharacter prevrightCharacterRow,prevrightCharacterColumn       
        
        ;======clear=======================
        clearstuff:
        mov ax,prevArrow1Row
        cmp ax,minRow
        jb drawFirst1
        mov ax,prevArrow1Row
        cmp ax,maxRow
        ja drawFirst1
        drawLeftPlayerArrow prevArrow1Row,prevArrow1Column,00h
        ;==========Clear is done=========== 
        
        ;=====Draw Left======== 
        drawFirst1:
        mov ax,currentArrow1Row
        cmp ax,minRow
        jb drawSecond

        drawFirst:
        drawLeftPlayerArrow currentArrow1Row,currentArrow1Column,0Fh        
        
        
        ;=======clear======
        mov ax,prevArrow2Row
        cmp ax,minRow
        jb drawArrow2
        
        cmp ax,maxRow
        ja drawArrow2
        drawRightPlayerArrow prevArrow2Row,prevArrow2Column ,00h
        
        ;======Draw Right=========
        drawArrow2:
        mov ax,currentArrow2Row 
        cmp ax,minRow
        jb reset
        
        cmp ax,maxRow
        jbe drawSecond
        call resetArrow2
        
        drawSecond:
        drawRightPlayerArrow currentArrow2Row,currentArrow2Column ,0Fh
        
        reset:
        mov ax,currentArrow1Row
        mov prevArrow1Row,ax
        
        mov ax,currentArrow1Column
        mov prevArrow1Column,ax

        mov ax,currentArrow2Row
        mov prevArrow2Row,ax
        
        mov ax,currentArrow2Column
        mov prevArrow2Column,ax

        drawCharacters:
        
        drawLeftCharacter leftCharacterRow,leftCharacterColumn       
        drawRightCharacter rightCharacterRow,rightCharacterColumn
        
        mov ax,rightCharacterRow
        mov prevrightCharacterRow,ax
        
        mov ax,rightCharacterColumn
        mov prevrightCharacterColumn,ax
        
        mov ax,leftCharacterRow
        mov prevleftCharacterRow,ax
        
        mov ax,leftCharacterColumn
        mov prevleftCharacterColumn,ax
        
        
        call delay 
        jmp start  
        
summon_help: ;heeeeeeeeeeeeeeeeeelp
        cmp help_step,0
        ja  skip_help 
        mov help_step,15 
        cmp help_col,38
        je  set_help_delay 
configure_help_flag:        
        cmp help_flag,5
        je  set_help_flag 
draw_help:        
        help 9,help_col,help_flag,01,03 
        cmp help_col,0
        je  switch_help_direction
        jmp get_draw_points
        
set_help_flag:
        mov help_flag,0
        jmp draw_help   

set_help_delay:
        mov help_delay,0FFh
        jmp configure_help_flag
        
set_help_flag_right:
        mov help_flag,2                  
        jmp draw_help 
        
skip_help:
        dec help_step 
        jmp get_draw_points 
           
redirect_help_right:
        mov help_flag,2
        jmp get_draw_points           
           
switch_help_direction:
        cmp help_flag,0
        je  redirect_help_right
        mov help_flag,0                       
        jmp get_draw_points   
        
done:   
        mov  dl, 15   ;Column
        mov  dh, 15   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        mov ax,health1
        cmp ax,health2
        je printdrawcase
        
        cmp health1,00
        je player2
        
        ;print player1won
        mov ah,9h
        mov dx,offset player1won
        int 21h
        jmp inf
        
        player2:
        ;printplayer2won
        mov ah,9h
        mov dx,offset player2won
        int 21h
        jmp inf
        
        printdrawcase:
        mov ah,9h
        mov dx,offset drawCase
        int 21h
        
        inf:
        jmp inf

MAIN    ENDP

initiateGame proc
    
        mov ah,0h          ;Change video mode (Graphical MODE)
        mov al,13h        ;Max memory size 16KByte
        int 10h     
        
        drawLeftPlayerArrow firstPlayerarrowRow,firstPlayerarrowColumn,0Fh
        drawLeftCharacter leftCharacterRow,leftCharacterColumn
        
        drawRightPlayerArrow secondPlayerarrowRow,secondPlayerarrowColumn,0Fh
        drawRightCharacter rightCharacterRow,rightCharacterColumn
       
        printFirstPlayerName 1,1,firstPlayerName
        printSecondPlayerName 1,24,secondPlayerName
        
        drawHealthBar healthbarrow1,healthbarcolumn1 
        drawHealthBar healthbarrow2,healthbarcolumn2
        drawHeart heart1row,heart1column
        drawHeart heart2row,heart2column
        
        ;left
        mov leftCharacterRow,113
        mov leftCharacterColumn,0
        mov prevleftCharacterRow,113  
        mov prevleftCharacterColumn,0
        
        ;right
        mov rightCharacterRow,113
        mov rightCharacterColumn,302
        mov prevrightCharacterRow,113    
        mov prevrightCharacterColumn,302 
        
        
        ;---Arrows----
        
        ;left
        mov firstPlayerarrowRow,130  
        mov firstPlayerarrowColumn,22
        mov currentArrow1Row,130
        mov currentArrow1Column,22
        mov prevArrow1Row,130        
        mov prevArrow1Column,22       
        
        ;right
        mov secondPlayerarrowRow,130 
        mov secondPlayerarrowColumn,297    
        mov currentArrow2Row,130
        mov currentArrow2Column,297 
        mov prevArrow2Row,130      
        mov prevArrow2Column,297  
        
        mov health1,100
        mov health2,100                                  
        
        mov theta1,30
        mov speed1,50 
        mov theta2,30
        mov speed2,50
        
        drawWall wallendrow,wheight,07h
        drawBar topBarRow
        drawBar lowBarRow
                
        call print_left_info
        call print_right_info
        drawBar powerBarRow 
        
        call testChatArea
        
            ret
initiateGame    endp



testChatArea                PROC 
        
        mov  dl, 1   ;Column
        mov  dh, 20   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print message
        mov ah,9h
        mov dx,offset mes
        int 21h
        
        mov  dl, 1   ;Column
        mov  dh, 21   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print message
        mov ah,9h
        mov dx,offset mes
        int 21h
        
        mov  dl, 1   ;Column
        mov  dh, 22   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print message
        mov ah,9h
        mov dx,offset mes
        int 21h
        
         ;lower Bar
        drawBar 186
        
        mov  dl, 1   ;Column
        mov  dh, 24   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print message
        mov ah,9h
        mov dx,offset mes2
        int 21h
    
       
                    RET
testChatArea                ENDP


resetArrow1                PROC  
            mov arrow1inair,0
            mov ax,firstPlayerarrowRow
            mov currentArrow1Row,ax
            mov ax,firstPlayerarrowColumn
            mov currentArrow1Column,ax
                    RET
resetArrow1                ENDP                    

resetArrow2                PROC 
                           
        
            mov arrow2inair,0
            mov ax,secondPlayerarrowRow
            mov currentArrow2Row,ax
            mov ax,secondPlayerarrowColumn
            mov currentArrow2Column,ax
  
                    RET
resetArrow2                ENDP                    


delay                PROC 
                        
           mov cx,0ffffh
           lbl:
           loop lbl
          
                    RET
delay                ENDP                    

check_hit_larrow                PROC  
    
               ;cx has arrow column
               ;dx has arrow row
               
               mov si,12 ;counter to check help intersection
               
               checkHelpL:
               mov ah,0Dh
               mov bh,0
               int 10h
               cmp al,1
               je  increase_left_health 
               dec cx
               dec si
               jnz checkHelpL
               
               add cx,12 ;fix what loop missed with
               
               cmp dx,rightCharacterRow
               jb checkbotbar1 ;it's above the char
               cmp cx,rightCharacterColumn
               jb checkbotbar1 ;it's on left of rchar
               mov ax,cx
               sub ax,12    ;length of arrow
               mov bx,rightCharacterColumn
               add bx,18
               
               cmp ax,bx
               ja checkbotbar1
               sub health2,10
               updateHealthBar healthbarrow2,healthbarcolumn2,health2
               call resetArrow1
               jmp returnFromCheckLarrow
                
                checkbotbar1:       
                cmp dx,maxRow
                jbe checkwall1
                call resetArrow1
                jmp returnFromCheckLarrow
                
                checkwall1:
                mov ax,wallendrow
                sub ax,wheight
                cmp dx,ax
                jb returnFromCheckLarrow  ;if arrow above wall
                
                mov bx,159
                cmp cx,bx
                jb returnFromCheckLarrow
                
                mov ax,cx
                sub ax,12
                mov bx,160
                cmp ax,bx
                ja returnFromCheckLarrow
                call resetArrow1            
                
                jmp returnFromCheckLarrow 
                        
                correct_left_help_flag_right:
                    mov help_flag,2
                    mov help_delay,0FFh
                    mov help_step,0     
                    call resetArrow1      
                    jmp returnFromCheckLarrow
                
                correct_left_help_flag_left:
                    mov help_flag,0 
                    mov help_delay,0FFh
                    mov help_step,0    
                    call resetArrow1
                    jmp returnFromCheckLarrow
                        
                correct_left_help_flag:
                    cmp help_flag,1
                    je  correct_left_help_flag_right
                    jmp correct_left_help_flag_left
                
                correct_left_increase_health: 
                     mov health1,100
                     updateHealthBar healthbarrow1,healthbarcolumn1,health1    
                     inc help_flag
                     help 9,help_col,help_flag,01,03
                     jmp correct_left_help_flag
                     
                increase_left_health:
                     add health1,20
                     cmp health1,100
                     ja  correct_left_increase_health
                     updateHealthBar healthbarrow1,healthbarcolumn1,health1 
                     inc help_flag
                     help 9,help_col,help_flag,01,03
                     jmp correct_left_help_flag 
                     
               returnFromCheckLarrow:
           
                    RET
check_hit_larrow    ENDP                    

check_hit_rarrow                PROC 
    
               ;cx has arrow column
               ;dx has arrow row   
               mov si,12
               
               checkHelpR:
               mov ah,0Dh
               mov bh,0
               int 10h
               cmp al,1
               je  increase_right_health
               inc cx
               dec si
               jnz checkHelpR
               
               sub cx,12 ;fix what loop missed with
               
               cmp dx,leftCharacterRow
               jb checkbotbar2
               mov bx,leftCharacterColumn
               add bx,18
               cmp cx,bx
               ja checkbotbar2
               
               mov ax,cx
               add ax,12
               
               cmp ax,leftCharacterColumn
               jb  checkbotbar2
               sub health1,10
               updateHealthBar healthbarrow1,healthbarcolumn1,health1
               call resetArrow2
               jmp  returnFromCheckRarrow
               
               checkbotbar2:       
                cmp dx,maxRow
                jbe checkwall2
                call resetArrow2
                jmp  returnFromCheckRarrow
                
                checkwall2:
                mov ax,wallendrow
                sub ax,wheight
                cmp dx,ax
                jb returnFromCheckRarrow
                
                mov bx,160
                cmp cx,bx
                ja returnFromCheckRarrow
                
                mov ax,cx
                add ax,12
                mov bx,159
                cmp ax,bx
                jb returnFromCheckRarrow
                call resetArrow2          
                
                jmp returnFromCheckRarrow 
                        
                correct_right_help_flag_right:
                    mov help_flag,2
                    mov help_delay,0FFh 
                    mov help_step,0
                    call resetArrow2      
                    jmp returnFromCheckRarrow
                
                correct_right_help_flag_left:
                    mov help_flag,0 
                    mov help_delay,0FFh
                    mov help_step,0    
                    call resetArrow2
                    jmp returnFromCheckRarrow
                        
                correct_right_help_flag:
                    cmp help_flag,1
                    je  correct_right_help_flag_right
                    jmp correct_right_help_flag_left
                
                correct_right_increase_health: 
                     mov health2,100
                     updateHealthBar healthbarrow2,healthbarcolumn2,health2    
                     inc help_flag
                     help 9,help_col,help_flag,01,03
                     jmp correct_right_help_flag
                     
                increase_right_health:
                     add health2,20
                     cmp health2,100
                     ja  correct_right_increase_health
                     updateHealthBar healthbarrow2,healthbarcolumn2,health2 
                     inc help_flag
                     help 9,help_col,help_flag,01,03
                     jmp correct_right_help_flag 
                
               returnFromCheckRarrow:
           
                    RET
check_hit_rarrow    ENDP                    


print_left_info                PROC 
        xor ax,ax
        mov al,speed1
        mov bl,10
        div bl
        add al,'0'
        add ah,'0'
        mov [leftinfo]+2,al
        mov [leftinfo]+3,ah
        
        mov ax,theta1
        div bl
        add al,'0'
        add ah,'0'
        mov [leftinfo]+7,al
        mov [leftinfo]+8,ah
        
        mov  dl, 1   ;Column
        mov  dh, 19   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        mov ah,9h
        mov dx,offset leftinfo
        int 21h
        
        drawBar 159
           
                    RET
print_left_info                ENDP            

print_right_info                PROC 
        
        xor ax,ax
        mov al,speed2
        mov bl,10
        div bl
        add al,'0'
        add ah,'0'
        mov [rightinfo]+2,al
        mov [rightinfo]+3,ah
        
        
        mov ax,theta2
        div bl
        add al,'0'
        add ah,'0'
        mov [rightinfo]+7,al
        mov [rightinfo]+8,ah
        
        
        mov  dl, 30   ;Column
        mov  dh, 19   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        mov ah,9h
        mov dx,offset rightinfo
        int 21h
        
        drawBar 159   
                    RET
print_right_info                ENDP

        END MAIN         
