require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "unpackers.h"

}
print includes
# Cabecera de la funcion
puts "void* receive(int socket,HEADER_T* cabecera){"
puts "    void* payload;"

# Recibir header
puts "    HEADER_T header;"
puts "    int status = recv(socket,&header,sizeof(HEADER_T),0);"
puts "    if(!status){"
puts "         (*cabecera) = FIN_COMUNICACION;"
puts "         return NULL;"
puts "    }"

# Switch de packs
puts "    switch(header){"
	
# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

#Por cada mensaje creamos un caso
mensajes.each do |mensaje|

        # Generar casos del switch
       nombre = mensaje["nombre"]
	puts "        case #{nombre}:"
	if mensaje["campos"].length != 0
		puts "        payload = unpack_#{nombre}(socket);"
	else
		puts "        /* Carece de Payload */"
	end
        puts "        break;"
end
puts "    }" #Fin de switch
puts "    (*cabecera) = header;"
puts "    return payload;"
puts "}"
