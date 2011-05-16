#The program name (8 char max)
PROGRAM_NAME = hangman
#The program ext (COM or EXE)
PROGRAM_EXT = com


all: clean program

program:
	./buildenv/build.sh $(PROGRAM_NAME) $(PROGRAM_EXT)

clean:
	rm -f $(PROGRAM_NAME).$(PROGRAM_EXT)
	rm -f $(PROGRAM_NAME).sh

buildenv:
	wget -c "http://download.flogisoft.com/files/various/emu8086/emu8086-buildenv_1.0.tar.gz"
	tar -xzf emu8086-buildenv_1.0.tar.gz
	rm -f emu8086-buildenv_1.0.tar.gz
	cd buildenv/ && ./makeenv.sh
	

