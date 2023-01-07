run:
	odin run ./src -out:./game.bin -collection:lib=./lib

build:
	odin build ./src -out:./game.bin
	
clean:
	rm game.bin