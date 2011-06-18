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
;; Contains the functions for displaying and managing scores.
;;
;; Index:
;;     _scores  -- Displays the best scores.
;;



SP_SCORE_1N db "FLOZZ   "
SP_SCORE_1S dw 5000

SP_SCORE_2N db "WILBER  "
SP_SCORE_2S dw 1000

SP_SCORE_3N db "THIERRY "
SP_SCORE_3S dw 100


TP_SCORE_1N db "FLOZZ   "
TP_SCORE_1S dw 42

TP_SCORE_2N db "WILBER  "
TP_SCORE_2S dw 20

TP_SCORE_3N db "THIERRY "
TP_SCORE_3S dw 10



;============================================================== _scores() ====
;; Contains the functions for displaying and managing scores.

;; Usage:
;; call _scores


_scores:

;Backup registers
push ax
push bx
push cx
push dx

;Draw the UI
call _draw_ui
mov HELP_STR, offset scores_help
call _print_help

;SINGLE PLAYER
    mov POS_X, 15
    mov POS_Y, header_height + 6
    call _move_cursor

    ;TITLE
    mov ah, 0x09
    mov dx, offset scores_sp_title
    int 0x21

    add POS_Y, 2
    call _move_cursor

    ;ITEM 1
    mov MEMCPY_SRC, offset SP_SCORE_1N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, SP_SCORE_1S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

    inc POS_Y
    call _move_cursor

    ;ITEM 2
    mov MEMCPY_SRC, offset SP_SCORE_2N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, SP_SCORE_2S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

    inc POS_Y
    call _move_cursor

    ;ITEM 3
    mov MEMCPY_SRC, offset SP_SCORE_3N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, SP_SCORE_3S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

;TWO PLAYER
    mov POS_X, COLS - 15 - 19
    mov POS_Y, header_height + 6
    call _move_cursor

    ;TITLE
    mov ah, 0x09
    mov dx, offset scores_tp_title
    int 0x21

    add POS_Y, 2
    call _move_cursor

    ;ITEM 1
    mov MEMCPY_SRC, offset TP_SCORE_1N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, TP_SCORE_1S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

    inc POS_Y
    call _move_cursor

    ;ITEM 2
    mov MEMCPY_SRC, offset TP_SCORE_2N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, TP_SCORE_2S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

    inc POS_Y
    call _move_cursor

    ;ITEM 3
    mov MEMCPY_SRC, offset TP_SCORE_3N
    mov MEMCPY_DEST, offset scores_disp_tpl
    add MEMCPY_DEST, 3
    mov MEMCPY_LEN, 8
    call _memcpy
    ;;
    mov ax, TP_SCORE_3S
    mov I2S_INT, ax
    call _inttostr
    mov MEMCPY_SRC, offset I2S_STR
    add MEMCPY_DEST, 9
    mov MEMCPY_LEN, 4
    call _memcpy

    mov ah, 0x09
    mov dx, offset scores_disp_tpl
    int 0x21

;Wait
mov ax, 0x0000
int 0x16

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


;Datas
scores_help db "Press any key$"

scores_sp_title db "-- SINGLE PLAYER --$"
scores_tp_title db "--- TWO PLAYERS ---$"
scores_disp_tpl db " > <PLAYER> <SC>$"


