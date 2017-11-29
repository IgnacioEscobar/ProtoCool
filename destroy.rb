require 'json'
# Inlcudes
includes =%{
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "types.h"
#include "packers.h"
#include "enviar_paquete.h"
#include "destroy.h"

}
print includes

# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

# Cabecera de la funcion
puts "void destroy(HEADER_T header,void* payload){"
puts "	switch(header) {"
#Por cada mensaje creamos una funcion de destruccion
mensajes.each do |mensaje|
	nombre = mensaje["nombre"]
    	campos = mensaje["campos"]

    	puts "		case #{nombre}:"
	puts "			destroy_#{nombre}((payload_#{nombre}*) payload);"
	puts "		break;"

end
	puts "	}"
	puts "}\n\n"