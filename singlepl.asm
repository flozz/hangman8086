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
;; Contains the single player mode.
;;
;; Index:
;;     _single_player()    -- Play in single player mode.
;;     _sp_gameover()      -- Prints the game over screen
;;



;======================================================= _single_player() ====
;; Play in single player mode.

;; Usage:
;; call _single_player


_single_player:

;Backup registers
push ax
push bx
push cx
push dx

;Get the mode
call _mode_menu

;Back to the main menu if necessary
cmp MODE, -1
je  sp_end

;Ask the players name if the competition mode is selected
cmp MODE, MODE_COMPETITION
jne sp_plname_end
mov IF_MSG, offset sp_msg_plname
mov IF_MAXLEN, 8
mov IF_EWD, 0
call _input_field
mov MEMCPY_SRC, offset IF_WORD
mov MEMCPY_DEST, offset PLAYER
mov MEMCPY_LEN, 8
call _memcpy
;Set the score to 0
mov SCORE, 0
sp_plname_end:
nop

sp_start:
;Get a random word from the dict
    ;"Random" number
    mov ah, 0x2C ; Get system time
    int 0x21     ;
    mov ah, 0
    mov al, dh   ; Seconds
    mov bl, cl   ; Minutes
    mul bl
    mov ah, 0
    mov bl, WORD_LIST_LEN
    idiv bl

    ;RAND * WORD_LEN
    mov al, ah
    mov ah, 0
    mov bl, WORD_LEN
    mul bl

    ;Adress of the word
    cmp OPTION_DICT, OPTION_DICT_FR
    je  sp_dict_fr
    mov bx, offset WORD_LIST_EN
    jmp sp_dict_end
    sp_dict_fr:
    mov bx, offset WORD_LIST_FR
    sp_dict_end:
    add bx, ax

mov WORD, bx
call _play

;Check the game status
cmp GAME_STATUS, GAME_STATUS_ABORT ;Abort ?
je  sp_end

cmp GAME_STATUS, GAME_STATUS_WIN ; Win && competition ?
jnz sp_win_end
cmp MODE, MODE_COMPETITION
jnz sp_start

mov ah, 0
mov al, play_lives
cmp OPTION_GIBBET, OPTION_GIBBET_OFF
jnz sp_gibbet_end
add ax, 6 ;bonus
sp_gibbet_end:
add SCORE, ax

sp_win_end:

cmp GAME_STATUS, GAME_STATUS_LOOSE ; Loose && competition ?
jnz sp_start
cmp MODE, MODE_COMPETITION
jnz sp_start

mov NSPS_NAME, offset PLAYER
mov ax, SCORE
mov NSPS_SCORE, ax
call _new_sp_score

call _sp_gameover

sp_end:

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


;Datas
sp_msg_plname db "Please enter your name:$"



;========================================================= _sp_gameover() ====
;; Prints the game over screen

;; Usage:
;; call _sp_gameover


_sp_gameover:

call _draw_ui

mov POS_X, (COLS-gameover_len)/2
mov POS_Y, header_height + 3

mov ah, 0x09
mov dx, offset gameover

sp_gameover_loop:
    call _move_cursor
    int 0x21
    inc POS_Y
    add dx, gameover_len
    cmp POS_Y, gameover_height + header_height + 3
    jne sp_gameover_loop

add POS_Y, 2
mov POS_X, (COLS-sp_go_score_len)/2
call _move_cursor

mov ax, SCORE
mov I2S_INT, ax
call _inttostr

mov MEMCPY_SRC, offset I2S_STR
mov MEMCPY_DEST, offset sp_go_score
add MEMCPY_DEST, 15
mov MEMCPY_LEN, 4
call _memcpy

mov ah, 0x09
mov dx, offset sp_go_score
int 0x21

;wait
mov ah, 0x86
mov cx, 64
int 0x15

ret


;datas
sp_go_score      db "Your score is: 1234$"
sp_go_score_len equ 20


