require 'json'
# Includes
includes =%{
#include <stdint.h>

}
print includes
# Nombres de los ficheros que contienen los mensajes
mensajes = Dir.glob("mensajes/*") 

# Definicion del tipo de datos de la cabecera
print "typedef enum{"
mensajes.each do |mensaje|
	# Seleccionar el fichero y parsear JSON
	file = File.read(mensaje)
	hash = JSON.parse(file)
	
	# Obtener los datos
	nombre = hash["nombre"]
	print "#{nombre}"
	unless mensajes[-1] == mensaje
		print ", "
	end	
end
puts "}t_Mensaje;\n\n"

# Por cada fichero en la carpeta mensajes creamos un struct
mensajes.each do |mensaje|

	# Seleccionar el fichero y parsear JSON
	file = File.read(mensaje)
	hash = JSON.parse(file)
	
	# Obtener los datos
	nombre = hash["nombre"]
	campos = hash["campos"]

	# Cabecera del struct
	puts "typedef struct { \n"

	# Loop que crea los campos del struct
	campos.each do |campo|
		tipo        =  campo[0]
		nombreCampo =  campo[1]
		puts "    #{tipo} #{nombreCampo}; \n"
	end

	# Fin de la definicion del struct
	puts "}payload_#{nombre};\n\n" 

end


