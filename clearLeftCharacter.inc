 clearLeftCharacter macro row,column,color
    pusha
    mov ax,row
    mov bx,column
    drawRectangle row,column,37,21,color
    popa
 endm  clearLeftCharacter 
 