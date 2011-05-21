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
;; Contains the word list for the single player mode.
;;



;============================================================== Word List ====
; All fields must have a length of 30 bytes, the end of a word is marked by
; the '$' char.
WORD_LIST     db  "ENGLISH$                      "
              db  "INDENTATION$                  "
              db  "ASSEMBLY$                     "
              db  "COMPUTER$                     "

WORD_LEN      equ 30 ;The length of every fields
WORD_LIST_LEN equ  4 ;The number of words in the list


