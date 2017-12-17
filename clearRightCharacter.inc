 clearRightCharacter macro row,column,color
    pusha                               
    mov ax,row
    mov bx,column
    sub bx,3
    drawRectangle ax,bx,37,21,color
    popa
 endm  clearRightCharacter