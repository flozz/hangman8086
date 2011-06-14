set APP_NAME=HANGMAN.com
dosbox -conf -c "ECHO" -c "MOUNT C %cd%" -c "C:" -c "%APP_NAME%" -c "EXIT"
