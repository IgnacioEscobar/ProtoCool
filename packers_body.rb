require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "types.h"

}
print includes

# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

#Por cada mensaje creamos una funcion de empaquetado
mensajes.each do |mensaje|

	
	# Obtener los datos
	nombre = mensaje["nombre"]
	campos = mensaje["campos"]

	# Cabecera de la funcion
	puts "char* pack_#{nombre}(payload_#{nombre} payload,int* tamanio_paquete){"

	# Reservar memoria
	print "    int tamanio_total = sizeof(HEADER_T)" # Iniciamos la adicion con el tamaño del header
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		print " + "
		if tipo[-1] != "*" # Si el ultimo caracter no es '*', entonces el campo esta en el stack 
			print "sizeof(#{tipo})" # Por lo tanto reservamos el tamaño del tipo
		else # Caso contrario, esta en el heap
			print"(payload.tamanio_#{nombreCampo})"# En este caso el tamanio viene cargado en la payload 
		end
	end
	puts ";"
	print "    char* paquete = malloc(tamanio_total);\n\n"
	# Copiar memoria
	puts "    int offset = 0;"
	puts "    int tamanio_envio;"
	# Inicial el paquete con la cabecera
	puts  "    HEADER_T cabecera = #{nombre};"
	puts  "    tamanio_envio = (sizeof(HEADER_T));" 
	puts  "    memcpy(paquete+offset,&cabecera,tamanio_envio);"
	print "    offset += tamanio_envio;\n\n"
	
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		if tipo[-1] != "*"  
			puts  "    tamanio_envio = sizeof(#{tipo});" 
			puts  "    memcpy(paquete+offset,&(payload.#{nombreCampo}),tamanio_envio);"	
			print "    offset += tamanio_envio;\n\n"
		else 
			puts  "    tamanio_envio = (payload.tamanio_#{nombreCampo});" 
			puts  "    memcpy(paquete+offset,payload.#{nombreCampo},tamanio_envio);"
			print "    offset += tamanio_envio;\n\n"
		end
	end	
	# Fin de la definicion de la funcion
	puts "    (* tamanio_paquete) = tamanio_total;"
	puts "    return paquete;"
	puts "};\n\n" 

end
