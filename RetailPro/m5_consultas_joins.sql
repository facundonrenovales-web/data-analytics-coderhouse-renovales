use Ventas_Tech_DB;

alter table clientes add fecha_registro date;

update clientes set fecha_registro = '2026-07-01' where id_cliente = 1;
update clientes set fecha_registro = '2026-07-05' where id_cliente = 2;
update clientes set fecha_registro = '2026-07-10' where id_cliente = 3;
update clientes set fecha_registro = '2026-06-20' where id_cliente = 4;


-- Consulta 1: Vista base del proyecto (INNER JOIN)

select 
v.fecha_venta as fecha,
v.id_cliente,
p.nombre as producto,
c.nombre as categoria,
v.cantidad,
v.precio as precio_unitario,
(v.precio * v.cantidad) as total,
cl.ciudad as region
from ventas v
inner join clientes cl on v.id_cliente = cl.id_cliente
inner join productos p on v.id_producto = p.id_producto
inner join categorias c on p.id_categoria = c.id_categoria

-- Consulta 2 — Clientes sin ventas (LEFT JOIN)

select 
cl.nombre,
cl.fecha_registro,
cl.email
from clientes cl
left join ventas v on cl.id_cliente = v.id_cliente
where v.id_venta is null;

-- Consulta 3 — Productos sin ventas (LEFT JOIN)

select
p.nombre as producto,
c.nombre as categoria,
p.precio
from productos p
inner join categorias c on c.id_categoria = p.id_categoria 
left join ventas v on p.id_producto = v.id_producto
where v.id_venta is null;

-- Consulta 4 — Consolidado por canal (UNION ALL)

select
fecha_venta as fecha ,
sum(precio * cantidad) as total,
'Primera Quincena' as canal
from ventas
where fecha_venta <= '2026-08-15'
group by fecha_venta

union all

select
fecha_venta as fecha,
sum (precio * cantidad) as total,
'Segunda Quincena' as canal
from ventas
where fecha_venta >= '2026-08-16'
group by fecha_venta
