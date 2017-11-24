        
 drawHealthBar macro row,column,health
        local back,back2,back3,back4,lbl1,lbl2 
        mov cx,column         ;Column
        mov dx,row        ;Row       
        mov al,07h         ;Pixel color
        mov bl,101d
        mov ah,0ch       ;Draw Pixel Command
back:   int 10h
        inc cx 
        dec bl
        jnz back  
        
        mov cx,column         ;Column
        mov dx,row        ;Row       
        add dx,5           ;lower line
        mov bl,101d
        mov ah,0ch       ;Draw Pixel Command
back2:   int 10h
        inc cx 
        dec bl
        jnz back2 
         
        mov cx,column         ;Column
        mov dx,row        ;Row 
        mov bl,5
        mov ah,0ch       ;Draw Pixel Command
back3:  int 10h
        inc dx 
        dec bl
        jnz back3
        
        mov cx,column         ;Column
        mov dx,row        ;Row
        add cx,100       
        mov bl,6
        mov ah,0ch       ;Draw Pixel Command
back4:  int 10h
        inc dx 
        dec bl
        jnz back4
        
                
        mov al,07h
        mov ah,0ch
        mov bx,health
        mov dx,1
        inc dx
        mov al,0ch
lbl1:
        mov cx,1
        add dx,row
        inc cx
        lbl2:
            add cx,column 
            int 10h
            inc cx
            sub cx,column
            cmp cx,bx
            jnz lbl2
        inc dx
        sub dx,row
        cmp dx,4
        jnz lbl1        
 ENDM drawHealthBar
 