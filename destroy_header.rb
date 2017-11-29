require 'json'
# Wrapper
wrapper =%{
#ifndef UTILIDADES_PROTOCOL_DESTROY_H_
#define UTILIDADES_PROTOCOL_DESTROY_H_
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

puts "// Destroyer generico"
puts "void destroy(HEADER_T header,void* payload);"

puts "\n\n// Destroyers particulares"

# Por cada destroyer escribo el prototipo
mensajes.each do |mensaje|

	# Obtener los datos
	nombre = mensaje["nombre"]
	campos = mensaje["campos"]

	puts "void destroy_#{nombre}(payload_#{nombre}* payload);"

end

# Wrapper
wrapper =%{
#endif /* UTILIDADES_PROTOCOL_DESTROY_H_ */
}
print wrapper