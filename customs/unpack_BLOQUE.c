void* unpack_BLOQUE(int socket){
    payload_BLOQUE *payload= malloc(sizeof(payload_BLOQUE));

    recv(socket,&(payload->tamanio_bloque),sizeof(int),MSG_WAITALL);
    int  tamanio_bloque = payload->tamanio_bloque;

    char* bloque = malloc(tamanio_bloque);
    recv(socket,bloque,tamanio_bloque,MSG_WAITALL);
    payload->contenido = bloque;

    recv(socket,&(payload->numero_bloque),sizeof(int),MSG_WAITALL);

    return (void*)payload;
};