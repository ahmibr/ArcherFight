;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                     ;
; Author:Ahmed Ibrahim                                ;
; Date:23-11-2017                                     ;
; This Macro draws a Health in coordinates row,column ;
; Assumes it's in graphics mode                       ;
; Health Bar is Rectangle 104 width     6 height      ;
;                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

 
 
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