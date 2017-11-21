       drawHeart macro row,column
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h

        mov  al, 03h  ;heart symbol
        mov  bl, 0ch  ;Color is red
        mov  bh, 0    ;Display page
        mov  ah, 0eh  ;Teletype
        int  10h
  
       ENDM drawHeart 
        