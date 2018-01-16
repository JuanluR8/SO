#!/bin/bash

# Variable para los do-while
varTrue=0

# Bucle que no acaba hasta que se introduce un archivo valido
while [ $varTrue != 1 ]; do

	# Preguntamos al usuario cual es el archivo a ejecutar
	echo "Introduce el SOLO nombre del archivo a ejecutar: "
	read archivo

	# Comprobamos que el fichero existe y que es un fichero regular (con -f)
	if test -f ./examples/$archivo ; then
		# Desactivamos el bucle
		varTrue=1
	else	
		echo "- ERROR: El fichero no existe o no se puede leer"
	fi
done

# Reseteamos el valor de la variable que reutilizamos para el 2º do-while
varTrue=0

# Bucle que no acaba hasta que se introduce un numero de CPUs valido (entre 1 y 8)
while [ $varTrue != 1 ]; do

	# Preguntamos al usuario cuantas CPUs 
	echo "Introduce el numero de CPUs: "
	read cpus
	
	# Comprobamos que el numero es valido
	if [ $cpus -gt 0 ] &&  [ $cpus -lt 9 ] ; then
		# Desactivamos el bucle
		varTrue=1
	else	
		echo "- ERROR: El numero de CPUs indicadas es incorrecto"
		echo "El numero debe ser mayor o igual a 1 y menor o igual a 8"
	fi
done

# Comprobamos si existe el directorio "resultados". Si existe lo borramos. Creamos uno nuevo
if test -d ./resultados ; then
	rm -r resultados
	echo "Carpeta 'resultados' eliminada"
else
	echo "No se ha encontrado la carpeta 'resultados'"
fi

echo "Creando carpeta 'resultados'..."
mkdir ./resultados
echo "Hecho"

# Ejecutamos cada uno de los modos y generamos las graficas. Todo se almacena en la carpeta 'resultados'
for nameSched in "RR" "SJF" "FCFS" "PRIO"; do
     for ((i=0; i<cpus; i++)) do
         ./schedsim -i examples/$archivo -n $cpus -s $nameSched
         for ((j=0; j<cpus; j++)) do
                 mv CPU_$j.log resultados/$nameSched-CPU_$j.log
         done

	 # Nos movemos a la carpeta para generar la grafica
         cd ./../gantt-gplot/
	 # Creamos graficas
	 ./generate_gantt_chart ../schedsim/resultados/$nameSched-CPU_$i.log

	 # Volvemos a la carpeta
	 cd ../schedsim
     done
done
