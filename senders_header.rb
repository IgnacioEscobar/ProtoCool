require 'json'
# Wrapper
wrapper =%{
#ifndef UTILIDADES_PROTOCOL_SENDERS_H_
#define UTILIDADES_PROTOCOL_SENDERS_H_
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

        if mensaje["custom"] != true	
		# Obtener los datos
		nombre = mensaje["nombre"]
		campos = mensaje["campos"]

		# Cabecera de la funcion
		print "void send_#{nombre}(int socket "
		# Loop para decidir que campos se pasan al sender
		campos.each do |campo|
			tipo = campo[0]
			nombreCampo = campo[1]
			unless nombreCampo[0 .. 7] == "tamanio_" # Se toman como parametros todos aquellos que no sean de tamaño
				print " , "																
				print "#{tipo} #{nombreCampo}"
			end
		end
		print ");\n"
	else
		print "#{mensaje["send_proto"]};\n"
	end

end

# Wrapper
wrapper =%{
#endif /* UTILIDADES_PROTOCOL_SENDER_H_ */
}
print wrapper
