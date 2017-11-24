drawHeart macro row,column
        pusha
        
        ;Move Cursor to desired point
        
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;Draw Heart Sumbol
        mov  al, 03h  ;heart symbol
        mov  bl, 0ch  ;Color is red
        mov  bh, 0    ;Display page
        mov  ah, 0eh  ;Teletype
        int  10h
        
       popa
ENDM drawHeart