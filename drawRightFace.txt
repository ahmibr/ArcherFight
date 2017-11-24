drawRightCharacter macro row,column
        local loop1,loop2,loop3
        pusha
        ;===Character===
        
        ;INITILIZATION
        mov ax,row
        mov bx,column
        
        ;tophair
        
        drawRectangle ax,bx,3,18,08h
        
        ;backhair
        
        add ax,3
        add bx,15
        drawRectangle ax,bx,4,3,08h 
        
        sub bx,16
        ;topface
            
        add bx,2
        drawRectangle ax,bx,6,14,0eh
        
        ;buttomface
        
        add ax,6
        add bx,2
        drawRectangle ax,bx,3,12,0eh  
        
        ;mouth
        
        add bx,1
        drawRectangle ax,bx,1,5,00h    
        
        ;left eye
        
        sub ax,6
        sub bx,4
        drawRectangle ax,bx,3,2,00h  
        
        ;right eye
        
        add ax,2
        add bx,7
        drawRectangle ax,bx,2,3,00h  
        
        
        ;clothes
        
        add ax,7
        sub bx,6
        drawRectangle ax,bx,17,15,02h
        
        ;left hand
        
        add bx,4
        add ax,5
        drawRectangle ax,bx,3,11,0eh
        
        ;left leg
        
        
        add ax,12
        sub bx,2
        drawRectangle ax,bx,8,4,0eh
        
        ;rightleg
       
        add bx,6
        drawRectangle ax,bx,8,4,0eh
        
        
        ;====Bow====
        
        ;top
        
        sub ax,12
        sub bx,6 
        mov cx,3
        
        loop1:
        drawRectangle ax,bx,2,2,06h   
        sub ax,2
        sub bx,2
        dec cx
        jnz loop1
        
        ;Buttom
        add ax,8
        add bx,4
        mov cx,2
        loop2:
        drawRectangle ax,bx,2,2,06h  
        add ax,2
        sub bx,2
        dec cx
        jnz loop2
        
        
        ;Front
        sub ax,4
        mov cx,3
        loop3:
        drawRectangle ax,bx,2,2,06h  
        sub ax,2
        dec cx
        jnz loop3
        
       popa
       ENDM drawRightCharacter 