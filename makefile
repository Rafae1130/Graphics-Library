
all: agra
	qemu-arm -L /usr/arm-linux-gnueabi agra 40 20 >> output.txt

agra: agra_main.o agra.s framebuffer.o
	arm-linux-gnueabi-gcc -g -mcpu=xscale -o0  -o agra  agra_main.o agra.s framebuffer.o
agra_main.o:
	arm-linux-gnueabi-gcc -g -mcpu=xscale -o0  -o agra_main.o  -c agra_main.c
framebuffer.o:
	arm-linux-gnueabi-gcc -g -mcpu=xscale -o0  -o framebuffer.o  -c framebuffer.c


clean:
	rm *.o
	rm output.txt
