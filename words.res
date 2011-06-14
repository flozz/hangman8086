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
; All fields must have a length of 25 bytes, the end of a word is marked by
; the '$' char.
WORD_LIST_EN  db  "ENGLISH$                 "
              db  "INDENTATION$             "
              db  "ASSEMBLY$                "
              db  "COMPUTER$                "
              db  "ADVERTISEMENT$           "
              db  "ORGANIZATION$            "
              db  "TRANSPORT$               "
              db  "TOMORROW$                "
              db  "SUGGESTION$              "
              db  "SELECTION$               "
              db  "NYMPHOMANIAC$            "
              db  "SECRETARY$               "
              db  "PLEASURE$                "
              db  "PUNISHMENT$              "
              db  "QUESTION$                "
              db  "REPRESENTATIVE$          "
              db  "RESPONSIBLE$             "
              db  "DISTRIBUTION$            "
              db  "DIVISION$                "
              db  "DEVELOPMENT$             "
              db  "DESTRUCTION$             "
              db  "EDUCATION$               "
              db  "EXPERIENCE$              "
              db  "GOVERNMENT$              "
              db  "IMPORTANT$               "
              db  "LEARNING$                "
              db  "OBSERVATION$             "
              db  "MUSHROOM$                "
              db  "APPARATUS$               "
              db  "COMPARISON$              "
              db  "COMPETITION$             "
              db  "YESTERDAY$               "
              db  "ABBREVIATIONS$           "
              db  "ABERRATIONS$             "
              db  "ABNORMALITIES$           "
              db  "PERSONIFICATIONS$        "
              db  "PERSUASIVENESS$          "
              db  "LEFTHANDEDNESS$          "
              db  "HISTORIOGRAPHICAL$       "
              db  "DISASSOCIATION$          "
              db  "DISPROPORTIONATELY$      "
              db  "GRAVITATIONALLY$         "
              db  "GREATGRANDCHILDREN$      "
              db  "GROTESQUENESS$           "
              db  "UNCONSTITUTIONALLY$      "
              db  "UNCOMPROMISINGLY$        "
              db  "WRONGDOINGS$             "
              db  "TYPOGRAPHICALLY$         "
              db  "THUNDERFLASHES$          "
              db  "THREEDIMENSIONAL$        "
              db  "THOUGHTPROVOKING$        "
              db  "THERMOSTATICALLY$        "
              db  "THERAPEUTICALLY$         "
              db  "MICROPROCESSORS$         "
              db  "TERRORSTRICKEN$          "
              db  "MICROHYDRODYNAMICS$      "
              db  "BUCKMINSTERFULLERENE$    "
              db  "MICRODENSITOMETER$       "
              db  "BRUTALISATION$           "
              db  "BROTHERSINLAW$           "
              db  "BROADMINDEDNESS$         "
              db  "SCAREMONGERING$          "
              db  "SCHIZOPHRENICALLY$       "
              db  "LEXICOGRAPHICALLY$       "
              db  "INTROSPECTIVELY$         "
              db  "ALAEONTOLOGISTS$         "
              db  "PARALLELEPIPED$          "
              db  "PARAPSYCHOLOGIST$        "
              db  "PROCRASTINATIONS$        "
              db  "VENTRILOQUISTS$          "
              db  "VIDEOCONFERENCING$       "
              db  "WAREHOUSEMEN$            "
              db  "WARMBLOODED$             "
              db  "DEFORESTATION$           "
              db  "DEFRAGMENTATION$         "
              db  "EMPLOYABILITY$           "
              db  "HORIZONTALLY$            "
              db  "HORTICULTURISTS$         "
              db  "LOOKINGGLASSES$          "
              db  "MISINTERPRETATIONS$      "
              db  "NUTRITIONISTS$           "
              db  "OBJECTIONABLE$           "
              db  "OBNOXIOUSNESS$           "
              db  "PARALINGUISTIC$          "
              db  "QUANTIFICATION$          "
              db  "QUARTERSTAFFS$           "
              db  "REHABILITATION$          "
              db  "SECRETARYSHIP$           "
              db  "ELECTROCARDIOGRAPHIC$    "
              db  "ELECTROENCEPHALOGRAM$    "
              db  "FAVOURITISM$             "
              db  "HEARTBREAKING$           "
              db  "HELIOCENTRIC$            "
              db  "JEOPARDISING$            "
              db  "KINETICALLY$             "
              db  "KIDNAPPINGS$             "
              db  "KEYSTROKES$              "
              db  "SCHOOLMASTERS$           "
              db  "AGGLOMERATIONS$          "
              db  "AGROCHEMICALS$           "


WORD_LIST_FR  db  "CACHETTERAIENT$          "
              db  "ECLAIRAGISTES$           "
              db  "QUADRILLERAIENT$         "
              db  "INTUSSUSCEPTION$         "
              db  "NATIONALISATIONS$        "
              db  "ACCEPTATIONS$            "
              db  "ABSTRAYAIENT$            "
              db  "DEBARBOUILLERIONS$       "
              db  "CHLOROPHYLLIENNES$       "
              db  "ELECTROMAGNETIQUES$      "
              db  "URBANISERAIENT$          "
              db  "POLTRONNERIES$           "
              db  "ROUSPETEUSES$            "
              db  "ECLABOUSSERIONS$         "
              db  "LYMPHATIQUES$            "
              db  "YOUGOSLAVES$             "
              db  "FABRIQUERAIENT$          "
              db  "NEUROLINGUISTIQUE$       "
              db  "GOUVERNEMENTALISME$      "
              db  "BYZANTINOLOGUE$          "
              db  "FREQUENTATIONS$          "
              db  "FRACTURASSIEZ$           "
              db  "CLOISONNEMENTS$          "
              db  "GALVANISERAIENT$         "
              db  "CHOCOLATIERES$           "
              db  "ELUCUBRATIONS$           "
              db  "KERATINISASSIONS$        "
              db  "COADMINISTRATRICES$      "
              db  "PAILLASSONNASSIONS$      "
              db  "ULTRAMONTANISME$         "
              db  "OBSTRUCTIONNISTES$       "
              db  "IGNOMINIEUSEMENT$        "
              db  "NAPOLITAINES$            "
              db  "JORDANIENNES$            "
              db  "DUBITATIVEMENT$          "
              db  "FRUCTIFIERAIENT$         "
              db  "INCURVERAIENT$           "
              db  "QUANTIFICATIONS$         "
              db  "BONIFICATIONS$           "
              db  "CLIGNOTEMENT$            "
              db  "SACRAMENTELLES$          "
              db  "ZIGZAGUERIONS$           "
              db  "KINESITHERAPEUTES$       "
              db  "TAMBOURINAMES$           "
              db  "BEUVERIES$               "
              db  "NUTRITIONNISTE$          "
              db  "NASONNEMENT$             "
              db  "UNIDIRECTIONNELLES$      "
              db  "BOUILLOTTERAIENT$        "
              db  "SACCHARIFICATION$        "
              db  "EMANCIPATEURS$           "
              db  "JUSTIFIERIONS$           "
              db  "DYSORTHOGRAPHIES$        "
              db  "CYTOPLASMIQUE$           "
              db  "RACCOUTUMERAIENT$        "
              db  "AROMATISATIONS$          "
              db  "TYROLIENNES$             "
              db  "VADROUILLIONS$           "
              db  "DEBLOQUERAIENT$          "
              db  "DRAMATISATIONS$          "
              db  "BRINGUEBALAIENT$         "
              db  "OBLIGATOIREMENT$         "
              db  "ECARQUILLASSIONS$        "
              db  "WURTEMBERGEOISE$         "
              db  "MERINGUASSIONS$          "
              db  "MOTORISATIONS$           "
              db  "GUILLOTINERENT$          "
              db  "BIJOUTERIES$             "
              db  "ZOOTHERAPEUTIQUE$        "
              db  "MERCURIELLES$            "
              db  "MOUCHARDASSENT$          "
              db  "TACHISTOSCOPIQUE$        "
              db  "VAPORISATIONS$           "
              db  "RUISSELLEMENTS$          "
              db  "KILOGRAMMES$             "
              db  "AFFRANCHISSIONS$         "
              db  "GALACTIQUES$             "
              db  "BACTERIOLOGISTES$        "
              db  "HARCELERAIENT$           "
              db  "BIBERONNASSIONS$         "
              db  "ACCLIMATAIENT$           "
              db  "XIPHOIDIENNES$           "
              db  "HACHURERIONS$            "
              db  "LORGNETTES$              "
              db  "JALOUSASSIONS$           "
              db  "HYPOSECRETION$           "
              db  "CHAUMASSIONS$            "
              db  "FLANCONADE$              "
              db  "OCCASIONNELLEMENT$       "
              db  "BADIGEONNASSIONS$        "
              db  "ADMINISTRASSIONS$        "
              db  "PALMIPEDES$              "
              db  "MACHINATIONS$            "
              db  "LABORIEUSEMENT$          "
              db  "WISIGOTHIQUES$           "
              db  "SABOULASSENT$            "
              db  "HALLUCINOGENES$          "
              db  "SPECTROSCOPISTES$        "
              db  "DECUVERAIENT$            "
              db  "EBAUDISSENT$             "


WORD_LEN      equ  25 ;The length of every fields
WORD_LIST_LEN equ 100 ;The number of words in the list


