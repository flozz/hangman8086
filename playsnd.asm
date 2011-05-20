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
;; Contains the function for playing sounds.
;;
;; Index:
;;     _play_sound() -- Play a sound.
;;



;========================================================== _play_sound() ====
;; Play a sound.

;; Usage:
;; mov SOUND, offset <mysound>
;; call _play_sound

;; Function arg:
SOUND dw 0 ;The adress of the sound to play.


_play_sound:

;Backup registers
push ax
push bx
push cx
push dx

;Turn speaker on
mov  dx, 0x61
in   al, dx
or   al, 0x03
out  dx, al

;Sound loop
mov bx, SOUND
mov dx, 0

sound_loop:
    ;Play sound
    mov ax, [bx]
    or  ax, 3
    out 0x42, al ;output low
    xchg ah, al
    out 0x42, al ;output high

    ;Point to the next field (duration)
    inc bx
    inc bx

    ;Sleep during the given duration
    push ax
    mov cx, [bx]
    mov ah, 0x86
    int 0x15
    pop ax

    ;Point to the next field (sound)
    inc bx
    inc bx

    ;Check if it is finished or not
    cmp [bx], 0
    jne sound_loop

;Turn speaker off
mov  dx, 0x61
in   al, dx
and  al, 0xfc
out  dx, al

;Restore registers
pop dx
pop cx
pop bx
pop ax

ret


