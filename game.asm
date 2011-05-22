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
;; Contains the game functions.
;;
;; Index:
;;     _play(WORD, PLAYER)  -- Play to hangman.
;;     _game_init()         -- Initialize the game.
;;     _print_gibbet        -- Print the gibbet with remaining lives.
;;     _print_gword         -- Print the guessed word (e.g. H _ _ _ _ _ N).
;;     _print_tried_letters -- Print the letters that the player have already
;;                             tried (e.g. A U I O W).
;;



GAME_STATUS_LOOSE equ 0
GAME_STATUS_WIN   equ 1



;==================================================== _play(WORD, PLAYER) ====
;; Play to hangman.

;; Usage:
;; mov WORD, offset <word>
;; mov PLAYER, offset <playername>
;; call _play

;; Function args:
WORD   dw 0 ;The adress of the word to guess.
PLAYER dw 0 ;The adress of the player name.

;; Returns:
GAME_STATUS db 0 ;The game status (GAME_STATUS_LOOSE, GAME_STATUS_WIN).


_play:

;Backup registers
push ax
push bx
push cx
push dx

call _draw_ui
call _game_init

mov GAME_STATUS, GAME_STATUS_LOOSE

play_main_loop:
    call _clear_working
    call _print_gword

    ;Check if the play win
    ;for checking we search underscors in play_gword... It is not very
    ;pretty but it works...
    play_check_win:
    mov cl, play_word_len
    mov bx, offset play_gword
    play_check_win_loop:
        cmp [bx], '_'
        je  play_check_win_end ;not won yet
        inc bx
        dec cl
        cmp cl, 0
        jne play_check_win_loop
        ;The player win !
        mov GAME_STATUS, GAME_STATUS_WIN
        jmp play_end
    play_check_win_end:

    call _print_tried_letters
    call _print_gibbet

    call _input_letter

    ;Check fo special keys
    cmp LETTER, KB_ENTER ;skip enter
    je  play_main_loop
    cmp LETTER, KB_BKSP  ;skip backspace
    je  play_main_loop
    cmp LETTER, KB_ESC   ;stop with esc
    je  play_end

    ;Check if the player have already tried this letter
    mov cl, play_tried_len
    mov bx, offset play_tried_letters
    mov al, LETTER
    play_ckeck_tried:
        cmp [bx], al
        je play_main_loop ;Letter already in the list -> play_main_loop
        inc bx
        dec cl
        cmp cl, 0
        jne play_ckeck_tried

    ;The letter is not in the list (play_tried_letters), so we add it
    mov cl, play_tried_len
    mov bx, offset play_tried_letters
    mov al, LETTER
    play_add_letter:
        cmp [bx], ' ' ;Search a space
        je play_add_letter_add
        inc bx
        dec cl
        cmp cl, 0
        jne play_add_letter
        jmp play_add_letter_end ;Something is wrong... no more place !
        play_add_letter_add:
            mov [bx], al
        play_add_letter_end:

    ;Check if the letter is in the word
    mov cl, play_word_len
    sub cl, 2
    mov bx, offset play_word
    inc bx
    mov al, LETTER
    play_check_word:
        cmp [bx], al
        je play_check_word_end
        inc bx
        dec cl
        cmp cl, 0
        jne play_check_word
        ;The letter is not in the word
        dec play_lives
        play_check_word_end:

    ;Check the lives
    cmp play_lives, 0
    je  play_end ;loose

    jmp play_main_loop

play_end:

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


;_play vars
play_word          db  "------------------------------"
play_word_len      db  0
play_word_max_len  equ 30

play_gword         db  "------------------------------"
play_tried_letters db  "--------------------------"
play_tried_len     equ 26

play_lives         db  0



;=========================================================== _game_init() ====
;; Initialize the game.

;; NOTE: Called by the _play() function.

;; Usage:
;; call _game_init


_game_init:

;Backup registers
push ax
push bx
push cx
push dx

;Put the length of WORD in play_word_len
mov ax, WORD
mov STRLEN_STR, ax
call _strlen
mov al, STRLEN_LEN
mov play_word_len, al

;Put the WORD in play_word
mov ax, WORD
mov MEMCPY_SRC, ax
mov MEMCPY_DEST, offset play_word
mov al, STRLEN_LEN
mov MEMCPY_LEN, al
call _memcpy

;Fill play_tried_letters with spaces
mov bx, offset play_tried_letters
mov cl, play_tried_len

game_init_sploop:
    mov [bx], ' '
    inc bx
    dec cl
    cmp cl, 0
    jne game_init_sploop

;Init the play_lives to 10 (with gibbet) or 6 (without gibbet)
mov play_lives, 10 ;FIXME ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;======================================================== _print_gibbet() ====
;; Print the gibbet with remaining lives.

;; Usage:
;; call _print_gibbet


_print_gibbet:

;Backup registers
push ax
push bx
push cx
push dx

;calculate the adresse of the gibbet that fit with the remaining lives
mov ah, 0
mov al, GIBBET_WIDTH
mov bh, 0
mov bl, GIBBET_HEIGHT
mul bl

mov bx, 10
sub bl, play_lives
mul bl

mov bx, offset HANGMAN_LIVES_10
add bx, ax

;Print the guibet
mov cl, GIBBET_HEIGHT
mov ah, 0x09
mov dx, bx
mov bx, GIBBET_WIDTH
mov POS_X, COLS - GIBBET_WIDTH - 2
mov POS_Y, (ROWS - GIBBET_HEIGHT) / 2 + (header_height - 1) / 2
print_gibbet_loop:
    call _move_cursor
    int 0x21 ;print
    add dx, bx
    inc POS_Y
    dec cl
    cmp cl, 0
    jne print_gibbet_loop

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;========================================================= _print_gword() ====
;; Print the guessed word (e.g. H _ _ _ _ _ N).

;; Usage:
;; call _print_gword


_print_gword:

;Backup registers
push ax
push bx
push cx
push dx

;Copy the word in play_gword
mov ax, WORD
mov MEMCPY_SRC, ax
mov MEMCPY_DEST, offset play_gword
mov al, STRLEN_LEN
mov MEMCPY_LEN, al
call _memcpy

;Make the string
mov cl, play_word_len
sub cl, 2
mov bx, offset play_gword
inc bx

print_gword_mkloop:
    mov al, [bx]
    mov ch, play_tried_len
    push bx
    mov bx, offset play_tried_letters
    print_gword_mkloop1:
        mov ah, [bx]
        cmp ah, al
        je print_gword_lil
        dec ch
        inc bx
        cmp ch, 0
        jne print_gword_mkloop1

    print_gword_lnil:
        pop bx
        mov [bx], '_'
        jmp print_gword_mkloopend

    print_gword_lil:
        pop bx

    print_gword_mkloopend:
        dec cl
        inc bx
        cmp cl, 0
        jne print_gword_mkloop

mov POS_Y, ROWS / 2 + (header_height - 1) - 5
mov POS_X, COLS / 2 - GIBBET_WIDTH + 3
mov al, play_word_len
sub POS_X, al
mov bx, offset play_gword
mov cl, play_word_len
mov ah, 0x02
print_gword_prnloop:
    call _move_cursor
    mov dl, [bx]
    int 0x21 ;print
    inc bx
    add POS_X, 2
    dec cl
    cmp cl, 0
    jne print_gword_prnloop

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;================================================= _print_tried_letters() ====
;; Print the letters that the player have already tried (e.g. A U I O W).

;; Usage:
;; call _print_tried_letters


_print_tried_letters:

;Backup registers
push ax
push bx
push cx
push dx

;Calculate the cursor position
mov POS_Y, ROWS / 2 + (header_height - 1) - 2
mov POS_X, COLS / 2 - GIBBET_WIDTH + 3 ;FIXME  not centered...
mov al, 10
sub al, play_lives
sub POS_X, al

;print letters
mov cl, play_tried_len
mov bx, offset play_tried_letters
mov ah, 0x02

prnletters_loop:
    call _move_cursor
    mov dl, [bx]
    int 0x21 ;print
    inc bx
    add POS_X, 2
    dec cl
    cmp cl, 0
    jne prnletters_loop

print_gword_end:

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


