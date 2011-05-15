;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      __   __  _______  __    _  _______  __   __  _______  __    _       ;;
;;     |  | |  ||   _   ||  |  | ||       ||  |_|  ||   _   ||  |  | |      ;;
;;     |  |_|  ||  |_|  ||   |_| ||    ___||       ||  |_|  ||   |_| |      ;;
;;     |       ||       ||       ||   | __ |       ||       ||       |      ;;
;;     |       ||       ||  _    ||   ||  ||       ||       ||  _    |      ;;
;;     |   _   ||   _   || | |   ||   |_| || ||_|| ||   _   || | |   |      ;;
;;     |__| |__||__| |__||_|  |__||_______||_|   |_||__| |__||_|  |__|      ;;
;;                                                                          ;;
;;                                                                          ;;
;;  HANGMAN - An implementation of the Hang Man game in assembly (Emu8086)  ;;
;;                                                                          ;;
;;  Copyright (C) 2011  Fabien LOISON                                       ;;
;;  Copyright (C) 2011  Mathilde BOUTIGNY                                   ;;
;;  Copyright (C) 2011  Vincent PEYROUSE                                    ;;
;;  Copyright (C) 2011  Germain CARRÉ                                       ;;
;;  Copyright (C) 2011  Matthis FRENAY                                      ;;
;;                                                                          ;;
;;  HangMan is free software: you can redistribute it and/or modify         ;;
;;  it under the terms of the GNU General Public License as published by    ;;
;;  the Free Software Foundation, either version 3 of the License, or       ;;
;;  (at your option) any later version.                                     ;;
;;                                                                          ;;
;;  This program is distributed in the hope that it will be useful,         ;;
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of          ;;
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           ;;
;;  GNU General Public License for more details.                            ;;
;;                                                                          ;;
;;  You should have received a copy of the GNU General Public License       ;;
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.   ;;
;;                                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;
;; Contains the functions of the main menu.
;;
;; Index:
;;     _main_menu()       -- Display the main menu.
;;     _draw_main_menu()  -- (Re)draw the main menu on the screen.
;;



;=========================================================== _main_menu() ====
;; Display the main menu

_main_menu:

;Move the cursor at the bottom of the screen
mov pos_x, 1
mov pos_y, ROWS-2
call _move_cursor

;Print the help message
mov ah, 0x09
mov dx, offset main_menu_help
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
    je main_menu_kb_space
    cmp al, 0x0D        ;Enter
    je main_menu_kb_enter

    ;Not a valid input... try again ! :p
    jmp main_menu_st

    ;Space key pressed
    main_menu_kb_space:
        inc main_menu_selected

        cmp main_menu_selected, main_menu_items_numb
        jne main_menu_st

        mov main_menu_selected, 0

        jmp main_menu_st

    ;Enter key pressed
    main_menu_kb_enter:
        cmp main_menu_selected, 4      ;Exit
        je main_menu_end

        jmp main_menu_st

main_menu_end:

ret


;=================================================== _draw_main_menu() ====
;; (Re)draw the main menu on the screen.

_draw_main_menu:

;Center the menu
mov pos_x, (80-main_menu_items_len)/2
mov pos_y, header_height
add pos_y, 5

;Prepare the print
mov ah, 0x09
mov dx, offset main_menu_items

mov cx, main_menu_items_numb

;Draw items
draw_menu_loop:
    call _move_cursor
    int 0x21
    add pos_y, 2
    add dx, main_menu_items_len
    dec cx
    cmp cx, 0
    jne draw_menu_loop


;Display the arrow on the selected item
mov pos_y, header_height
add pos_y, 5
mov ah, 0x00
mov al, main_menu_selected
mov bl, 2
mul bl
add pos_y, al

call _move_cursor

mov ah, 0x09
mov al, 0x10
mov bh, 0
mov bl, 00001010b ; Light green
mov cx, 1
int 0x10

ret



;============================ Vars for _main_menu() and _draw_main_menu() ====
main_menu_selected db 1  ;The selected item of the menu



;=========================== Datas for _main_menu() and _draw_main_menu() ====
main_menu_help  db "<Space> Select the next item    <Enter> Validate the item$"
main_menu_items db "  Single Player$"
                db "  Two players  $"
                db "  Options      $"
                db "  Scores       $"
                db "  Quit         $"
main_menu_items_len  equ 16
main_menu_items_numb equ 5


