require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

}
print includes
# Cabecera de la funcion
puts "void* pack(t_Mensaje cabecera, void* payload, int* tamanio_paquete){"
puts "void* paquete;"

# Switch de packs
puts "    switch(cabecera){"
	
# Nombres de los ficheros que contienen los mensajes
mensajes = Dir.glob("mensajes/*")

mensajes.each do |mensaje|
        # Seleccionar el fichero y parsear JSON
        file = File.read(mensaje)
        hash = JSON.parse(file)

        # Generar casos del switch
        nombre = hash["nombre"]
	puts "        case: #{nombre}:"
	puts "        paquete =  pack_#{nombre}(payload,tamanio_paquete);"
        puts "        break;"
end
puts "    }" #Fin de switch
puts "return paquete;"
puts "}"
