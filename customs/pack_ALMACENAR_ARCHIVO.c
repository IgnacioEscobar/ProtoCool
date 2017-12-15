char* pack_ALMACENAR_ARCHIVO(payload_ALMACENAR_ARCHIVO payload,int* tamanio_paquete){
    int tamanio_total = sizeof(HEADER_T) + sizeof(int) + (payload.tamanio_contenido) + sizeof(int) + (payload.tamanio_pathDestino) + sizeof(int) + (payload.tamanio_nombre) + sizeof(int) + (payload.tamanio_tipo);
    char* paquete = malloc(tamanio_total);

    int offset = 0;
    int tamanio_envio;
    HEADER_T cabecera = ALMACENAR_ARCHIVO;
    tamanio_envio = (sizeof(HEADER_T));
    memcpy(paquete+offset,&cabecera,tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.tamanio_contenido),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = (payload.tamanio_contenido);
    memcpy(paquete+offset,(payload.contenido),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.tamanio_pathDestino),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = (payload.tamanio_pathDestino);
    memcpy(paquete+offset,payload.pathDestino,tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.tamanio_nombre),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = (payload.tamanio_nombre);
    memcpy(paquete+offset,payload.nombre,tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = sizeof(int);
    memcpy(paquete+offset,&(payload.tamanio_tipo),tamanio_envio);
    offset += tamanio_envio;

    tamanio_envio = (payload.tamanio_tipo);
    memcpy(paquete+offset,payload.tipo,tamanio_envio);
    offset += tamanio_envio;

    (* tamanio_paquete) = tamanio_total;
    return paquete;
};