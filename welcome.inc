;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

welcomeScreen   MACRO input
        LOCAL invalid 
        LOCAL check_upper
        lOCAL check_lower  
        LOCAL valid
        LOCAL back
        LOCAL prog_options 
        LOCAL wait_for_enter
        LOCAL end_welcome_screen
        LOCAL print_dashes
        
        pusha     
        
        ;clearing the screen
        mov ax,0600h
        mov bh,07h
        mov cx,0
        mov dx,184Fh
        int 10h
        ;-------------------
        
        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0
    
        ;================printing welcome screen================   
        ;move cursor to the right place for print the welcome_message1
        mov ah,2 
        mov dh,0Bh
        mov dl,1Bh
        int 10h
        ;-------------------------------------------------------------
        ;print welcome_message1
        mov ah,9
        mov dx,offset welcome_message1
        int 21h
        ;----------------------
        ;move cursor to the right place for print the welcome_message2
        mov ah,2 
        mov dh,0Eh
        mov dl,19h
        int 10h 
        ;-------------------------------------------------------------                 
        ;print welcome_message2
        mov ah,9
        mov dx,offset welcome_message2
        int 21h
        ;----------------------
        ;================printing welcome screen================ 
        
        ;moving cursor to the right position to take input from user
        mov ah,2 
        mov dh,0Ch
        mov dl,1Fh
        int 10h
        ;-----------------------------------------------------------  
        
        mov si,offset input  
        mov cx,15    ;maximum number of charecters could be entered
        
invalid:        
        mov ah,07h   ;get charecter from keyboard without displaying it
        int 21h
        
        cmp al,08h   ;if the charecter is backSpace remove the last charecter entered if exsist or do nothing
        je  back
                     
        cmp al,0Dh   ;if the entered charecter is retrun then save the entered name or do nothing if no charecter entered
        je  prog_options 
                
        cmp cx,0
        je  invalid        
                
        cmp al,41h   ;letters ascii can never be less than 41h
        jae check_upper
        jmp invalid
        
check_upper:
        cmp al,5Ah   ;if charecter is upper case its ascii will never exceed 5Ah
        jbe valid    ;charecter is a upper case letter then it's valid and to be stored
        cmp al,61h   ;lower case charecters ascii starts from 61h
        jae check_lower
        jmp invalid  ;charecters between 5Ah and 61h are not letters then invalid
        
check_lower: 
        cmp al,7Ah   ;lower case charecters ascii can never exceed 7Ah
        jbe valid    ;charecter is a lower case letter then it's valid and to be stored
        jmp invalid  ;charecters with ascii greater than 7Ah are not valid letters      
        
valid:  mov [si],al  ;store the entered charecter             
        inc si       
        
        ;print the charecter
        mov ah,2
        mov dl,al
        int 21h   
        ;-------------------   
        
        dec cx  ;decrease number of letters could be entered  
        jmp invalid
        
back:   cmp cx,15   ;if cx = 15 then no charecters entered before then invalid
        je  invalid             
        
        inc cx      ;increase number of charecters you can enter
        push cx     ;GetCursor return the value in cx and dx so keep cx in stack till the end of the label       
        
        ;===move the cursor a step back to the last charecter postion and erase the last letter=== 
        ;get cursor position  
        mov ah,3 
        mov bh,0
        int 10h
        ;------------------- 
        ;move the cursor a step back   
        dec dl      ;decrement the column to move the cursor to the previous letter
        mov ah,2
        int 10h      
        ;---------------------------
        ;print null to erase the last charecter
        mov ah,2
        mov dl,0
        int 21h     
        ;--------------------------------------
        ;===move the cursor a step back to the last charecter postion and erase the last letter=== 
        
        ;===move the cursor back to one step again as it moved a step forward to print null===
        ;get cursor position  
        mov ah,3 
        mov bh,0
        int 10h
        ;------------------- 
        ;move cursor step back 
        dec dl 
        mov ah,2
        int 10h     
        ;---------------------
        ;===move the cursor back to one step again as it moved a step forward to print null===
        
        dec si      ;decrement the value of si so you write the next charecter on this charecter 
        mov [si],'$';just in case he didn't enter any more letters
        pop cx      ;restore the value of cx
        jmp invalid        
        
prog_options:  
        ;check if user didn't enter any charecters 
        cmp cx,15
        je  invalid 
        ;-----------------------------------------  
        
        ;clearing the screen
        mov ax,0600h
        mov bh,07h
        mov cx,0
        mov dx,184Fh
        int 10h
        ;------------------- 
        
        mov bx,0    ;if bx have a value in it the cursor won't move why (i have no idea it just doesn't move)
        
        ;================printing options to choose form================        
        ;printing game option1 
        mov ah,2 
        mov dh,0Ah
        mov dl,18h
        int 10h
        
        mov ah,9
        mov dx,offset prog_op1
        int 21h
        ;---------------------
        ;printing game option2
        mov ah,2 
        mov dh,0Ch
        mov dl,18h
        int 10h      
        
        mov ah,9
        mov dx,offset prog_op2
        int 21h
        ;---------------------
        ;printing game option2
        mov ah,2 
        mov dh,0Eh
        mov dl,18h
        int 10h  
                        
        mov ah,9
        mov dx,offset prog_op3
        int 21h      
        ;---------------------
        ;printing dashes at the bottom of the screen (status bar boundry)
        mov ah,2 
        mov dh,16h
        mov dl,0h
        int 10h  
        
        mov cx,80
        mov ah,2
        mov dl,'-'
        print_dashes:
            int  21h 
            loop print_dashes  
        ;-----------------------------------------------------------------    
        ;================printing options to choose form================    
        
wait_for_enter:  
        ;wait for user to press enter to enter the game
        mov ah,07h
        int 21h           
        
        cmp al,0Dh
        je  end_welcome_screen
        
        jmp wait_for_enter
        
end_welcome_screen:
        popa                    
ENDM welcomeScreen        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;