;read_input:        
;        mov ah,1
;        int 16h
;        jnz get_input
;        jmp read_input
;        
;get_input:
;        mov ah,0
;        int 16h
;        jmp excute
;        
;call_function: ;player_1 controls typen only once becuase their ascii is not affected by capslook
;        cmp ah,48h
;        je  inct1
;        cmp ah,50h
;        je  dect1
;        cmp ah,4Dh
;        je  rmp1
;        cmp ah,4Bh
;        je  lmp1
;        cmp al,2Bh
;        je  incs1
;        cmp al,2Dh
;        je  decs1
;        cmp al,0Dh
;        je  shp1
;        ;end of player_1 controls
;        ;player_2 controls typen 2 times becuase their ascii is affected by capslook
;        cmp al,57h
;        je  inct2 
;        cmp al,77h
;        je  inct2 
;        cmp al,53h
;        je  dect2  
;        cmp al,73h
;        je  dect2 
;        cmp al,44h
;        je  rmp2
;        cmp al,64h
;        je  rmp2 
;        cmp al,41h
;        je  lmp2   
;        cmp al,61h
;        je  lmp2
;        cmp al,48h
;        je  incs2
;        cmp al,68h
;        je  incs2
;        cmp al,47h
;        je  decs2
;        cmp al,67h
;        je  decs2
;        cmp al,20h
;        je  shp2
;        ;end of player_2 controls
;           
;excute:    
;
;;start player1 control functions        
;inct1:  cmp theta1,4Bh
;        je  excute
;        inc theta1
;        jmp excute 
;        
;dect1:  cmp theta1,0Eh
;        je  excute
;        dec theta1    
;        jmp excute
;        
;rmp1:   cmp Xo1,0
;        je  excute
;        dec Xo1
;        jmp excute  
;        
;lmp1:   mov ax,140h
;        sub ax,block
;        cmp Xo1,ax
;        je  ecute
;        inc Xo1
;        jmp excute
;        
;incs1:  cmp speed1,41h
;        je  excute
;        inc speed1
;        jmp excute
;        
;decs1:  cmp speed1,19h
;        je  excute
;        dec speed1
;        jmp excute  
;        
;shp1:   mov dirc,1
;        p1_cal_prabola arr_x1,arr_y1,theta1,speed1,dirc,Yo1,Xo1
;        jmp excute
;;end player1 control functions                                         
;                
;;start player2 control functions                
;inct2:  cmp theta2,4Bh
;        je  excute
;        inc theta2
;        jmp excute
;       
;dect2:  cmp theta2,0Eh
;        je  excute
;        dec theta2
;        jmp excute
;                
;rmp2:   mov ax,block
;        cmp Xo2,ax
;        je  excute
;        inc Xo2
;        jmp excute
;
;lmp2:   cmp Xo2,0
;        je  excute
;        dec Xo2
;        jmp excute
;
;incs2:  cmp speed2,41h
;        je  excute
;        inc speed2
;        jmp excute
;
;decs2:  cmp speed2,19h
;        je  excute
;        dec speed2
;        jmp excute
;             
;shp2:   mov dirc,0
;        p2_cal_prabola arr_x2,arr_y2,theta2,speed2,dirc,Yo2,Xo2
;        jmp excute   
;;end player2 control functions            
;             
;draw_heart:
;        mov ah,9
;        mov bh,0
;        mov al,3
;        mov cx,1
;        mov bl,04h
;        int 10h  