 org 100h

.model small
.stack 30     

 .data
         mass dd 12, 34, 56, 78, 90 
         dess dd 64  dup(?)             
         lns  dd 10                
         adx  dd ? 		
         abx  dd ?           
         xw   dd ?
         wr   dd ? 		
 .code 

   
mov ax, 3  
int 10h       

mov ax, 1003h
mov bx, 0
int 10h

push ax
mov ax, 0b800h

mov xw, 01h           
        
xor si, si  
mov cx, lns 
cycle:
    mov ax, mass[si]     
     add ax, xw               
    mov dess[si], ax       
    add si,4           
loop cycle

mov cx, lns 
xor si, si
result:
    mov ax,dess[si]
    mov wr, ax
    call view
    add si, 4
    cmp si, 16
    ja stop
loop result
jmp stop     
      
view:
mov bx, wr        

mov cx, 8
print: mov ah, 2   
       mov dl, '0'
       test bl, 10000000b 
       jz zero
       mov dl, '1'
zero:  int 21h
       shl bl, 1
loop print   
mov dl, ' '
int 21h
ret

stop:
mov ah, 0
int 16h
ret
   
