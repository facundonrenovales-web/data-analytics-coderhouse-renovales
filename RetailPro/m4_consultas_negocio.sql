use Ventas_Tech_DB;

-- Consulta 1: Resumen ejecutivo mensual

select 
sum (cantidad*precio) as total_facturado,
count (*) as cantidad_de_pedidos ,
avg (cantidad * precio) as ticket_promedio,
month (fecha_venta) as mes
from ventas
group by month (fecha_venta)
order by mes;

-- Consulta 2: Ranking de productos

select top 5
id_producto,
sum(cantidad) as cantidades_vendidas,
sum(cantidad * precio) as total_generado
from ventas
group by id_producto
order by total_generado desc;

-- Consulta 3: Clientes recurrentes

select 
id_cliente,
count(*) as cantidad_pedidos,
sum (cantidad*precio) as total_gastado
from ventas
group by id_cliente
having count(*) > 1
order by total_gastado desc;

-- Consulta 4: Meses por encima/por debajo del promedio

select 
month (fecha_venta) as mes,
sum (cantidad*precio) as total_facturado,
case
when sum (cantidad*precio) > (
select avg (total_mes)
from (
select sum (cantidad*precio) as total_mes
from ventas 
group by month (fecha_venta))
as subconsulta)
then 'Por encima' else 'Por debajo'
end as comparacion
from ventas 
group by month (fecha_venta)
order by mes;

-- Hallazgos:
-- 1. El producto 1 concentra la mayor facturación, con $8400 (aprox. 32% del total).
-- 2. El cliente 3 es el más rentable, con 3 pedidos y $12100 gastados en total.
-- 3. El ticket promedio es de $2598.
