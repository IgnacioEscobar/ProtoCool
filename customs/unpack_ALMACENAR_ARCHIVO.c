void* unpack_ALMACENAR_ARCHIVO(int socket){

    payload_ALMACENAR_ARCHIVO *payload= malloc(sizeof(payload_ALMACENAR_ARCHIVO));

    recv(socket,&(payload->tamanio_contenido),sizeof(int),MSG_WAITALL);
    int  tamanio_contenido = payload->tamanio_contenido;

    char* contenido = malloc(tamanio_contenido);
    recv(socket,contenido,tamanio_contenido,MSG_WAITALL);
    payload->contenido = contenido;

    recv(socket,&(payload->tamanio_pathDestino),sizeof(int),MSG_WAITALL);
    int  tamanio_pathDestino = payload->tamanio_pathDestino;

    char* pathDestino = malloc(tamanio_pathDestino);
    recv(socket,pathDestino,tamanio_pathDestino,MSG_WAITALL);
    payload->pathDestino = pathDestino;

    recv(socket,&(payload->tamanio_nombre),sizeof(int),MSG_WAITALL);
    int  tamanio_nombre = payload->tamanio_nombre;

    char* nombre = malloc(tamanio_nombre);
    recv(socket,nombre,tamanio_nombre,MSG_WAITALL);
    payload->nombre = nombre;

    recv(socket,&(payload->tamanio_tipo),sizeof(int),MSG_WAITALL);
    int  tamanio_tipo = payload->tamanio_tipo;

    char* tipo = malloc(tamanio_tipo);
    recv(socket,tipo,tamanio_tipo,MSG_WAITALL);
    payload->tipo = tipo;

    return (void*)payload;


};