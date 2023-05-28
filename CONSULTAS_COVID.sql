use portafolio; 

#Primero veamos los registros de la tabla muertes_covid
SELECT * FROM muertes_covid
order by date; #El primer registro es desde el 01-01-2020

SELECT * FROM muertes_covid
order by date desc; #El último regristro de la tabla es hastas el 19-04-2023

#Contando el número total de datos en la tabla muertes_covid
Select count(location) from muertes_covid;

#Seleccionando algunas columnas de la tabla muertes_covid
Select location,date,total_cases,total_deaths,population
	from muertes_covid
    order by location;

#Seleccionando el máximo de casos totales en cada país
Select location as país,max(total_cases) as maximo_casos
	from muertes_covid
group by location
order by maximo_casos desc;
#Observamos que México fue el país con el maximo número de casos con 7,563,576

#Máximo de casos de cada país a traves de los años
Select date_format(date,"%Y") as año,location as país,max(total_cases) as maximo_casos
	from muertes_covid
group by año,location;

#Tasa de infectados con el máximo de casos totales en cada país con respecto a su población
Select location as país,max(total_cases) as maximo_casos, max(population) as población, 
		max(total_cases/population)*100 as tasa_infectados
	from muertes_covid
group by location
order by tasa_infectados desc;
#Observamos que el país que tiene la mayor tasa de infectados es Puerto Rico con un valor del 34.18%

#Máximo de muertes en cada país
Select location as país,max(total_deaths) as maximo_muertes
	from muertes_covid
    group by país
    order by maximo_muertes desc;
#Observamos que México fue el país con el máximo número de muertes con un máximo de 333,669 muertes

#Máximo de muertes de cada país a traves de los años
Select date_format(date,"%Y") as año,location as país,max(total_deaths) as maximo_muertes
	from muertes_covid
group by año,location;

#Tasa de muertes con el máximo de muertes totales en cada país con respecto a su población
Select location as país,max(total_deaths) as maximo_muertes, max(population) as población, 
		max(total_deaths/population)*100 as tasa_muertes
	from muertes_covid
group by location
order by tasa_muertes desc;
#Observamos que el país que tiene la mayor tasa de muertes es México con un valor del 0.26%

#Obteniendo el porcentaje de muertes diario en México
Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as porcentaje_muertes
	from muertes_covid
    where location= "Mexico"
    order by porcentaje_muertes desc;
#Observamos que el día 19-05-2020 se tuvo la tasa de muerte más grande dentro de estos datos, con un porcentaje del 17.19%

#EXPLORANDO DATOS DE MÉXICO

#Máximo de casos en México
select location as país, max(total_cases) as máximo_casos
	from muertes_covid
where location = "México";

#Máximo de casos en México a través de los años
select date_format(date,"%Y") as año, location as país, max(total_cases) as máximo_casos
	from muertes_covid
	group by año,location
having location = "México";

#Tasa del máximo de casos totales vs la población en México
Select location as país,max(total_cases) as max_casos,max(population) as población, max(total_cases/population)*100 as tasa_infectados
	from muertes_covid
    group by país
    having location= "Mexico";
#Se obtiene que el valor máximo de la tasa de infectados con respecto al máximo de casos y población en México es de 5.93%

#Tasa del máximo de casos totales vs la población en México a traves de los años
Select date_format(date,"%Y") as año, location as país,max(total_cases) as max_casos,max(population) as población, 
		max(total_cases/population)*100 as tasa_infectados
	from muertes_covid
    group by año,país
    having location= "Mexico";
    
#Máximo de muertes en México
select location as país,  max(total_deaths) as máximo_muertes
	from muertes_covid
    where location = "México";
#El valor del máximo de muertes totales en México es de 333,669

#Máximo de muertes en México a través de los años
select date_format(date,"%Y") as año, location as país, max(total_deaths) as máximo_muertes
	from muertes_covid
	group by año,location
having location = "México";

#Tasa del máximo de muertes vs la población en México
Select location as país,max(total_deaths) as max_muertes,max(population) as población, max(total_deaths/population)*100 as tasa_muertes
	from muertes_covid
    group by país
    having location= "Mexico";
#Se obtiene que el valor máximo de la tasa de muertes con respecto al máximo de muertes y población en México es de 0.26%

#Tasa del máximo de muertes vs la población en México a traves de los años
Select date_format(date,"%Y") as año, location as país,max(total_deaths) as max_deaths,max(population) as población, 
		max(total_deaths/population)*100 as tasa_muertes
	from muertes_covid
    group by año,país
    having location= "Mexico";




    

    