#!/bin/bash
if test -e mytar -a -x mytar; then
	echo "El archivo mytar existe y es ejecutable."

	if test -e tmp; then
		echo "Directorio tmp encontrado. Borrando..."
		rm -r tmp
	fi
	
	echo "Creando un nuevo directorio tmp..."
	mkdir tmp
	cd ./tmp
	
	echo""
	echo "Creando archivo 1 (file1.txt)..."
	echo "Hello World!" > file1.txt
	echo "Creando archivo 2 (file2.txt)..."
	head -n 10 /etc/passwd > file2.txt
	echo "Creando archivo 3 (file3.dat)..."
	head -c 1024 /dev/random > file3.dat
	echo""

	echo "Comprimiendo archivos en filetar.mtar..."
	./../mytar -c -f filetar.mtar file1.txt file2.txt file3.dat
	echo""
	
	echo "Creando directorio ./out..."
	mkdir out
	echo "Copiando filetar.mtar a ./out..."
	cp filetar.mtar ./out/
	cd ./out

	echo "Extrayendo el contenido de filetar.mtar en ./out..."
	./../../mytar -x -f filetar.mtar
	
	cd ..

	echo "Comprobando las diferencias entre file1.txt original y el file1.txt descomprimido..."
	DIFF=$(diff a.txt ./out/a.txt) 
	if [ "$DIFF" != "" ] 
	then
		echo diff -q file1.txt ./out/file1.txt
		exit 1
	else
		echo "LOS ARCHIVOS SON IGUALES!"
		echo "Comprobando las diferencias entre file2.txt original y el file2.txt descomprimido..."
	  	DIFF=$(diff b.txt ./out/b.txt) 
		if [ "$DIFF" != "" ]
		then
		    echo diff -q file2.txt ./out/file2.txt
		    exit 1
		else	
			echo "LOS ARCHIVOS SON IGUALES!"
			echo "Comprobando las diferencias entre file3.dat original y el file3.dat descomprimido..."
			DIFF=$(diff c.txt ./out/c.txt) 
			if [ "$DIFF" != "" ] 
			then
				echo diff -q file3.dat ./out/file3.dat
				exit 1
			else
				echo "LOS ARCHIVOS SON IGUALES!"
				cd ../..
				echo ""
				echo "CORRECTO!!"
				exit 0
			fi
		fi
	fi		
else
	echo "El archivo mytar no existe."
	exit 1
fi
	
