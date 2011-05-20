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
;; Contains the ascii art of the game.
;;



;============================================================ Header Logo ====
header db " __   __  _______  __    _  _______  __   __  _______  __    _ $"
       db "|  | |  ||   _   ||  |  | ||       ||  |_|  ||   _   ||  |  | |$"
       db "|  |_|  ||  |_|  ||   |_| ||    ___||       ||  |_|  ||   |_| |$"
       db "|       ||       ||       ||   | __ |       ||       ||       |$"
       db "|       ||       ||  _    ||   ||  ||       ||       ||  _    |$"
       db "|   _   ||   _   || | |   ||   |_| || ||_|| ||   _   || | |   |$"
       db "|__| |__||__| |__||_|  |__||_______||_|   |_||__| |__||_|  |__|$"

header_len    equ 64
header_height equ  7



;========================================================= Startup Screen ====
startup_scr db "  ____  _____ ____ _____ _____    _    __  __  $"
            db " | __ )| ____/ ___|_   _| ____|  / \  |  \/  | $"
            db " |  _ \|  _| \___ \ | | |  _|   / _ \ | |\/| | $"
            db " | |_) | |___ ___) || | | |___ / ___ \| |  | | $"
            db " |____/|_____|____/ |_| |_____/_/   \_\_|  |_| $"
            db "                                               $"
            db "                 - Presents -                  $"
            db "                                               $"
            db "                                               $"
            db "                                               $"
            db "                                               $"
            db "                                               $"
            db "                                               $"
            db "    Copyright (C) 2011  Fabien LOISON          $"
            db "    Copyright (C) 2011  Mathilde BOUTIGNY      $"
            db "    Copyright (C) 2011  Vincent PEYROUSE       $"
            db "    Copyright (C) 2011  Germain CARRE          $"
            db "    Copyright (C) 2011  Matthis FRENAY         $"

startup_scr_len    equ 48
startup_scr_height equ 18


