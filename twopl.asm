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

;Ask the first player's secret word

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

;Let's play !

mov WORD, offset tp_fplword
call _play

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


