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
;;                             tried (e.g. AUIOW).
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

;TODO
;call _draw_ui
;call _game_init
;...
;Set game status

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

;TODO
;Put the WORD in play_word
;Put the length of WORD in play_word_len
;Put the first letter, the last letter and underscores in play_gword
;Fill play_tried_letters with spaces
;Init the play_lives to 10 (with gibbet) or 6 (without gibbet)

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

;TODO

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

;TODO

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret



;================================================= _print_tried_letters() ====
;; Print the letters that the player have already tried (e.g. AUIOW).

;; Usage:
;; call _print_tried_letters


_print_tried_letters:

;Backup registers
push ax
push bx
push cx
push dx

;TODO

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


