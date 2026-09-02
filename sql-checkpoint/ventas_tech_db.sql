use ventas_tech;

drop table if exists ventas;
drop table if exists productos;
drop table if exists categorias;
drop table if exists clientes;

create table categorias (
id_categoria int primary key,
nombre varchar (100) not null);

create table productos (
id_producto int primary key,
nombre varchar (100) not null,
precio decimal (10,2) not null,
id_categoria int,
foreign key (id_categoria)
references categorias (id_categoria));

create table clientes (
id_cliente int primary key,
nombre varchar (100) not null,
email varchar (100),
ciudad varchar (100));

create table ventas (
id_venta int primary key,
id_cliente int not null,
id_producto int not null,
fecha_venta date not null,
cantidad int not null,
precio decimal (10,2) not null,
foreign key (id_cliente)
references clientes (id_cliente),
foreign key (id_producto)
references productos (id_producto));

insert into categorias (id_categoria, nombre)
values
(1,'celulares'),
(2, 'computadoras'),
(3, 'tablets'),
(4, 'cargadores');

insert into productos (id_producto, nombre, precio, id_categoria)
values
(1,'iphone16', 1200.00, 1),
(2, 'iphone16_pro', 1300.00, 1),
(3, 'macbook', 1500.00, 2),
(4, 'macbook_pro', 1600.00, 2),
(5, 'ipad', 1000.00, 3),
(6, 'cargador_iphone', 20.00, 4);

insert into clientes (id_cliente,nombre,email,ciudad)
values
(01, 'juan perez','juanperez@gmail.com', 'caba'),
(02, 'jose lopez', 'joselopez@gmail.com', 'san rafael'),
(03, 'carlos saul', 'carlossaul@gmail.com', 'cordoba'),
(04, 'enzo r', 'enzor@gmail.com', 'la plata');

insert into ventas (id_venta, id_producto, id_cliente,fecha_venta, cantidad, precio)
values
(1, 1, 01, '2026-08-15', 2, 1200.00),
(2, 2, 02, '2026-08-16', 1, 1300.00),
(3, 3, 01, '2026-08-17', 1, 1500.00),
(4, 4, 03, '2026-08-18', 3, 1600.00),
(5, 5, 01, '2026-08-19', 4, 1000.00),
(6, 6, 04, '2026-08-20', 4, 20.00),
(7, 4, 04, '2026-08-21', 1, 1600.00),
(8, 1, 03, '2026-08-22', 5, 1200.00),
(9, 2, 03, '2026-08-22', 1, 1300.00),
(10, 3, 02, '2026-08-23', 2, 1500.00);

select * from ventas;
