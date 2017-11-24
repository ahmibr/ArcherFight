drawRectangle MACRO row,column,height,width,color
        local newline,newcolumn,returnfrommacro
        pusha                                   
        
        ;=====INITIALIZATION=====
        mov dx,row        ;Row
        mov si,column     ;Backup column to reuse later
        mov al,color         ;Pixel color
        mov bx,height    ;counter of height
        mov di,width     ;counter of width
        mov ah,0ch       ;Draw Pixel Command 
       
        
        ;======Validate height and width======
        cmp bx,0        ;height
        jz returnfrommacro
        cmp di,0        ;width
        jz returnfrommacro
        
        
        ;=====Let the draw begin==========
newline:   
         mov di,width    ;counter of width
         mov cx,si       ;Column
     newcolumn:
     
             int 10h
             inc cx
             dec di
             jnz newcolumn
         
         inc dx
         dec bx
         jnz newline
            
            
            
        returnfrommacro: 
        popa
ENDM drawRectangle