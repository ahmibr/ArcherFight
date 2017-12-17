;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

cal_prabola MACRO arr_x,arr_y,theta,speed,dirc,Yo,Xo
        pusha
        LOCAL Voxcos2_980
        LOCAL Voxcos2_980_mid
        LOCAL end_Voxcos2_980
        LOCAL fill_arr_x
        LOCAL start_cal_y
        LOCAL ax_min_bxx
        LOCAL div_sy_s
        LOCAL store_y_val
        LOCAL div_check2
        LOCAL div_check1
        LOCAL bxx_beat_ax2
        LOCAL bxx_beat_ax1
        LOCAL bxx_beat_ax
        LOCAL end_cal_y
        LOCAL fix_y89985
        LOCAL correct_y
        LOCAL correct_x
        LOCAL flip_x
        LOCAL fix_y
        LOCAL left_correct_x
        LOCAL right_correct_x
        LOCAL rectify_y
        LOCAL arr_x_arr_y_done
        ;start getting cos&tan
        mov si,offset cos_t
        mov di,offset tan_t 
        
        mov size,1Eh
        sub theta,1 
        
        add si,theta
        add di,theta
        add di,theta
        
        mov al,[si] 
        mov bx,[di]   
        ;mov bl,[di] 
         
        mov temp5,al
        mov temp4,bx 
        ;end getting cos&tan 
        
        ;start calculating a
        mov al,speed
        mul speed
        mov bx,ax 
          
        mov al,temp5
        mul temp5
        mul bx

        mov si,offset temp1
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr temp1
        mul temp4   
        
        mov si,offset temp2
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr temp1+2
        mul temp4  
        
        add ax,word ptr temp2+2
        mov dx,ax 
        mov ax,word ptr temp2
        
        mov si,offset a
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        ;end calculating a

        ;start calculating scall
        mov al,speed
        mul speed
        mov bx,ax 
          
        mov al,temp5
        mul temp5
        mul bx

        mov bx,64h

        mov si,offset temp1
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr temp1
        mul bx   
        
        mov si,offset temp2
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr temp1+2
        mul bx  
        
        add ax,word ptr temp2+2
        mov dx,ax 
        mov ax,word ptr temp2
        
        mov si,offset scall
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh    
        ;end calculating scall
        
        ;start getting sin(2*theta)
        mov si,offset sin_t
        add si,theta
        add si,theta
        add si,1
        mov dl,[si] 
        mov dh,0
        mov temp2,dx 
        ;end getting sin(2*theta)   
        
        ;start calculating D (total distance)
        mov al,speed
        mul speed
        mul temp2 
        
        mov bx,ax
        mov cx,dx
        mov dx,0               
                
Voxcos2_980:  mov ax,d
        add ax,Xo
        cmp ax,140h
        ja  end_Voxcos2_980
        mov ax,3D4h
        mul d
        cmp cx,dx
        je  Voxcos2_980_mid
        cmp cx,dx
        jb  end_Voxcos2_980
        inc d
        jmp Voxcos2_980        

Voxcos2_980_mid:  
        cmp bx,ax
        jb  end_Voxcos2_980
        inc d
        jmp Voxcos2_980
end_Voxcos2_980:
        sub d,1
        ;end calculating D (total distance)
        
        ;start calculating x step
        mov bx,1Eh
        mov ax,d
        div bl
        mov ah,0
        mov temp2,ax
        ;end calculating x step
        
        ;start calculating x values
        mov cx,1Eh
        mov ax,0
        mov si,offset arr_x
        
fill_arr_x:
        mov [si],ax 
        add ax,temp2
        add si,2
loop    fill_arr_x        
        
        ;start setting last x point to D
        mov si,offset arr_x+60
        mov ax,d
        mov [si],al
        inc si
        mov [si],ah 
        ;end setting last x point to D
        ;end calculating x values  

        ;start calculating y values                                   
        
        mov di,offset arr_x
        mov cl,size
        mov ch,0
        push cx 
        add size,1    
        
start_cal_y: 
        sub size,1
        ;start get new value of x        
        mov ax,[di]
        add di,2
        mov x,ax
        ;end get new value of x  
        
        ;start calculating a * x
        mov ax,word ptr a
        mul x
        mov si,offset temp1
        mov [si],al 
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr a+2 
        mul x
        mov bx,word ptr temp1+2
        add ax,bx
        adc dx,0
        mov si,offset temp1
        add si,2
        mov [si],al
        inc si
        mov [si],ah
        mov si,offset temp2
        mov [si],dl
        inc si
        mov [si],dh
        ;end calculaitng a * x
        
        ;start calculating b * x^2
        ;start part1
        mov ax,x
        mul x
        mov bx,ax 
        mov cx,dx
        
        mov ax,word ptr b 
        mul bx
        mov si,offset temp3
        mov [si],al 
        inc si    
        mov [si],ah
        inc si     
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr b+2
        mul bx
        mov bx,word ptr temp3+2
        add ax,bx
        adc dx,0
        mov si,offset temp3+2
        mov [si],al 
        inc si    
        mov [si],ah 
        mov si,offset temp4
        mov [si],dl 
        inc si    
        mov [si],dh
        ;end part 1
        
        ;start part2
        mov ax,word ptr b 
        mul cx
        mov bx,dx
        mov dx,word ptr temp3+2
        add ax,dx
        adc bx,0
        mov si,offset temp3+2
        mov [si],al 
        inc si    
        mov [si],ah   
        
        mov ax,word ptr b+2
        mul cx
        mov dx,temp4
        add ax,bx
        add ax,dx     
        mov si,offset temp4
        mov [si],al 
        inc si    
        mov [si],ah
        ;end part2
        ;end calculaitng b * x^2
        
        mov ax,temp2
        cmp ax,temp4
        jb  bxx_beat_ax
        cmp ax,temp4
        je  bxx_beat_ax1

        ;start calculating a*x - b*x^2
ax_min_bxx:        
        mov ax,word ptr temp3
        mov bx,word ptr temp3+2
        mov cx,word ptr temp4
        not ax
        not bx
        not cx
        add ax,1
        adc bx,0
        adc cx,0
        add ax,word ptr temp1
        adc bx,word ptr temp1+2
        adc cx,temp2 
        
        mov si,offset temp1
        mov [si],al
        inc si
        mov [si],ah
        inc si
        mov [si],bl
        inc si
        mov [si],bh
        
        mov si,offset temp2
        mov [si],cl
        inc si
        mov [si],ch
        ;end calculating a*x - b*x^2 
        mov y,0
div_sy_s:
        mov ax,word ptr scall
        mov bx,word ptr scall+2
        mul y
        mov si,offset temp3
        mov [si],al
        inc si
        mov [si],ah
        inc si
        mov [si],dl
        inc si
        mov [si],dh
        mov ax,bx
        mul y
        mov bx,word ptr temp3+2
        add ax,bx
        adc dx,0
        mov si,offset temp3+2
        mov [si],al
        inc si
        mov [si],ah
        mov si,offset temp4
        mov [si],dl
        inc si
        mov [si],dh
        
        mov ax,word ptr temp3
        mov bx,word ptr temp3+2
        mov cx,temp4
        
        cmp temp2,cx
        je  div_check1
        cmp temp2,cx
        jb  store_y_val
        inc y
        jmp div_sy_s
                                             
store_y_val:
        sub y,1 
        mov ax,0C8h
        sub ax,y
        mov y,ax
        mov si,offset arr_y
        pop cx
        push cx
        mov al,cl
        mov bl,size
        sub al,bl
        mov ah,0
        mov bh,0
        mov bx,2
        mul bx
        add si,ax
        mov ax,y
        mov [si],al
        inc si
        mov [si],ah
        jmp end_cal_y        
        
div_check2: 
        cmp word ptr temp1,ax
        jb  store_y_val
        inc y
        jmp div_sy_s        
        
div_check1: 
        cmp word ptr temp1+2,bx
        je  div_check2
        cmp word ptr temp1+2,bx
        jb  store_y_val
        inc y
        jmp div_sy_s

bxx_beat_ax2:
        mov ax,word ptr temp1
        mov bx,word ptr temp3
        cmp ax,bx
        jb  bxx_beat_ax
        jmp ax_min_bxx         
         
bxx_beat_ax1:
        mov ax,word ptr temp1+2
        mov bx,word ptr temp3+2
        cmp ax,bx
        jb  bxx_beat_ax
        cmp ax,bx
        je  bxx_beat_ax2
        jmp ax_min_bxx
                
bxx_beat_ax:
        mov y,1
        jmp store_y_val  

end_cal_y: 
        cmp size,0
        ja  start_cal_y
        ;end calculating y values     
        
        mov si,offset arr_x
        mov cx,1Fh
        cmp dirc,1
        je  flip_x        
        
;the next block is to make sure no value of way is out of the frame after adding the offset Yo        
fix_y:        
        mov si,offset arr_y  
        mov cx,1Fh
correct_y:
        mov ax,[si]
        cmp ax,Yo
        jb  rectify_y
        sub ax,Yo
        mov [si],al
        inc si
        mov [si],ah
        inc si
loop    correct_y 
  
 
;next block is to add offset Xo to x values
mov si,offset arr_x  
        mov cx,1Fh  
        
correct_x:
        cmp dirc,0
        je  left_correct_x
        jmp right_correct_x         
         
flip_x: 
        mov bx,[si]
        mov ax,140h
        sub ax,bx
        mov [si],al
        inc si
        mov [si],ah
        inc si
loop    flip_x
        jmp fix_y           
                            
          
left_correct_x:
        mov ax,[si]
        add ax,Xo
        mov [si],al
        inc si
        mov [si],ah
        inc si     
        dec cx
        cmp cx,0
        je  arr_x_arr_y_done
        jmp left_correct_x

right_correct_x:
        mov ax,[si]
        sub ax,Xo
        mov [si],al
        inc si
        mov [si],ah
        inc si    
        dec cx
        cmp cx,0
        je  arr_x_arr_y_done
        jmp right_correct_x   
        
;the next block may make error not sure and i'm seriously done with this da*n macro                               
rectify_y:
        mov ax,0
        mov [si],al
        inc si
        mov [si],ah
        inc si 
        dec cx
        jmp correct_y 
        
arr_x_arr_y_done:
        mov size,1Fh
        mov x,0
        mov y,0
        mov d,1Eh
        inc theta
        mov word ptr a,0
        mov word ptr a+2,0
        mov word ptr scall,0
        mov word ptr scall+2,0
        mov word ptr b,0C4A0h
        mov word ptr b+2,4Ah  
        mov word ptr temp1,0
        mov word ptr temp1+2,0
        mov word ptr temp3,0
        mov word ptr temp3+2,0
        mov temp2,0
        mov temp4,0
        popa
ENDM cal_prabola 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;