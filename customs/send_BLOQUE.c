void send_BLOQUE(int socket, int tamanio_bloque, char* bloque, int id_bloque){

	HEADER_T header = BLOQUE;

	char* paquete = malloc(sizeof(HEADER_T)+sizeof(int)+tamanio_bloque+sizeof(int));

	int offset = 0;

	memcpy(paquete+offset,&header,sizeof(HEADER_T));
	offset += sizeof(HEADER_T);

	memcpy(paquete+offset,&tamanio_bloque,sizeof(int));
	offset += sizeof(int);

	memcpy(paquete+offset,bloque,tamanio_bloque);
	offset += tamanio_bloque;

	memcpy(paquete+offset,&id_bloque,sizeof(int));
	offset += sizeof(int);
	
	enviar_paquete(socket,paquete,offset);

	free(paquete);

};
