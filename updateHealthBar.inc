updateHealthBar MACRO row,column,health
    pusha   
    
    ;=====INITIALIZATION=====
    mov ax,row
    mov bx,column                
    
    ;leave 2p for making it at center
    add ax,2
    add bx,2
    
    ;clear old health, draw black rectangle on it
    drawRectangle ax,bx,2,100,00h
    
    ;draw the new one
    drawRectangle ax,bx,2,health,0ch
    
    popa  
ENDM updateHealthBar