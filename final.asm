        include cal_pra_mac.inc
        include drawRectangle.inc
        include drawArrows.inc  
        include drawLeftCharacter.inc
        include drawRightCharacter.inc
        include drawHealthBar.inc
        include drawHeart.inc
        include drawStatusBar.inc
        include printPlayersNames.inc
        include clearArrows.inc
        include clearLeftCharacter.inc 
        include clearRightCharacter.inc
        include updateHealthBar.inc  
        .model small
        .stack 64h
        .data
sin_t   db 02h,03h,05h,07h,09h,0Ah,0Ch,0Eh,010h,011h,013h,015h,016h,018h,01Ah,01Ch,01Ch,01Fh,021h,022h,024h,025h,027h,029h,02Ah,02Ch,02Dh,02Fh,030h,032h,034h,035h,036h,038h,038h,03Bh,03Ch,03Eh,03Fh,040h,042h,043h,044h,045h,047h,048h,049h,04Ah,04Bh,04Dh,04Eh,04Fh,050h,051h,052h,053h,054h,055h,056h,057h,057h,058h,059h,05Ah,05Bh,05Bh,05Ch,05Dh,05Dh,05Eh,05Fh,05Fh,060h,060h,061h,061h,061h,062h,062h,062h,063h,063h,063h,063h,064h,064h,064h,064h,064h,064h,064h,064h,064h,064h,064h,063h,063h,063h,063h,062h,062h,062h,061h,061h,061h,060h,060h,05Fh,05Fh,05Eh,05Dh,05Dh,05Ch,05Bh,05Bh,05Ah,059h,058h,057h,057h,056h,055h,054h,053h,052h,051h,050h,04Fh,04Eh,04Dh,04Bh,04Ah,049h,048h,047h,045h,044h,043h,042h,040h,03Fh,03Eh,03Ch,03Bh,038h,038h,036h,035h,034h,032h,030h,02Fh,02Dh,02Ch,02Ah,029h,027h,025h,024h,022h,021h,01Fh,01Ch,01Ch,01Ah,018h,016h,015h,013h,011h,010h,0Eh,0Ch,0Ah,09h,07h,05h,03h,02h
cos_t   db 064h,064h,064h,064h,064h,063h,063h,063h,063h,062h,062h,062h,061h,061h,061h,060h,060h,05Fh,05Fh,05Eh,05Dh,05Dh,05Ch,05Bh,05Bh,05Ah,059h,058h,057h,057h,056h,055h,054h,053h,052h,051h,050h,04Fh,04Eh,04Dh,04Bh,04Ah,049h,048h,047h,045h,044h,043h,042h,040h,03Fh,03Eh,03Ch,03Bh,038h,038h,036h,035h,034h,032h,030h,02Fh,02Dh,02Ch,02Ah,029h,027h,025h,024h,022h,021h,01Fh,01Ch,01Ch,01Ah,018h,016h,015h,013h,011h,010h,0Eh,0Ch,0Ah,09h,07h,05h,03h,02h
tan_t   dw 02h,03h,05h,07h,09h,0Bh,0Ch,0Eh,010h,012h,013h,015h,017h,019h,01Bh,01Ch,01Fh,020h,022h,024h,026h,028h,02Ah,02Dh,02Fh,031h,033h,035h,037h,039h,03Ch,03Eh,041h,043h,046h,049h,04Bh,04Eh,051h,054h,057h,05Ah,05Dh,061h,064h,068h,06Bh,06Fh,072h,077h,07Bh,080h,085h,08Ah,08Fh,094h,09Ah,0A0h,0A6h,0ADh,0B4h,0BCh,0C4h,0CCh,0D6h,0E1h,0ECh,0F8h,0105h,0113h,0122h,0134h,0147h,015Dh,0175h,0191h,01B1h,01D6h,0202h,0237h,0277h,02C8h,032Eh,03B7h,0477h,0596h,0773h,0B30h,01661h
arr_x1  dw 31 dup(?)
arr_y1  dw 31 dup(?)    
arr_x2  dw 31 dup(?)
arr_y2  dw 31 dup(?)
a       dd ?
b       dd 4AC4A0h
scall   dd ?
d       dw 1Eh
theta1  dw 2Dh
speed1  db 41h 
theta2  dw 20h
speed2  db 34h
temp1   dd ?
temp2   dd ?
temp3   dd ?
temp4   dw ? 
temp5   db ?
x       dw ?
y       dw ?
size    db 1Eh
dirc    db 0h
Xo1     dw 34h
Yo1     dw 49h 
Xo2     dw 32h
Yo2     dw 49h
name1   dw 'Ahmed$'
name2   dw 'Abdelrahman$'   
;block   dw 64h
        .code
MAIN    PROC    FAR
        mov ax, @data
        mov ds,ax       
        
        mov al,13h
        mov ah,0
        int 10h  
                
        ;start drawing game graphics        
        drawLeftCharacter 113,20
        drawRightCharacter 113,285 
        
        drawHealthBar 10,30
        drawHealthBar 10,190
        
        drawHeart 1,22
        drawHeart 1,18    
        
        printFirstPlayerName 0,4,name1
        printSecondPlayerName 0,24,name2
        ;end drawing game graphics   
        
        

calculate:        
        ;start calculating projectiles
        mov size,1Eh 
        mov dirc,0
        cal_prabola arr_x1,arr_y1,theta1,speed1,dirc,Yo1,Xo1 
        mov size,1Eh
        mov dirc,1
        cal_prabola arr_x2,arr_y2,theta2,speed2,dirc,Yo2,Xo2
        ;end calculating projectiles                
        
        mov name1,64h
        mov name2,64h
                        
        mov si,offset arr_x1
        mov di,offset arr_x2 
        
        mov ah,0Ch    
                        
        mov si,offset arr_x1
        mov di,offset arr_x2 
        
        mov ah,0Ch
        
drawing_loop:
        cmp size,0
        je  calculate
        jmp delay 
        
get_draw_points:           
        mov cx,[si]
        mov dx,[si+62] 
        mov y,cx
        mov x,dx
        mov cx,[di]
        mov dx,[di+62]  
        mov temp2,cx
        mov temp4,dx
        mov word ptr temp1,si
        mov word ptr temp1+2,di
        
check_left_arrow:        
        mov cx,y
        mov dx,x 
        mov bl,1
        jmp check_hit
        
check_right_arrow:        
        mov cx,temp2
        mov dx,temp4
        mov bl,2
        jmp check_hit
        
draw:   drawLeftPlayerArrow x,y,0Fh        
        drawRightPlayerArrow temp4,temp2,0Fh
        mov si,word ptr temp1
        mov di,word ptr temp1+2
        add si,2
        add di,2
        dec size 
        jmp drawing_loop     
        
        
delay:  mov cx,0FFFFh
delay_loop:
        loop delay_loop
        cmp size,1Fh  
        jb  clear
        jmp  get_draw_points  
        
clear:  clearLeftPlayerArrow x,y,00h
        clearRightPlayerArrow temp4,temp2,00h
        jmp get_draw_points         
           
up_health1: 
        cmp name1,0
        je  done
        sub name1,10
        updateHealthBar 10,190,name1
        jmp calculate
        
up_health2:     
        cmp name2,0
        je  done
        sub name2,10
        updateHealthBar 10,30,name2
        jmp calculate                   
           
up_health:
        cmp bl,1
        je  up_health1
        jmp up_health2         
        
check_hit:
        mov ah,0Dh
        mov bh,0
        int 10h
        cmp al,2
        je  up_health
        cmp al,0Eh
        je  up_health
        cmp al,8
        je  up_health
        cmp bl,1
        je  check_right_arrow
        jmp draw
                 
done:   jmp done                           
               
;        mov ah,0Ch 
;        
;loop1:  cmp size,0
;        je  con
;        mov cx,0FFFFh
;        jmp delay1 
;draw1:   
;        mov cx,0     
;        mov cx,[si]
;        mov dx,[di] 
;        mov bl,1 
;        jmp get_pixel_color
;drw1:   
;        mov temp4,si
;        mov temp2,di
;        cmp size,1Fh
;        jb  clear_arrow1 
;d1:        
;        mov y,cx
;        mov x,dx
;        mov temp5,04h 
;        drawLeftPlayerArrow x,y,temp5
;        mov si,temp4
;        mov di,temp2
;        add si,2
;        add di,2
;        dec size
;        jmp loop1
;
;con:        
;        mov size,1Fh
;                 
;        mov si,offset arr_x2
;        mov di,offset arr_y2
;               
;        mov ah,0Ch
;loop2:  cmp size,0
;        je  done
;        mov cx,0FFFFh
;        jmp delay2 
;draw2:   
;        mov cx,0     
;        mov cx,[si]
;        mov dx,[di] 
;        mov bl,2 
;        jmp get_pixel_color
;drw2:         
;        mov temp4,si
;        mov temp2,di
;        cmp size,1Fh
;        jb  clear_arrow2
;d2:         
;        mov y,cx
;        mov x,dx
;        mov temp5,0Fh 
;        drawRightPlayerArrow x,y,temp5 
;        mov si,temp4
;        mov di,temp2
;        add si,2                       
;        add di,2
;        dec size
;        jmp loop2         
;                 
;done:   jmp done 
;        HLT
;        
;delay2: loop delay2
;        jmp draw2        
;        
;delay1: loop delay1
;        jmp draw1 
;        
;clear_arrow1:
;        clearLeftPlayerArrow [di-2],[si-2],00h
;        jmp d1
;        
;clear_arrow2:
;        clearRightPlayerArrow [di-2],[si-2],00h
;        jmp d2                 
;     
;kill2:  mov ah,2
;        mov dx,05F0h
;        int 10h
;        mov ah,9
;        mov bh,0
;        mov al,41h
;        mov bl,0Fh
;        mov cx,1
;        int 10h
;        jmp done       
;        
;kill1:  mov ah,2
;        mov dx,0550h
;        int 10h
;        mov ah,9
;        mov bh,0
;        mov al,49h
;        mov bl,0Fh
;        mov cx,1
;        int 10h
;        jmp done        
;                 
;kill:   cmp bl,1
;        je  kill1
;        jmp kill2                 
;                 
;get_pixel_color:
;        mov ah,0Dh
;        mov bh,0
;        int 10h
;        cmp al,2
;        je  kill
;        cmp al,0Eh
;        je  kill
;        cmp al,8
;        je  kill
;        cmp bl,1
;        je  drw1
;        jmp drw2        
                          
                             
MAIN    ENDP
END     MAIN