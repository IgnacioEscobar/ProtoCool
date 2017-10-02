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
	print "void send_#{nombre}("
	# Loop para decidir que campos se pasan al sender
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		unless nombreCampo[0 .. 7] == "tamanio_" # Se toman como parametros todos aquellos que no sean de tamaño
			print "#{tipo} #{nombreCampo}"
			unless campos[-1] == campo # A no ser que sea el ulitmo, le ponemos una coma
				print ", "
			end
		end
	end
	print "){\n"

	# Cargar payload
	puts "    payload_#{nombre} payload;" 	
	# Ciclo de carga
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		if nombreCampo[0 .. 7] != "tamanio_"
			puts "    payload.#{nombreCampo} = #{nombreCampo}; "
		else
			puts "    payload.#{nombreCampo} = (strlen(#{nombreCampo})+1)*sizeof(char);"
		end	
	end
	puts "\n" 
	# Empaquetar payload
	puts "    int tamanio_paquete;"
	puts "    void* paquete = pack_#{nombre}(payload;&tamanio_paquete);"
	puts "    enviar_paquete(socket,paquete,tamanio_paquete);"
	puts "    free(paquete);"
	# Fin de la definicion de la funcion
	puts "};\n\n" 

end


