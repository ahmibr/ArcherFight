printFirstPlayerName MACRO row,column,name
     pusha
        
        ;Move Cursor to desired point
        
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;Draw Name
        mov ah,9h
        mov dx,offset name
        int 21h
        
       popa
ENDM printFirstPlaterName 

printSecondPlayerName MACRO row,column,name
     pusha
        
        ;Move Cursor to desired point
        
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;Draw Name
        mov ah,9h
        mov dx,offset name
        int 21h
        
       popa
ENDM printSecondPlaterName
