char* pack_BLOQUE(payload_BLOQUE payload,int* tamanio_paquete){
    int tamanio_total = sizeof(HEADER_T) + sizeof(int) + payload.tamanio_bloque + sizeof(int);
    char* paquete = malloc(tamanio_total);

    int offset = 0;
    int tamanio_envio;
    HEADER_T cabecera = BLOQUE;
    tamanio_envio = (sizeof(HEADER_T));
    memcpy(paquete+offset,&cabecera,tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.tamanio_bloque),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = (payload.tamanio_bloque);
    memcpy(paquete+offset,(payload.contenido),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.numero_bloque),tamanio_envio);
    offset += tamanio_envio;

    (* tamanio_paquete) = tamanio_total;
    return paquete;
};