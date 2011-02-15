;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                        ;;
;; HangMan - An implementation of the Hang Man game in assembly (Emu8086) ;;
;;                                                                        ;;
;; Copyright (C) 2011  Fabien LOISON, Mathilde BOUTIGNY,                  ;;
;; Vincent PEYROUSE and Germain CARRÉ                                     ;;
;;                                                                        ;;
;; HangMan is free software: you can redistribute it and/or modify        ;;
;; it under the terms of the GNU General Public License as published by   ;;
;; the Free Software Foundation, either version 3 of the License, or      ;;
;; (at your option) any later version.                                    ;;
;;                                                                        ;;
;; This program is distributed in the hope that it will be useful,        ;;
;; but WITHOUT ANY WARRANTY; without even the implied warranty of         ;;
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          ;;
;; GNU General Public License for more details.                           ;;
;;                                                                        ;;
;; You should have received a copy of the GNU General Public License      ;;
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.  ;;
;;                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



name "hangman"  ;Output file name

org  0x100      ;Set location counter to 0x100

COLS equ 80     ;Terminal width
ROWS equ 25     ;Terminal height



;================================================================ Main ====
_main:
;Set the video mode to 80x25, 16 colors, 8 pages
mov ah, 0x00
mov al, 0x03
int 0x10    

;Hide the cursor
mov ah, 0x01
mov ch, 32
int 0x10

;Let's go !
call _print_header
call _main_menu

;Exit
mov ah, 0x4C
int 0x21


;=========================================================== Functions ====
;--------------------------------------------------------------------------
_print_header:
 
mov pos_x, 6
mov pos_y, 0

mov ah, 0x09  
mov dx, offset header

;Header                        
header_loop:
    call _move
    int 0x21
    inc pos_y
    add dx, header_len
    cmp pos_y, header_height
    jne header_loop

;Line
mov pos_x, 0
add pos_y, 1
call _move

mov ah, 0x0A
mov al, 0xC4
mov bh, 0
mov cx, 80
int 0x10

ret

     
;--------------------------------------------------- _draw_main_menu ------
_draw_main_menu:

;Center the menu
mov pos_x, (80-menuitem_len)/2
mov pos_y, header_height
add pos_y, 5

;Prepare the print
mov ah, 0x09  
mov dx, offset menuitem

mov cx, menuitem_numb

;Draw items                        
menuDr_loop:
    call _move
    int 0x21
    add pos_y, 2
    add dx, menuitem_len
    dec cx
    cmp cx, 0
    jne menuDr_loop


;Display the arrow on the selected item
mov pos_y, header_height
add pos_y, 5
mov ah, 0x00
mov al, menu_select
mov bl, 2
mul bl
add pos_y, al

call _move

mov ah, 0x09
mov al, 0x10
mov bh, 0
mov bl, 00001010b
mov cx, 1
int 0x10

ret
 
 
;---------------------------------------------------------- _main_menu ----
_main_menu:

;Move the cursor at the bottom of the screen
mov pos_x, 1
mov pos_y, ROWS-2
call _move

;Print the help message
mov ah, 0x09  
mov dx, offset menuhelp
int 0x21

;The main menu
main_menu_st: 
    ;Draw the menu
    call _draw_main_menu
    
    ;Wait for input
    mov ah, 0x07
    int 0x21
    
    ;Test the input
    cmp al, ' '         ;Space
    je menu_kb_space
    cmp al, 0x0D        ;Enter
    je menu_kb_enter
    
    ;Not a valid input... try again ! :p     
    jmp main_menu_st         
    
    ;Space key pressed     
    menu_kb_space:
        inc menu_select
    
        cmp menu_select, menuitem_numb
        jne main_menu_st
    
        mov menu_select, 0 
    
        jmp main_menu_st
    
    ;Enter key pressed
    menu_kb_enter:
        cmp menu_select, 4      ;Exit
        je menu_end
        
        jmp main_menu_st

menu_end:

ret     


     
;====================================================== Main Functions ====
;--------------------------------------------------------------- _move ----
;Move cursor to (pos_x, pos_y)
_move:

;Backup registers
push ax
push bx
push dx

;Move the cursor
mov ah, 0x02     
mov dh, pos_y   ; Row
mov dl, pos_x   ; Column
mov bh, 0       ; Page
int 0x10

;Restore registers
pop dx
pop bx
pop ax 

ret

           

;================================================================ Vars ====
;Cursor Position
pos_x db 0          
pos_y db 0

;Menu
menu_select db 1

 
           
;=============================================================== Datas ==== 
;Header
header db " _   _       ___   __   _   _____       ___  ___       ___   __   _ $"
       db "| | | |     /   | |  \ | | /  ___|     /   |/   |     /   | |  \ | |$"
       db "| |_| |    / /| | |   \| | | |        / /|   /| |    / /| | |   \| |$"
       db "|  _  |   / /_| | | |\   | | |  _    / / |__/ | |   / /_| | | |\   |$"
       db "| | | |  / ___  | | | \  | | |_| |  / /       | |  / ___  | | | \  |$"
       db "|_| |_| /_/   |_| |_|  \_| \_____/ /_/        |_| /_/   |_| |_|  \_|$"
header_len    equ 69
header_height equ  6  

;Menu
menuhelp db "<Space> Select the next item    <Enter> Validate the item$"
menuitem db "  Single Player$"
         db "  Two players  $"
         db "  Options      $" 
         db "  credits      $"
         db "  Quit         $"
menuitem_len  equ 16
menuitem_numb equ 5

