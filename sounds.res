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
;; Contains the sounds.
;;



;========================================================== Startup music ====
;              Sound, duration
SND_START   dw     4049,  1
            dw    40000,  1
            dw     3033,  1
            dw    40000,  4
            dw     2702,  5
            dw    40000,  1
            dw     2407,  2
            dw    40000,  2
            dw     3033,  2
            dw    40000,  3
            dw     4049,  3
            dw    40000,  2
            dw     4049,  1
            dw    40000,  3
            dw     3405,  3
            dw    40000,  3
            dw     3607,  2
            dw    40000,  3
            dw     4049,  4
            dw    40000,  5
            dw     3405,  2
            dw    40000,  2
            dw     3405,  1
            dw    40000,  1
            dw     2551,  2
            dw    40000,  1
            dw     3405,  1
            dw    40000,  1
            dw     2551,  4
            dw    40000,  4
            dw     2272,  6
            dw    40000,  2
            dw     3405,  2
            dw    40000,  2
            dw     3405,  2
            dw    40000,  2
            dw     3405,  2
            dw    40000,  1
            dw     3033,  6
            dw        0,  0


;================================================================== Menus ====
;                     Sound, duration
SND_MENU_CH_ITEM dw    4000, 01
                 dw       0,  0


;                   Sound, duration
SND_MENU_VALID dw    2000, 01
               dw    0800, 02
               dw       0,  0



;=================================================================== Game ====
;                       Sound, duration
SND_GAME_GOOD_LTTR dw    4000, 01
                   dw    2000, 01
                   dw    1000, 01
                   dw       0,  0


;                      Sound, duration
SND_GAME_BAD_LTTR dw    9000, 01
                  dw       0,  0


;                 Sound, duration
SND_GAME_DIE dw    7000, 02
             dw    8000, 02
             dw    9000, 02
             dw    9999, 08
             dw       0,  0


;                 Sound, duration
SND_GAME_GG dw     3000, 02
            dw     2500, 02
            dw     2000, 02
            dw    20000, 01
            dw     2500, 02
            dw     2000, 02
            dw     1500, 02
            dw    20000, 01
            dw     2000, 02
            dw     1500, 02
            dw     1000, 03
            dw        0,  0


