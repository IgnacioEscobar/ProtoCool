require 'json'

# Seleccionar la base de conocimiento y parsear JSON
file = File.read("baseConocimiento.json")
hash = JSON.parse(file)
mensajes = hash["mensajes"]

#Por cada mensaje creamos una funcion de destruccion

mensajes.each do |mensaje|
	nombre = mensaje["nombre"]
    campos = mensaje["campos"]

	# Cabecera de la funcion
	print "void destroy_#{nombre}(payload_#{nombre}* payload){\n"

	# Ciclo
	campos.each do |campo|
		tipo = campo[0]
		nombreCampo = campo[1]
		# Si es un puntero (casi seguro char*) se tuvo que haber reservado memoria
		if tipo[-1] == '*'
			puts "	free(payload->#{nombreCampo});"
		end

	end

	# Finalmente liberar el paquete
	puts "	free(payload);"

	puts "}\n\n"
	


end