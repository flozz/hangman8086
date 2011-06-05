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
;;  Copyright (C) 2011  Germain CARR�                                       ;;
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
;;     _draw_ui()                  -- Draws the user interface on the screen.
;;     _clear_working()            -- Clears the working part of the screen.
;;     _print_header()             -- Prints the HANGMAN logo on the screen.
;;     _print_help(HELP_STR)       -- Prints the help message on the bottom of
;;                                    the screen.
;;     _move_cursor(POS_X, POS_Y)  -- Moves the cursor on the screen to
;;                                    (POS_X, POS_Y).
;;     _input_letter()             -- Waits for input and returns an uppercase
;;                                    letter, KB_ESC, KB_BKSP or KB_ENTER.
;;     _clear_screen()             -- Clears the screen.
;;     _memcpy(MEMCPY_SRC,         -- Copy bytes to an other place in the
;;             MEMCPY_DEST,           memory.
;;             MEMCPY_LEN)
;;     _strlen(STRLEN_STR)         -- Counts the number of bytes that composes
;;                                    a string.
;;     _input_field(IF_MSG,        -- Display an input field.
;;                  IF_MAXLEN,
;;                  IF_EWD)
;;



KB_ESC   equ 0x1B
KB_BKSP  equ 0x08
KB_ENTER equ 0x0D



;============================================================= _draw_ui() ====
;; Draws the user interface on the screen.

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

;Draw the header and help parts
mov ah, 0x07
mov al, 0            ; Clear
mov bh, COLOR_HEADER ; Color
mov cx, 0            ; (0,0) +-----------+
mov dh, ROWS         ;       |           |
mov dl, COLS         ;       +-----------+ (COLS,ROWS)
int 0x10

;Draw the working part
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



;======================================================= _clear_working() ====
;; Clears the working part of the screen.

;; +------------------------------------+
;; |                                    |
;; |           H A N G M A N            |
;; |                                    |
;; +------------------------------------+
;; |                                    | \
;; |                                    |  |
;; |                                    |  | Clear
;; |        Menu/Game/Animation         |  | that
;; |                                    |  | part
;; |                                    |  |
;; |                                    | /
;; +------------------------------------+
;; | Informations/help                  |
;; +------------------------------------+

;; Usage:
;; call _clear_working


_clear_working:

;Backup registers
push ax
push bx
push cx
push dx

;Clear the working part
mov ah, 0x07
mov al, 0                ; Clear
mov bh, COLOR_ACTIVE     ; Color
mov ch, header_height+1  ; (0,header_height+1) +-----------+
mov cl, 0                ;                     |           |
mov dh, ROWS-2           ;                     |           |
mov dl, COLS             ;                     +-----------+ (COLS,ROWS-2)
int 0x10

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;======================================================== _print_header() ====
;; Prints the HANGMAN logo on the screen

;; Usage:
;; call _print_header


_print_header:

mov POS_X, (COLS-header_len)/2
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



;================================================== _print_help(HELP_STR) ====
;; Prints the help message on the bottom of the screen.

;; Usage:
;; mov HELP_STR, offset <string_label>
;; call _print_help

;; Function arg:
HELP_STR dw 0 ; The address of the help string to print, the string must end
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
;; Moves the cursor on the screen to (POS_X, POS_Y).

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



;======================================================== _input_letter() ====
;; Waits for input and returns an uppercase letter, KB_ESC, KB_BKSP or KB_ENTER.

;; Usage:
;; call _input_letter

;; Returns:
LETTER db 0 ;An upper case letter (or KB_ESC, KB_BKSP, KB_ENTER).


_input_letter:

;Backup registers
push ax

input_letter_st:
;Wait for input
mov ax, 0x0000
int 0x16

;Check if it is a special char (Esc, BkSp, Enter)
cmp al, KB_ESC
je  end_input_letter
cmp al, KB_BKSP
je  end_input_letter
cmp al, KB_ENTER
je  end_input_letter

;Check if the char is an upper case letter
cmp al, 'A'          ; al < 'A'    -> input_letter_st
jl  input_letter_st  ;
cmp al, 'Z'          ; al <= 'Z'   -> end_input_letter
jle end_input_letter ;

;Check if the char is a lower case letter
cmp al, 'a'          ; al < 'a'    -> input_letter_st
jl  input_letter_st  ;
cmp al, 'z'          ; al > 'z'    -> input_letter_st
jg  input_letter_st  ;

;The char is a lowercase letter, convert it into uppercase
sub al, 0x20

end_input_letter:
mov LETTER, al

;Restore registers
pop ax

ret



;======================================================== _clear_screen() ====
;; Clears the screen.

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



;=========================== _memcpy(MEMCPY_SRC, MEMCPY_DEST, MEMCPY_LEN) ====
;; Copy bytes to an other place in the memory.

;; Usage:
;; mov MEMCPY_SRC, offset <src>
;; mov MEMCPY_DEST, offset <dest>
;; mov MEMCPY_LEN, <len>
;; call _memcpy

;; Function args:
MEMCPY_SRC  dw 0  ; The source address
MEMCPY_DEST dw 0  ; The destination address
MEMCPY_LEN  db 0  ; The number of bytes to copy


_memcpy:

;Backup registers
push ax
push bx
push cx
push dx

;Push the source bytes in the stack
mov ax, 0
mov bx, MEMCPY_SRC
mov cl, MEMCPY_LEN

memcpy_pshloop:
    mov al, [bx]
    push ax
    inc bx
    dec cl
    cmp cl, 0
    jne memcpy_pshloop

;Pop the bytes from the stack to the destination
mov bx, MEMCPY_DEST
mov ah, 0
mov al, MEMCPY_LEN
add bx, ax
dec bx

mov cl, MEMCPY_LEN

memcpy_poploop:
    pop ax
    mov [bx], al
    dec bx
    dec cl
    cmp cl, 0
    jne memcpy_poploop

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;==================================================== _strlen(STRLEN_STR) ====
;; Counts the number of bytes that composes a string.

;; NOTE: The string must end with the '$' char !

;; Usage:
;; mov STRLEN_STR, offset <str>
;; call _strlen

;; Function args:
STRLEN_STR  dw 0  ; The address of the string

;; Returns:
STRLEN_LEN  db 0  ; The length of the string


_strlen:

;Backup registers
push ax
push bx

mov bx, STRLEN_STR
mov STRLEN_LEN, 0

strlen_loop:
    mov al, [bx]
    cmp al, '$'
    je  strlen_end
    inc STRLEN_LEN
    inc bx
    jmp strlen_loop

strlen_end:

;Restore registers
pop bx
pop ax

ret



;================================ _input_field(IF_MSG, IF_MAXLEN, IF_EWD) ====
;; Display an input field.

;; Usage:
;; mov IF_MSG, offset <src>
;; mov IF_MAXLEN, <len>
;; mov IF_EWD, <0/1>
;; call _input_field

;; Function args:
IF_MSG      dw 0  ; The message address (must end with '$')
IF_MAXLEN   db 0  ; The maximum len of the input (max = 30)
IF_EWD      db 0  ; End with $ ? (0 = False, 1 = True)

;; Returns:
IF_WORD     db "-------------------------------" ; The input word


_input_field:

;Backup registers
push ax
push bx
push cx
push dx

;Clear the screen (draw the UI)
call _draw_ui
mov  HELP_STR, offset if_help
call _print_help

;Fill IF_WORD with spaces or $
mov cl, 31
mov bx, offset IF_WORD
if_fill_word_loop:
    cmp IF_EWD, 1 ; ' ' or '$' ?
    je  if_fill_word_dollard
    mov [bx], ' '
    jmp if_fill_word_dollard_end
    if_fill_word_dollard:
    mov [bx], '$'
    if_fill_word_dollard_end:
    inc bx
    dec cl
    cmp cl, 0
    jne if_fill_word_loop

;Display the message
    ;Center the message
    mov ax, IF_MSG
    mov STRLEN_STR, ax
    call _strlen
    mov ah, 0
    mov al, STRLEN_LEN
    mov bl, 2
    div bl
    mov ah, COLS / 2
    sub ah, al
    mov POS_X, ah
    mov POS_Y, header_height
    add POS_Y, 5
    call _move_cursor
    ;Print the message
    mov ah, 0x09
    mov dx, IF_MSG
    int 0x21

;Display the field
    ;Center the field
    mov ah, 0
    mov al, IF_MAXLEN
    mov bl, 2
    div bl
    mov ah, COLS / 2
    sub ah, al
    mov POS_X, ah
    add POS_Y, 2
    call _move_cursor
    ;print the field
    mov ah, 0x07
    mov al, 0            ; Clear
    mov bh, COLOR_FIELD  ; Color
    mov ch, POS_Y        ; x1
    mov cl, POS_X        ; x1
    mov dh, POS_Y        ; y2
    mov dl, POS_X        ; x2
    add dl, IF_MAXLEN    ; ~~
    inc dl               ; ~~
    int 0x10

mov if_wlen, 0

;Intput field main loop
if_loop:
    call _input_letter
    cmp LETTER, KB_ENTER ; Validate
    je  if_loop_end
    cmp LETTER, KB_ESC  ; skip esc
    je  if_loop
    cmp LETTER, KB_BKSP  ; Remove last letter
    je  if_loop_bksp

    ;Add the letter if the buffer is not full
    mov ah, IF_MAXLEN
    cmp if_wlen, ah
    je  if_loop

    ;buff
    mov bx, offset IF_WORD
    mov ah, 0
    mov al, if_wlen
    add bx, ax
    mov al, LETTER
    mov [bx], al
    inc if_wlen

    ;disp
    inc POS_X
    call _move_cursor
    mov ah, 0x06
    mov dl, LETTER
    int 0x21

    jmp if_loop

    if_loop_bksp:
    cmp if_wlen, 0 ;empty
    je  if_loop

    ;buff
    mov bx, offset IF_WORD
    mov ah, 0
    mov al, if_wlen
    add bx, ax
    dec bx
    cmp IF_EWD, 1
    je  if_loop_ewd
    mov [bx], ' '
    jmp if_loop_ewdend
    if_loop_ewd:
    mov [bx], '$'
    if_loop_ewdend:
    dec if_wlen

    ;disp
    call _move_cursor
    mov ah, 0x06
    mov dl, ' '
    int 0x21
    dec POS_X

    jmp if_loop

    if_loop_end:

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


;Var
if_wlen db 0

;Help
if_help  db 0xDA,"A-Z",0xBF," Try a letter   ",0xDA,"Enter",0xBF," Validate"
         db "                                         $"


