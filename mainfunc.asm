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
;; Contains the functions used everywhere in the program.
;;
;; Index:
;;     _print_header()             -- Print the HANGMAN logo on the screen.
;;     _move_cursor(POS_X, POS_Y)  -- Move the cursor on the screen to
;;                                    (POS_X, POS_Y).
;;     _clear_screen()             -- Clear the screen.
;;



;============================================================= _draw_ui() ====
;; Draw the user interface on the screen

;; The UI looks like that:
;; +------------------------------------+
;; |                                    |
;; |           H A N G M A N            |
;; |                                    |
;; +------------------------------------+
;; |                                    |
;; |                                    |
;; |                                    |
;; |        Menu/Game/Animation         |
;; |                                    |
;; |                                    |
;; |                                    |
;; +------------------------------------+
;; | Informations/help                  |
;; +------------------------------------+

;; Usage:
;; call _draw_ui


_draw_ui:

;Backup registers
push ax
push bx
push cx
push dx

;Draw the blue part
mov ah, 0x07
mov al, 0            ; Clear
mov bh, COLOR_HEADER ; Color
mov cx, 0            ; (0,0) +-----------+
mov dh, ROWS         ;       |           |
mov dl, COLS         ;       +-----------+ (COLS,ROWS)
int 0x10

;Draw the black part
mov ah, 0x07
mov al, 0                ; Clear
mov bh, COLOR_ACTIVE     ; Color
mov ch, header_height+1  ; (0,header_height+1) +-----------+
mov cl, 0                ;                     |           |
mov dh, ROWS-2           ;                     |           |
mov dl, COLS             ;                     +-----------+ (COLS,ROWS-2)
int 0x10

;Draw the header
call _print_header

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;======================================================== _print_header() ====
;; Print the HANGMAN logo on the screen

;; Usage:
;; call _print_header


_print_header:

mov POS_X, 9
mov POS_Y, 0

mov ah, 0x09
mov dx, offset header

;Header
header_loop:
    call _move_cursor
    int 0x21
    inc POS_Y
    add dx, header_len
    cmp POS_Y, header_height
    jne header_loop

ret


;Datas of the _print_header function
header db " __   __  _______  __    _  _______  __   __  _______  __    _ $"
       db "|  | |  ||   _   ||  |  | ||       ||  |_|  ||   _   ||  |  | |$"
       db "|  |_|  ||  |_|  ||   |_| ||    ___||       ||  |_|  ||   |_| |$"
       db "|       ||       ||       ||   | __ |       ||       ||       |$"
       db "|       ||       ||  _    ||   ||  ||       ||       ||  _    |$"
       db "|   _   ||   _   || | |   ||   |_| || ||_|| ||   _   || | |   |$"
       db "|__| |__||__| |__||_|  |__||_______||_|   |_||__| |__||_|  |__|$"

header_len    equ 64
header_height equ  7



;========================================================== _print_help() ====
;; Print the help message on the bottom of the screen

;; Usage:
;; mov HELP_STR, offset <string_label>
;; call _print_help

;; Function arg
HELP_STR dw 0 ; The adresse of the help string to print, the string must end
              ; with a '$' char and its length can't be higher than 78 chars;


_print_help:

;Backup registers
push ax
push dx

;Move the cursor at the bottom of the screen
mov POS_X, 1
mov POS_Y, ROWS-1
call _move_cursor

;Print the text
mov ah, 0x09
mov dx, HELP_STR
int 0x21

;Restore registers
pop dx
pop ax

ret



;============================================= _move_cursor(POS_X, POS_Y) ====
;; Move the cursor on the screen to (POS_X, POS_Y).

;; Usage:
;; mov POS_X, <X_POS>
;; mov POS_Y, <Y_POS>
;; call _move_cursor

;; Function args
POS_X db 0  ; The x position of the cursor
POS_Y db 0  ; The y position of the cursor


_move_cursor:

;Backup registers
push ax
push bx
push dx

;Move the cursor
mov ah, 0x02
mov dh, POS_Y   ; Row
mov dl, POS_X   ; Column
mov bh, 0       ; Page
int 0x10

;Restore registers
pop dx
pop bx
pop ax

ret



;======================================================== _clear_screen() ====
;; Clear the screen.

;; Usage:
;; call _clear_screen


_clear_screen:

;Backup registers
push ax
push bx
push cx
push dx

;Clear the screen
mov ah, 0x07
mov al, 0         ; Clear
mov bh, 00001111b ; White on black
mov cx, 0         ; (0,0) +-----------+
mov dh, ROWS      ;       |           |
mov dl, COLS      ;       +-----------+ (COLS,ROWS)
int 0x10

;Move the cursor to (0,0)
mov POS_X, 0
mov POS_Y, 0
call _move_cursor

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


