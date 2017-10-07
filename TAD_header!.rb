require 'json'
# Wrapper
wrapper =%{
#ifndef UTILIDADES_PROTOCOL_TYPES_H_
#define UTILIDADES_PROTOCOL_TYPES_H_
}
print wrapper

# Includes
includes =%{
#include <stdint.h>

}
print includes
# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

# Definicion del tipo de datos de la cabecera
print "typedef enum {"
mensajes.each do |mensaje|

	# Obtener los datos
	nombre = mensaje["nombre"]
	print "#{nombre}"
	unless mensajes[-1] == mensaje
		print ", "
	end	
end
puts "}HEADER_T;\n\n"


# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

#Por cada mensaje creamos una funcion de empaquetado
mensajes.each do |mensaje|

	# Obtener los datos
	nombre = mensaje["nombre"]
	campos = mensaje["campos"]
	# Cabecera del struct
	puts "typedef struct { \n"

	# Loop que crea los campos del struct
	campos.each do |campo|
		tipo        =  campo.first
		nombreCampo =  campo.last
		puts "    #{tipo} #{nombreCampo}; \n"
	end

	# Fin de la definicion del struct
	puts "}payload_#{nombre};\n\n" 
end

# Wrapper
wrapper =%{
#endif /* UTILIDADES_PROTOCOL_TYPES_H_ */
}
print wrapper


