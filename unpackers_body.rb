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
	puts "void* unpack_#{nombre}(int socket){"
	puts "    payload_#{nombre} payload;"
	# Cargar la struct del payload	
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		if tipo[-1] != "*"
			puts "    recv(socket,&(payload.#{nombreCampo}),sizeof(#{tipo}),NULL);"
			if nombreCampo[0 .. 7] == "tamanio_"
				puts "    int #{nombreCampo} = payload.#{nombreCampo}"
			end
		else
			puts "    recv(socket,&(payload.#{nombreCampo}),tamanio_#{nombreCampo},NULL);"
		end
	end	
	# Indireccion, casteo y retorno de la payload
	puts "    void * retorno = (void*)(&payload);"
	puts "    return retorno;"
	puts "};\n\n" 

end


