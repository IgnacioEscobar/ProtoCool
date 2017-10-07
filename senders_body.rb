require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "types.h"
#include "packers.h"
#include "enviar_paquete.h"

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
	print "void send_#{nombre}(int socket"
	# Loop para decidir que campos se pasan al sender
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		unless nombreCampo[0 .. 7] == "tamanio_" # Se toman como parametros todos aquellos que no sean de tamaño
			print " , "
			print "#{tipo} #{nombreCampo}"
		end
	end
	print "){\n"

	# Cargar payload
	puts "    payload_#{nombre} payload;" 	
	# Ciclo de carga
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		if nombreCampo[0 .. 7] == "tamanio_"
			print "    payload.#{nombreCampo} "
			nombreCampo.slice! "tamanio_"
			print "= (strlen(#{nombreCampo})+1)*sizeof(char);\n"
		else
			puts "    payload.#{nombreCampo} = #{nombreCampo}; "
		end	
	end
	puts "\n" 
	# Empaquetar payload
	puts "    int tamanio_paquete;"
	puts "    char* paquete = pack_#{nombre}(payload,&tamanio_paquete);"
	puts "    enviar_paquete(socket,paquete,tamanio_paquete);"
	puts "    free(paquete);"
	# Fin de la definicion de la funcion
	puts "};\n\n" 

end


