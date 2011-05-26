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
;; This is the main file of the program, contain the initialisation of the
;; program, the includes, and the _main() function.
;;



;=================================================================== Init ====
name "HANGMAN"  ;Output file name
org  0x100      ;Set location counter to 0x100
jmp _main       ;Jump to _main



;============================================================== Constants ====
COLS equ 80     ;Terminal width
ROWS equ 25     ;Terminal height

COLOR_HEADER equ 00101111b  ;Color of the Header an help area
COLOR_ACTIVE equ 00001111b  ;Color of the Menu/Game/Animation area
COLOR_CURSOR equ 00000010b  ;Color of the menu cursor



;=============================================================== Includes ====
;CODE
include "mainfunc.asm" ;Contains the functions used everywhere in the program.
include "mainmenu.asm" ;Contains the functions of the main menu.
include "playsnd.asm"  ;Contains the function for playing sounds.
include "stscreen.asm" ;Contains the function that print the startup screen.
include "game.asm"     ;Contains the game functions.
include "singlepl.asm" ;Contains the single player mode.

;RESOURCE
include "asciiart.res" ;Contains the ASCII art of the game.
include "sounds.res"   ;Contains the sounds.
include "words.res"    ;Contains the word list for the single player mode.



;================================================================ _main() ====
;; The main function.


_main:

;Set the video mode to 80x25, 16 colors, 8 pages
mov ah, 0x00
mov al, 0x03
int 0x10

;Hide the cursor
mov ah, 0x01
mov ch, 32
int 0x10

;Disable consol blinking and enable intensive colors
mov ax, 0x1003
mov bx, 0
int 0x10

;Let's go !
call _print_startup_screen

mov SOUND, offset SND_START
call _play_sound

call _main_menu

call _clear_screen

;Exit
mov ah, 0x4C
int 0x21


