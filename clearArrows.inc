clearLeftPlayerArrow macro row,column,color
    pusha
    
    ;=========Initialization======
    mov ax,row
    mov bx,column
    
    ;========Left Offset==========
    sub ax,2
    sub bx,11   
    
    drawRectangle ax,bx,5,12,color
    
    popa
    endm clearLeftPlayerArrow
    
    clearRightPlayerArrow macro row,column,color
    pusha
    
    ;=========Initialization======
    mov ax,row
    mov bx,column
    
    ;========Up offset===========
    sub ax,2
    drawRectangle ax,bx,5,12,color
    
    popa
    endm clearLeftPlayerArrow