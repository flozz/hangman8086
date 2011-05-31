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
;;     _single_player()            -- Play in single player mode.
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
cmp GAME_STATUS, GAME_STATUS_ABORT
je  sp_end
jmp sp_start

sp_end:

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


