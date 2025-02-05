# List_App

Aplicación móvil con la versión más actualizada de Flutter que
permita visualizar una lista de Hospitales y cree una solicitud utilizando los servicios web que han sido proporcionados.

- Lattest Flutter version: 3.27.1
    - Se usa la libreria http para implementar la conexion con Postman


lib:

    - bloc
        - auth_bloc.dart: Maneja los estados relacionados con la autenticación.
        - auth_event.dart: Define los eventos para la autenticación.
        - auth_state.dart: Define los estados para la autenticación.
        - hospital_bloc.dart: Maneja los estados relacionados con los hospitales.
        - hospital_event.dart: Define los eventos para la obtención de hospitales.
        - hospital_state.dart: Define los estados para la obtención de hospitales.
    - Core
        - storage/secure_storage.dart: Maneja el almacenamiento seguro del token JWT utilizando flutter_secure_storage.
        Métodos:
            saveToken(String token): Guarda el JWT.
            getToken(): Obtiene el JWT almacenado.
            deleteToken(): Elimina el JWT cuando el usuario cierra sesión.
    - data:
        datasource
            - auth_remote_datasource.dart: Contiene la implementación de la autenticación con la API.
            - hospital_remote_datasource.dart: Maneja la consulta de hospitales a través de peticiones HTTP.
        repositories
            - auth_repository_impl.dart: Implementa la lógica de autenticación basada en el auth_remote_datasource.
            - hospitals_repository.dart: Se conecta con hospital_remote_datasource para obtener la lista de hospitales.
    - domain:
        models
            - hospitals.dart: Modelo de datos que representa la estructura de un hospital.
        epositories
            - auth_repository.dart: Define las funciones relacionadas con la autenticación.
        usecases
            - login_user.dart: Caso de uso para manejar el inicio de sesión.
            - register_user.dart: Caso de uso para manejar el registro de usuario.
    - Presentation
        + Auth: Son las pestanas encargadas con el manejo de sesion (Iniciar sesion/crear una cuenta)
            * login.dart: En esta pagina encontramos el inicio de sesion
            * register.dart: Esta pagina maneja el crear una sesion
            * auth.dart: Este archivo es el encargado de manejar la logica de inicio de sesion, asumo que aqui almacenare el JWT
        + Pages:
            * Splashscreen.dart: Esta pagina se abre al iniciar la app, presenta el icono, en lo que se cargan las dependencias, DBs y recursos
            * App.dart: Punto de entrada de la aplicación.
            * routes.dart: Define las rutas de navegación.
            * hospital_screen.dart: Lista de hospitales obtenidos de la API.
            * hospital_detail_screen.dart: Pantalla con los detalles de un hospital.
            * hospitals_map.dart: Pantalla que muestra los hospitales en un mapa utilizando google_maps_flutter.


            