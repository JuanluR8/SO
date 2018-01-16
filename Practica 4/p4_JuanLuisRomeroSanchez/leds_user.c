#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

void escribir (int num) {
	
	int fd1 = open("/dev/leds", O_WRONLY);
	
	switch(num) {
	case 0:
		write(fd1, "", 0);
		break;
	case 1:
		write(fd1, "3", 1);
		break;
	case 2:
		write(fd1, "2", 1);
		break;
	case 3:
		write(fd1, "23", 2);
		break;
	case 4:
		write(fd1, "1", 1);
		break;
	case 5:
		write(fd1, "13", 2);
		break;
	case 6:
		write(fd1, "12", 2);
		break;
	case 7:
		write(fd1, "123", 3);
		break;
		
	}
	
	close(fd1);
}
int main(int argc, char *argv[]) {
	
	int num = 0;
	int file = open("/dev/leds", O_WRONLY);	

	write(file, "", 0);
	close(file);
	printf("Numero a convertir Decimal-> Binario: ");
	scanf("%19d", &num);
	

	while (num != -1) {
		
		
		if (num > 7 || num < -1) {
			printf("Solo soy capaz de convertir números entre 0 y 7...\n");
		}
		else{
			escribir (num);
		}			
		
		printf("Numero a convertir Decimal-> Binario (-1 para salir): ");
		scanf("%19d", &num);
		
	}
	
	return 0;
}
