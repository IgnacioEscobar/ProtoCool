require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include "types.h"

}
print includes

# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

#Por cada mensaje creamos una funcion de empaquetado
mensajes.each do |mensaje|
	nombre = mensaje["nombre"]
	campos = mensaje["campos"]
	if mensaje["campos"].length !=0	
		if mensaje["custom"] != true

			# Cabecera de la funcion
			puts "void* unpack_#{nombre}(int socket){"
			puts "    payload_#{nombre} *payload= malloc(sizeof(payload_#{nombre}));"
			print "\n"
			# Cargar la struct del payload	
			campos.each do |campo|
				tipo = campo[0]
				nombreCampo = campo[1]
				if tipo[-1] != "*" # CASO 0: Guardar en el stack
					puts "    recv(socket,&(payload->#{nombreCampo}),sizeof(#{tipo}),0);"
					if nombreCampo[0 .. 7] == "tamanio_" # Si ademas es un campo centinela de serializacion
						puts "    #{tipo}  #{nombreCampo} = payload->#{nombreCampo};" # Me lo guardo
					end
				else               # CASO 1: Guardar en el heap
					puts "    char* #{nombreCampo} = malloc(tamanio_#{nombreCampo});" # Alocar memoria
					puts "    recv(socket,#{nombreCampo},tamanio_#{nombreCampo},0);"  # Recibir campo
					puts "    payload->#{nombreCampo} = #{nombreCampo};"            # Asignarlo a la payload
				end
				print "\n"
			end	
			# Indireccion, casteo y retorno de la payload
			puts "    return (void*)payload;"
			puts "};\n\n" 
		else
			File.open("customs/unpack_#{nombre}.c").each do |linea|
				puts linea
			end
		end
	end
end


