require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

}
print includes
# Nombres de los ficheros que contienen los mensajes
mensajes = Dir.glob("mensajes/*") 

#Por cada fichero en la carpeta mensajes creamos una funcion de empaquetado
mensajes.each do |mensaje|
	# Seleccionar el fichero y parsear JSON
	file = File.read(mensaje)
	hash = JSON.parse(file)
	
	# Obtener los datos
	nombre = hash["nombre"]
	campos = hash["campos"]

	# Cabecera de la funcion
	puts "void* pack_#{nombre}(payload_#{nombre} payload,int* tamanio_paquete){"

	# Reservar memoria
	print "    int tamanio_total = sizeof(t_Mensaje) + " # Iniciamos la adicion con el tamaño del header
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		if tipo[-1] != "*" # Si el ultimo caracter no es '*', entonces el campo esta en el stack 
			print "sizeof(#{tipo})" # Por lo tanto reservamos el tamaño del tipo
		else # Caso contrario, esta en el heap
			print"(payload.tamanio_#{nombreCampo})"# En este caso el tamanio viene cargado en la payload 
		end
		unless campos[-1]==campo #A no ser que estemos en la ultima posicion
			print " + " # Vamos sumando
		end
	end
	puts ";"
	print "    void* paquete = malloc(tamanio_total);\n\n"
	# Copiar memoria
	puts "    int offset = 0;"
	puts "    int tamanio_envio;"
	# Inicial el paquete con la cabecera
	puts  "    t_Mensaje cabecera = #{nombre};"
	puts  "    tamanio_envio = (sizeof(t_Mensaje));" 
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
			puts  "    memcpy(paquete+offset,payloadCasteado.#{nombreCampo},tamanio_envio);"
			print "    offset += tamanio_envio;\n\n"
		end
	end	
	# Fin de la definicion de la funcion
	puts "    (* tamanio_paquete) = tamanio_total;"
	puts "    return paquete;"
	puts "};\n\n" 

end


