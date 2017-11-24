;Author:Ahmed Ibrahim
;Date:13-11-2017
;This Macro draws a heart in coordinates row,column
;Assumes it's in graphics mode
;---------------------------  

        
 drawHealthBar macro row,column,health
        local back,back2,back3,back4,lbl1,lbl2 
        pusha
        
        ;====Top Bar====
        mov cx,column         ;Column
        mov dx,row        ;Row       
        mov al,07h         ;Pixel color
        mov bl,101d
        mov ah,0ch       ;Draw Pixel Command
back:   int 10h
        inc cx 
        dec bl
        jnz back  
        
        
        ;======Low Bar=====
        mov cx,column         ;Column
        mov dx,row        ;Row       
        add dx,5           ;lower line
        mov bl,101d
        mov ah,0ch       ;Draw Pixel Command
back2:   int 10h
        inc cx 
        dec bl
        jnz back2 
        
        ;======Left Bar===== 
        mov cx,column         ;Column
        mov dx,row        ;Row 
        mov bl,5
        mov ah,0ch       ;Draw Pixel Command
back3:  int 10h
        inc dx 
        dec bl
        jnz back3
        
        
        ;======Right Bar=====
        mov cx,column         ;Column
        mov dx,row        ;Row
        add cx,101       
        mov bl,6
        mov ah,0ch       ;Draw Pixel Command
back4:  int 10h
        inc dx 
        dec bl
        jnz back4
        
        
        ;==========Full Health========        
        mov al,07h
        mov ah,0ch
        mov bx,health
        mov dx,1
        inc dx
        mov al,0ch
lbl1:
        mov cx,1
        add dx,row
        inc cx
        lbl2:
            add cx,column 
            int 10h
            inc cx
            sub cx,column
            cmp cx,bx
            jnz lbl2
        inc dx
        sub dx,row
        cmp dx,4
        jnz lbl1        
        
        popa
 ENDM drawHealthBar
 
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
        
drawRectangle MACRO row,column,height,width,color
        local back,back2
        pusha  
        mov dx,row        ;Row
        mov si,column       
        mov al,color         ;Pixel color
        mov bl,height
        mov ah,0ch       ;Draw Pixel Command
        
back:   
         mov bh,width
         mov cx,si
            back2:
         int 10h
         inc cx
         dec bh
         jnz back2
         
         inc dx
         dec bl
         jnz back
         
         popa
ENDM drawRectangle

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
        .MODEL SMALL
        .STACK 64
        .DATA           
healthbarcolumn1 EQU 19
healthbarrow1    EQU 18
heart1row EQU  2
heart1column EQU 1

healthbarcolumn2 EQU 210
healthbarrow2    EQU 18
heart2row EQU  2
heart2column EQU 25
health1 EQU 100
health2 EQU 75

color1 EQU 0eh
        ;Your data
        .code
MAIN    PROC FAR
        MOV AX,@DATA
        MOV DS,AX     
        mov ah,0h          ;Change video mode (Graphical MODE)
        mov al,13h        ;Max memory size 16KByte
        int 10h 
        drawLeftCharacter 50,70
        drawRightCharacter 50,200
        drawHealthBar healthbarrow1,healthbarcolumn1,health1 
        drawHealthBar healthbarrow2,healthbarcolumn2,health2
        drawHeart heart1row,heart1column
        drawHeart heart2row,heart2column
        
        lbl1:
        jmp lbl1
MAIN    ENDP
        END MAIN         
        