;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawHealthBar macro row,column
        local back,back2,back3,back4,lbl1,lbl2 
        pusha 
       
       ;=====INITIALIZATION=====
       mov ax,row
       mov bx,column
       
       ;Top Bar white color
       drawRectangle ax,bx,1,104,07h
       
       ;Left Bar white color
       drawRectangle ax,bx,6,1,07h
       
       ;Right Bar white color
       add bx,103   ;1p left bar, 1p right space, 100p healthbar, 1p left space
       drawRectangle ax,bx,6,1,07h
       
       ;Buttom Bar white color
       add ax,5     ;1p topbar, 1p free,2p health,1p free
       sub bx,103
       drawRectangle ax,bx,1,104,07h
       
       ;Health Bar red color
       sub ax,3
       add bx,2
       drawRectangle ax,bx,2,100,0ch 
       
        popa
 ENDM drawHealthBar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
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

drawBar MACRO row 
    pusha
      drawRectangle row,0,1,320,07h
     popa
ENDM drawBar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printFirstPlayerName MACRO row,column,name
     pusha
        
        ;Move Cursor to desired point
        
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print Name
        mov ah,9h
        mov dx,offset name
        int 21h
        
       popa
ENDM printFirstPlaterName 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printSecondPlayerName MACRO row,column,name
     pusha
        
        ;Move Cursor to desired point
        
        mov  dl, column   ;Column
        mov  dh, row   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
        
        ;print Name
        mov ah,9h
        mov dx,offset name
        int 21h
        
       popa
ENDM printSecondPlaterName

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawLeftPlayerArrow Macro row,column,color
        local top,ibot,bot,mid
        pusha
        
        ;=====Back up=====
        mov di,row
        mov si,column
        
        ;=====Initialization======
        mov cx,si
        mov dx,di

        mov bl,3 ;size of head
        mov bh,2 ;Counter, draw front and back
        mov ah,0ch   ;draw pixel command
        mov al,color ;set Color
        
        
        
        ;======Draw Top part=======
        top:
        int 10h
        dec cx
        dec dx
        dec bl
        jnz top
        
        ;draw the top part again, but in the back
        mov cx,si  
        mov dx,di
        mov bl,3
        dec bh
        jz ibot
        
        sub cx,9 ;Length of Arrow
        jmp top
        
        
        ;=====Draw Bot=========
        ibot:
        mov bh,2
        bot: 
        
        int 10h
        dec cx
        inc dx
        dec bl
        jnz bot
        
        ;draw the bottom part again, but in the back
        mov cx,si
        mov dx,di
        dec bh
        jz mid
        mov bl,3
        sub cx,9  ;Length of Arrow
        jmp bot
        
        
        ;====Draw Mid Part=============
        mid:
        mov ax,di   ;Restart row
        mov bx,si   ;Restart Column
        sub bx,9    ;Length of Arrow
        drawRectangle ax,bx,1,9,color 
        
        
        
        popa
    ENDM       drawLeftPlayerArrow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawRightPlayerArrow Macro row,column,color
        local top,ibot,bot,mid
        pusha
        
        ;=====Back up=====
        mov di,row
        mov si,column
        
        ;=====Initialization======
        mov cx,si
        mov dx,di

        mov bl,3 ;size of head
        mov bh,2 ;Counter, draw front and back
        mov ah,0ch   ;draw pixel command
        mov al,color ;set Color
        
        
        
        ;======Draw Top part=======
        top:
        int 10h
        inc cx
        dec dx
        dec bl
        jnz top
        
        ;draw the top part again, but in the back
        mov cx,si  
        mov dx,di
        mov bl,3
        dec bh
        jz ibot
        
        add cx,9 ;Length of Arrow
        jmp top
        
        
        ;=====Draw Bot=========
        ibot:
        mov bh,2
        bot: 
        
        int 10h
        inc cx
        inc dx
        dec bl
        jnz bot
        
        ;draw the bottom part again, but in the back
        mov cx,si
        mov dx,di
        dec bh
        jz mid
        mov bl,3
        add cx,9  ;Length of Arrow
        jmp bot
        
        
        ;====Draw Mid Part=============
        mid:
        mov ax,di   ;Restart row
        mov bx,si   ;Restart Column
        drawRectangle ax,bx,1,9,color 
        
        
        
        popa
ENDM   drawRightPlayerArrow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawLeftCharacter macro row,column
        local loop1,loop2,loop3
        pusha
        ;===Character===
        
        ;INITILIZATION
        mov ax,row
        mov bx,column
        
        ;tophair
        
        drawRectangle ax,bx,3,18,08h
        
        ;backhair
        
        add ax,3
        drawRectangle ax,bx,4,3,08h 
        
        ;topface
        
        add bx,3
        drawRectangle ax,bx,6,14,0eh
        
        ;buttomface
        
        add ax,6
        drawRectangle ax,bx,3,12,0eh  
        
        ;mouth
        
        add bx,6
        drawRectangle ax,bx,1,5,00h    
        
        ;left eye
        
        sub ax,6
        add bx,7
        drawRectangle ax,bx,3,2,00h  
        
        ;right eye
        
        add ax,2
        sub bx,9
        drawRectangle ax,bx,2,3,00h  
        
        
        ;clothes
        
        add ax,7
        sub bx,5
        drawRectangle ax,bx,17,15,02h
        
        ;left hand
        
        add ax,5
        drawRectangle ax,bx,3,11,0eh
        
        ;left leg
        
        
        add ax,12
        add bx,2
        drawRectangle ax,bx,8,4,0eh
        
        ;rightleg
       
        add bx,6
        drawRectangle ax,bx,8,4,0eh
        
        
        ;====Bow====
        
        ;top
        
        sub ax,12
        add bx,3 
        mov cx,3
        
        loop1:
        drawRectangle ax,bx,2,2,06h   
        sub ax,2
        add bx,2
        dec cx
        jnz loop1
        
        
        ;Buttom
        add ax,8
        sub bx,4
        mov cx,2
        loop2:
        drawRectangle ax,bx,2,2,06h  
        add ax,2
        add bx,2
        dec cx
        jnz loop2
        
        
        ;Front
        sub ax,4
        mov cx,3
        loop3:
        drawRectangle ax,bx,2,2,06h  
        sub ax,2
        dec cx
        jnz loop3
        
       popa
       ENDM drawLeftCharacter 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
clearLeftCharacter macro row,column
    pusha
    mov ax,row
    mov bx,column
    drawRectangle ax,bx,37,21,00h
    popa
endm  clearLeftCharacter  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
drawRightCharacter macro row,column
        local loop1,loop2,loop3
        pusha
        ;===Character===
        
        ;INITILIZATION
        mov ax,row
        mov bx,column
        
        ;tophair
        
        drawRectangle ax,bx,3,18,08h
        
        ;backhair
        
        add ax,3
        add bx,15
        drawRectangle ax,bx,4,3,08h 
        
        sub bx,16
        ;topface
            
        add bx,2
        drawRectangle ax,bx,6,14,0eh
        
        ;buttomface
        
        add ax,6
        add bx,2
        drawRectangle ax,bx,3,12,0eh  
        
        ;mouth
        
        add bx,1
        drawRectangle ax,bx,1,5,00h    
        
        ;left eye
        
        sub ax,6
        sub bx,4
        drawRectangle ax,bx,3,2,00h  
        
        ;right eye
        
        add ax,2
        add bx,7
        drawRectangle ax,bx,2,3,00h  
        
        
        ;clothes
        
        add ax,7
        sub bx,6
        drawRectangle ax,bx,17,15,02h
        
        ;left hand
        
        add bx,4
        add ax,5
        drawRectangle ax,bx,3,11,0eh
        
        ;left leg
        
        
        add ax,12
        sub bx,2
        drawRectangle ax,bx,8,4,0eh
        
        ;rightleg
       
        add bx,6
        drawRectangle ax,bx,8,4,0eh
        
        
        ;====Bow====
        
        ;top
        
        sub ax,12
        sub bx,6 
        mov cx,3
        
        loop1:
        drawRectangle ax,bx,2,2,06h   
        sub ax,2
        sub bx,2
        dec cx
        jnz loop1
        
        ;Buttom
        add ax,8
        add bx,4
        mov cx,2
        loop2:
        drawRectangle ax,bx,2,2,06h  
        add ax,2
        sub bx,2
        dec cx
        jnz loop2
        
        
        ;Front
        sub ax,4
        mov cx,3
        loop3:
        drawRectangle ax,bx,2,2,06h  
        sub ax,2
        dec cx
        jnz loop3
        
       popa
       ENDM drawRightCharacter
       
    clearRightCharacter macro row,column
    pusha                               
    mov ax,row
    mov bx,column
    sub bx,3
    drawRectangle ax,bx,37,21,00h
    popa
    endm  clearRightCharacter 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
clearLeftPlayerArrow macro row,column
    pusha
    
    ;=========Initialization======
    mov ax,row
    mov bx,column
    
    ;========Clear===============
    drawLeftPlayerArrow ax,bx,00h
    
    popa
endm clearLeftPlayerArrow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
clearRightPlayerArrow macro row,column
    pusha
    
    ;=========Initialization======
    mov ax,row
    mov bx,column
    
    ;========Clear===========
    drawRightPlayerArrow row,column ,00h
    
    popa
endm clearRightPlayerArrow  
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawWall macro endrow,wheight,color
    pusha
    mov ax,endrow
    mov bx,159
    sub ax,wheight
    drawRectangle ax,bx,wheight,2,color
    popa
endm drawWall 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

help macro row,column,flag,color,ascii
        ;;;
        ;       flag = 0 -> draw from the left
        ;       flag = 1 -> clear from left (just clear the heart without drawing new one works only if the heart was drawn from the left side of the screen (flag = s0))
        ;       flag = 2 -> draw from right
        ;       flag = 3 -> clear form right (just clear the heart without drawing new one works only if the heart was drawn from the right side of the screen (flag = 1))
        ;       important notes:
        ;               1 - the function set column to 0 when it reach the end of the screen wether from right or from left
        ;               2 - shape color is to be used for intersection detection  
        ;               3 - function must take column and flag as variables not just values
        ;               4 - never change the value of column outside the macro you wouldn't need to anyway
        ;               5 - the function is very capsulated as it do everything needed drawing from both directions and clearing from both directions
        ;;;
        
        ;localizing labels just to make the macro multi-callable without repeting label error
        LOCAL clear_help_left
        LOCAL clear_help_right
        LOCAL clear_help
        LOCAL draw_help
        LOCAL draw_shape
        LOCAL clear_shape
        LOCAL end_drawing
        LOCAL end_just_clear
        LOCAL end_draw_help

        pusha
        inc column ;increment the column to draw in a new position

        mov cl,column
        cmp flag,2
        jb  clear_help
        ;fix for drawing from right column = 40 - column -> 40 = 320 / 8 width of the screen(because ascii in video mode takes 8 pixels per symbol) 
        mov ch,column
        mov cl,40
        sub cl,ch
        ;================================================end of fixxing;================================================
        jmp clear_help 

clear_help_left:
        ;Move Cursor to desired point
        dec cl
        mov dl, cl     ;Column
        mov dh, row    ;Row
        mov bh, 0      ;Display page
        mov ah, 02h    ;SetCursorPosition
        int 10h
        inc cl
        jmp clear_shape 

clear_help_right:
        ;Move Cursor to desired point
        inc cl
        mov dl, cl     ;Column
        mov dh, row    ;Row
        mov bh, 0      ;Display page
        mov ah, 02h    ;SetCursorPosition
        int 10h
        dec cl
        jmp clear_shape

clear_help:
        cmp flag,2
        jb  clear_help_left
        jmp clear_help_right

draw_help:
        mov  dl, cl     ;Column
        mov  dh, row    ;Row
        mov  bh, 0      ;Display page
        mov  ah, 02h    ;SetCursorPosition
        int  10h
        jmp draw_shape     

draw_shape:
        mov  al, ascii  ;ascii symbol
        mov  bl, color  ;Color is blue
        mov  bh, 0      ;Display page
        mov  ah, 0eh    ;sTeletype
        int  10h
        jmp  end_drawing

clear_shape:
        mov  al, ascii  ;ascii symbol
        mov  bl, 0h     ;Color is black
        mov  bh, 0      ;Display page
        mov  ah, 0eh    ;Teletype
        int  10h
        cmp flag,1
        je  end_just_clear
        cmp flag,3
        je  end_just_clear
        jmp  draw_help

end_drawing:
        cmp column,39
        jb  end_draw_help 
        
        mov dl, cl     ;Column
        mov dh, row    ;Row
        mov bh, 0      ;Display page
        mov ah, 02h    ;SetCursorPosition
        int 10h

        ;Draw ascii Symbol
        mov al, ascii  ;ascii symbol
        mov bl, 0h     ;Color is black
        mov bh, 0      ;Display page
        mov ah, 0eh    ;Teletype
        int 10h   

end_just_clear:
       mov column,0 
end_draw_help:       
       popa
ENDM help