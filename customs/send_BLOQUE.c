void send_BLOQUE(int socket, uint64_t tamanio_bloque, char* bloque, uint32_t id_bloque){

	HEADER_T header = BLOQUE;

	char* paquete = malloc(sizeof(HEADER_T)+sizeof(uint64_t)+tamanio_bloque+sizeof(uint32_t));

	int offset = 0;

	memcpy(paquete+offset,&header,sizeof(HEADER_T));
	offset += sizeof(HEADER_T);

	memcpy(paquete+offset,&tamanio_bloque,sizeof(uint64_t));
	offset += sizeof(uint64_t);

	memcpy(paquete+offset,bloque,tamanio_bloque);
	offset += tamanio_bloque;

	memcpy(paquete+offset,&id_bloque,sizeof(uint32_t));
	offset += sizeof(uint32_t);

	free(paquete);

};
