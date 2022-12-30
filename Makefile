run:
	odin run ./src -out:./game.bin

build:
	odin build ./src -out:./game.bin
	
clean:
	rm game.bin