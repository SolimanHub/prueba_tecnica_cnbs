# Prueba Técnica CNBS

Este repositorio contiene la solución al proyecto de prueba técnica asignado. La aplicación permite consultar y almacenar datos de una API externa en una base de datos local, además de explorar datos mediante una interfaz amigable.

## Contenido del Repositorio

- **Código del Proyecto:** Todo el código fuente necesario para ejecutar la aplicación.
- **Archivo SQL:** Instrucciones SQL para crear las tablas y procedimientos almacenados requeridos.

## Descripción del Proyecto

### Funcionalidad Principal
La aplicación permite:
1. Consultar datos de una API externa.
2. Almacenar los datos consultados en una base de datos local.
3. Explorar y visualizar los datos almacenados a través de una interfaz de usuario amigable.

### Componentes Clave

- **Controlador Principal (`DataController.cs`):** Maneja la lógica de negocio y las interacciones con la base de datos.
- **Vista Principal (`Index.cshtml`):** Proporciona una interfaz para consultar y explorar datos.
- **Archivos de Estilo y Scripts:** 
  - `data.css`: Estilos CSS para la presentación de la interfaz.
  - `data.js`: Scripts JavaScript para la funcionalidad del front-end.

## Instrucciones para Configuración y Ejecución

### Prerrequisitos

- [Visual Studio](https://visualstudio.microsoft.com/)
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)

### Pasos para Configuración

1. **Clonar el Repositorio:**

   ```bash
   git clone https://github.com/SolimanHub/prueba_tecnica_cnbs.git
   cd prueba-tecnica_cnbs
   ```
2. Configurar la Base de Datos:

    Ejecutar el script SQL proporcionado (DBCNBS.sql) para crear la base de datos y las tablas necesarias.

3. Configurar la Cadena de Conexión:

    Abrir appsettings.json y configurar la cadena de conexión para que apunte a la base de datos creada.
    ```json
    "ConnectionStrings": {
      "DBCNBS": "Server=.;Database=DBCNBS;Trusted_Connection=True;"
    }
    ```

4. Ejecutar el Proyecto:
        Abrir el proyecto en Visual Studio.
        Compilar y ejecutar la aplicación.

## Uso de la Aplicación

1. Consultar Datos:
- Introducir la fecha de declaración en el formato yyyy-mm-dd y hacer clic en "Ver JSON" para visualizar los datos en formato JSON.
- Hacer clic en "Guardar Datos" para almacenar los datos consultados en la base de datos.

2. Explorar Datos:
- Hacer clic en "Explorar Datos" para abrir el formulario de exploración.
- Introducir el número de identificación del importador/exportador y hacer clic en "Mostrar" para visualizar los datos almacenados.

