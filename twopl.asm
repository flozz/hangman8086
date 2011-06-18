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
;; Contains the two players mode.
;;
;; Index:
;;     _two_players()            -- Play in two players mode.
;;



;======================================================= _two_players() ====
;; Play in two players mode.

;; Usage:
;; call _two_players


_two_players:

;Backup registers

push ax
push bx
push cx
push dx

;Ask the first player's name

mov IF_MSG, offset tp_msg_fplname
mov IF_MAXLEN, 8
mov IF_EWD, 0
call _input_field
mov MEMCPY_SRC, offset IF_WORD
mov MEMCPY_DEST, offset tp_fplname
mov MEMCPY_LEN, 8
call _memcpy
nop

;Ask the second player's name

mov IF_MSG, offset tp_msg_splname
mov IF_MAXLEN, 8
mov IF_EWD, 0
call _input_field
mov MEMCPY_SRC, offset IF_WORD
mov MEMCPY_DEST, offset tp_splname
mov MEMCPY_LEN, 8
call _memcpy
nop



;Game loop.

mov cx, 3
tp_game_loop:

;Ask the first player's secret word.

mov MEMCPY_SRC, offset tp_fplname
mov MEMCPY_DEST, offset tp_msg_fplword
mov MEMCPY_LEN, 8
call _memcpy
mov IF_MSG, offset tp_msg_fplword
mov IF_MAXLEN, 26
mov IF_EWD, 1
call _input_field
mov MEMCPY_SRC, offset IF_WORD
mov MEMCPY_DEST, offset tp_fplword
mov MEMCPY_LEN, 26
call _memcpy
nop

;Let's play with the second player !

mov WORD, offset tp_fplword
call _play

;Count the second player's lives.

mov ax, 0
mov al, play_lives
add play_sp_lives, al

;Abort game.

cmp GAME_STATUS, GAME_STATUS_ABORT
je tp_end

;Ask the second player's secret word.

mov MEMCPY_SRC, offset tp_splname
mov MEMCPY_DEST, offset tp_msg_splword
mov MEMCPY_LEN, 8
call _memcpy
mov IF_MSG, offset tp_msg_splword
mov IF_MAXLEN, 26
mov IF_EWD, 1
call _input_field
mov MEMCPY_SRC, offset IF_WORD
mov MEMCPY_DEST, offset tp_splword
mov MEMCPY_LEN, 26
call _memcpy
nop

;Let's play with the first player !

mov WORD, offset tp_splword
call _play

;Count the first player's lives.

mov ax, 0
mov al, play_lives
add play_fp_lives, al

;Abort game.

cmp GAME_STATUS, GAME_STATUS_ABORT
je tp_end

;Game loop.

dec cx
cmp cx, 0
jne tp_game_loop

;Put the number of lives of the second player in bx.

mov ax, 0
mov al, play_sp_lives

;Jump to fp_win if the first player win.

call _draw_ui

cmp play_fp_lives, al
jg fp_win

;Display message if second player win.

mov POS_X, (COLS-24)/2
mov POS_Y, header_height + 4
call _move_cursor
mov MEMCPY_SRC, offset tp_splname
mov MEMCPY_DEST, offset tp_msg_win
mov MEMCPY_LEN, 8
call _memcpy
mov ah, 0x09
mov dx, offset tp_msg_win
int 0x21

;wait
mov ah, 0x86
mov cx, 124
int 0x15

jmp tp_end

;Display message if first player win.

fp_win:
mov POS_X, (COLS-24)/2
mov POS_Y, header_height + 4
call _move_cursor
mov MEMCPY_SRC, offset tp_fplname
mov MEMCPY_DEST, offset tp_msg_win
mov MEMCPY_LEN, 8
call _memcpy
mov ah, 0x09
mov dx, offset tp_msg_win
int 0x21

;wait
mov ah, 0x86
mov cx, 124
int 0x15

tp_end:

;Restore registers

pop dx
pop cx
pop bx
pop ax


ret


;Datas

tp_msg_fplname db "Please enter the first player's name:$"
tp_fplname db "--------"
tp_msg_splname db "Please enter the second player's name:$"
tp_splname db "--------"

tp_msg_fplword db "******** enter your secret word:$"
tp_fplword db "-------------------------"
tp_msg_splword db "******** enter your secret word:$"
tp_splword db "-------------------------"

tp_msg_win db "******** is the winner !$"

play_fp_lives db 0
play_sp_lives db 0


