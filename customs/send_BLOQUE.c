void send_BLOQUE(int socket, int tamanio_bloque, char* bloque, int id_bloque){
	payload_BLOQUE payload;
	payload.tamanio_bloque = tamanio_bloque;
	payload.contenido = bloque;
	payload.numero_bloque = id_bloque;

	int tamanio_paquete;
	char* paquete = pack_BLOQUE(payload,&tamanio_paquete);
	enviar_paquete(socket,paquete,tamanio_paquete);
	free(paquete);
};
