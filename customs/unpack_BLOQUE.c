void* unpack_BLOQUE(int socket){
    payload_BLOQUE *payload= malloc(sizeof(payload_BLOQUE));

    recv(socket,&(payload->tamanio_bloque),sizeof(int),0);
    uint64_t  tamanio_bloque = payload->tamanio_bloque;

    char* bloque = malloc(tamanio_bloque);
    recv(socket,bloque,tamanio_bloque,0);
    payload->contenido = bloque;

    recv(socket,&(payload->numero_bloque),sizeof(int),0);

    return (void*)payload;
};