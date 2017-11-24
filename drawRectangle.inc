drawRectangle MACRO row,column,height,width,color
        local newline,newcolumn
        pusha  
        mov dx,row        ;Row
        mov si,column     ;Backup column to reuse later
        mov al,color         ;Pixel color
        mov bx,height    ;counter of height
        mov ah,0ch       ;Draw Pixel Command
        
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
         
        popa
ENDM drawRectangle