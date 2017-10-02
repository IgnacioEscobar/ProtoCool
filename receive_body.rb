require 'json'
# Inlcudes
includes =%{
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

}
print includes
# Cabecera de la funcion
puts "void* receive(int socket,t_Mensaje* cabecera){"
puts "    void* payload;"

# Recibir header
puts "    t_Mensaje header;"
puts "    recv(socket,&header,sizeof(t_Mensaje),NULL);"

# Switch de packs
puts "    switch(header){"
	
# Nombres de los ficheros que contienen los mensajes
mensajes = Dir.glob("mensajes/*")

mensajes.each do |mensaje|
        # Seleccionar el fichero y parsear JSON
        file = File.read(mensaje)
        hash = JSON.parse(file)

        # Generar casos del switch
        nombre = hash["nombre"]
	puts "        case #{nombre}:"
	puts "        payload = unpack_#{nombre}(socket);"
        puts "        break;"
end
puts "    }" #Fin de switch
puts "    return payload;"
puts "}"
