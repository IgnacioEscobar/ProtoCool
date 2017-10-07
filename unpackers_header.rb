require 'json'
# Wrapper
wrapper =%{
#ifndef UTILIDADES_PROTOCOL_UNPACKERS_H_
#define UTILIDADES_PROTOCOL_UNPACKERS_H_
}
print wrapper

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
	puts "void* unpack_#{nombre}(int socket);"
end

# Wrapper
wrapper =%{
#endif /* UTILIDADES_PROTOCOL_UNPACKERS_H_ */
}
print wrapper


