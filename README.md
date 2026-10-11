# RetailPro — Análisis de ventas con SQL Server y Power BI

Proyecto del curso de **Data Analytics (Coderhouse)** que construye, paso a paso, un sistema de análisis para RetailPro: desde la base de datos en SQL Server hasta el modelo de datos en Power BI.

## Descripción del proyecto

**RetailPro** es una distribuidora de tecnología que cuenta con información de ventas, clientes, productos y territorios, pero que hoy no analiza esos datos de manera sistemática.

**Objetivo:** identificar qué factores explican las diferencias en el desempeño de las ventas (entre períodos, territorios, categorías de productos y segmentos de clientes) y detectar dónde están las principales oportunidades de crecimiento.

## Herramientas utilizadas

| Herramienta | Uso en el proyecto |
|---|---|
| **SQL Server Management Studio (SSMS)** | Creación de la base de datos y ejecución de las consultas SQL |
| **Power BI Desktop** | Limpieza y transformación de datos (Power Query), modelo de datos y medidas DAX |
| **Excel** | Dataset de origen (`Pipeline_ETL_Dataset.xlsx`) |
| **Miro** | Primer borrador del boceto del dashboard (la versión final del boceto se terminó en otra herramienta) |
| **GitHub** | Control de versiones y entrega del proyecto |

## Estructura del repositorio

```
data-analytics-coderhouse-renovales/
├── README.md
├── sql-checkpoint/
│   └── ventas_tech_db.sql
└── RetailPro/
    ├── m4_consultas_negocio.sql
    ├── m5_consultas_joins.sql
    ├── Pipeline_ETL_Renovales_Facundo.pbix
    └── Renovales_Facundo_Checkpoint2.pbix
```

| Archivo | Descripción |
|---|---|
| `sql-checkpoint/ventas_tech_db.sql` | Crea la base `Ventas_Tech_DB` con sus 4 tablas (`categorias`, `productos`, `clientes`, `ventas`), las claves foráneas y los datos iniciales |
| `RetailPro/m4_consultas_negocio.sql` | 4 consultas de negocio sobre la tabla `ventas`: resumen mensual, ranking de productos, clientes recurrentes y meses por encima o por debajo del promedio |
| `RetailPro/m5_consultas_joins.sql` | Consultas con JOIN: vista base (INNER JOIN), clientes sin ventas, productos sin ventas y consolidado con UNION ALL |
| `RetailPro/Pipeline_ETL_Renovales_Facundo.pbix` | Archivo de Power BI con la limpieza ETL de los datos |
| `RetailPro/Renovales_Facundo_Checkpoint2.pbix` | Archivo de Power BI con el modelo de relaciones, la tabla calendario (`Dim_Fechas`) y 5 medidas DAX |

## Requisitos previos

- SQL Server instalado (por ejemplo, una instancia local) y SQL Server Management Studio (SSMS).
- Power BI Desktop, para abrir los archivos `.pbix`.
- Una copia de este repositorio (con **Code → Download ZIP** o clonándolo con Git).

## Cómo ejecutar los scripts SQL

Los scripts deben ejecutarse **en orden**, porque las consultas de `RetailPro/` trabajan sobre la base creada por el primer script.

### 1. Crear la base de datos

1. Abrí **SSMS** y conectate a tu instancia de SQL Server (por ejemplo, `localhost`).
2. Andá a **Archivo → Abrir → Archivo** y seleccioná `sql-checkpoint/ventas_tech_db.sql`.
3. Seleccioná **solo la primera línea** del script (`create database Ventas_Tech_DB;`) y presioná **Ejecutar** (o `F5`). Esto crea la base de datos vacía.
4. Seleccioná **el resto del script** (desde `use Ventas_Tech_DB;` hasta el final) y presioná **Ejecutar**. Esto crea las tablas, las claves foráneas y carga los datos iniciales.
5. En el **Explorador de objetos**, hacé clic derecho sobre **Bases de datos → Actualizar** y verificá que aparezca `Ventas_Tech_DB`.

> **Importante:** el script se ejecuta en dos pasos. Si se ejecuta completo de una sola vez, SSMS devuelve el error `Database 'Ventas_Tech_DB' does not exist` en la línea del `use`.

Para comprobar que se creó correctamente, abrí una consulta nueva y ejecutá:

```sql
use Ventas_Tech_DB;

select name from sys.tables;  -- debe mostrar: categorias, clientes, productos, ventas
select * from ventas;         -- debe mostrar las ventas cargadas (10 filas con los datos iniciales)
```

### 2. Ejecutar las consultas de negocio (M4)

1. Abrí `RetailPro/m4_consultas_negocio.sql`.
2. Asegurate de que la base `Ventas_Tech_DB` esté seleccionada en el desplegable de bases de datos.
3. Ejecutá cada consulta por separado (seleccioná el bloque y presioná `F5`) para ver sus resultados.

### 3. Ejecutar las consultas con JOIN (M5)

1. Abrí `RetailPro/m5_consultas_joins.sql`.
2. El script comienza con un bloque de preparación (`alter table clientes add fecha_registro date;` y cuatro `update`) que agrega la columna `fecha_registro` a la tabla `clientes` y la completa. Seleccionalo y ejecutalo **una sola vez**.
3. Con la base `Ventas_Tech_DB` seleccionada, ejecutá cada consulta por separado, seleccionando desde el comentario `-- Consulta 1` en adelante.

> **Importante:** si el bloque de preparación se ejecuta más de una vez, SSMS devuelve el error `Column names in each table must be unique`, porque la columna `fecha_registro` ya existe.

## Cómo abrir los archivos de Power BI

1. Abrí el archivo `.pbix` con **Power BI Desktop**.
2. **Los dos archivos `.pbix`** toman sus datos de `Pipeline_ETL_Dataset.xlsx`, que **no está incluido en este repositorio** (`Renovales_Facundo_Checkpoint2.pbix` se construyó sobre el modelo de `Pipeline_ETL_Renovales_Facundo.pbix`). Si el archivo Excel está en otra ubicación, actualizá la ruta en cada archivo desde **Inicio → Transformar datos → Configuración de origen de datos**.
3. `Renovales_Facundo_Checkpoint2.pbix` contiene el modelo de relaciones (1:N, filtro único), la tabla calendario `Dim_Fechas` y las medidas DAX: `Total Ventas`, `Ventas Online`, `Ventas YTD`, `Ventas LY` y `% Crecimiento Anual`.

## Próximos pasos

Construir en Power BI el dashboard de RetailPro a partir del boceto diseñado para el proyecto, sobre el modelo de datos ya creado.

## Autor

**Facundo Renovales** — Curso de Data Analytics, Coderhouse.
