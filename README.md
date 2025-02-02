# List_App

Aplicación móvil con la versión más actualizada de Flutter que
permita visualizar una lista de Hospitales y cree una solicitud utilizando los servicios web que han sido proporcionados.

- Lattest Flutter version: 3.27.1
    - Se usa la libreria http para implementar la conexion con Postman


lib:
    - Core
    - data
    - domain
    - Presentation
        + Auth: Son las pestanas encargadas con el manejo de sesion (Iniciar sesion/crear una cuenta)
            * login.dart: En esta pagina encontramos el inicio de sesion
            * register.dart: Esta pagina maneja el crear una sesion
            * auth.dart: Este archivo es el encargado de manejar la logica de inicio de sesion, asumo que aqui almacenare el JWT
        + Pages:
            * Splashscreen.dart: Esta pagina se abre al iniciar la app, presenta el icono, en lo que se cargan las dependencias, DBs y recursos
            