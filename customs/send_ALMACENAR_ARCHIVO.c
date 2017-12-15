void send_ALMACENAR_ARCHIVO(int socket, int tamanio_contenido, char* contenido, char* pathDestino,char* nombre,char* tipo){
	    payload_ALMACENAR_ARCHIVO payload;
	    payload.tamanio_contenido = tamanio_contenido;
	    payload.contenido = contenido; 
	    payload.tamanio_pathDestino = (strlen(pathDestino)+1)*sizeof(char);
	    payload.pathDestino = pathDestino; 
	    payload.tamanio_nombre = (strlen(nombre)+1)*sizeof(char);
	    payload.nombre = nombre; 
	    payload.tamanio_tipo = (strlen(tipo)+1)*sizeof(char);
	    payload.tipo = tipo; 
	

	int tamanio_paquete;
	char* paquete = pack_ALMACENAR_ARCHIVO(payload,&tamanio_paquete);
	enviar_paquete(socket,paquete,tamanio_paquete);
	free(paquete);
};
