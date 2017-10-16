void send_ARCHIVO(int socket , int archivo_fd){
	//
	struct stat buffer;
	int status = fstat(archivo_fd,&buffer);
	if(!status){
		puts("No se pudieron reconocer las estadisticas del ejecutable");
	}
	HEADER_T header = ARCHIVO;
	uint32_t size = buffer.st_size;

	char* paquete = malloc(sizeof(HEADER_T)+sizeof(uint32_t)+size);
	int offset = 0;
	memcpy(paquete+offset,&header,sizeof(HEADER_T));
	offset += sizeof(HEADER_T);
	memcpy(paquete+offset,&size,sizeof(uint32_t));
	offset += sizeof(uint32_t);
	read(archivo_fd,paquete+offset,size);
	enviar_paquete(socket,paquete,size);
	free(paquete);

};
