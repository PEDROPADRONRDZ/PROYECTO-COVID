use portafolio; 

#Primero veamos los registros de la tabla muertes_covid
SELECT * FROM muertes_covid
order by date; #El primer registro es desde el 01-01-2020

SELECT * FROM muertes_covid
order by date desc; #El último regristro de la tabla es hastas el 19-04-2023

#Ahora veamos registros de la tabla vacunas_covid
SELECT * FROM vacunas_covid
order by date; #El primer registro es desde el 01-01-2020

SELECT * FROM vacunas_covid
order by date desc; #El último regristro de la tabla es hastas el 19-04-2023

#SELECCIONANDO COLUMNAS DE LA TABLA muertes_covid
Select location,date,total_cases,new_cases,total_deaths,population
	from muertes_covid
    order by location;
    
#Obteniendo el porcentaje de muertes diario en México
Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as porcentaje_muertes
	from muertes_covid
    where location= "Mexico"
    order by porcentaje_muertes desc;
#Observamos que el día 19-05-2020 se tuvo la tasa de muerte más grande dentro de estos datos, con un porcentaje del 17.19%

#Obteniendo el porcentaje de casos totales vs la población en México
Select location,date,total_cases,population, (total_cases/population)*100 as porcentaje_casos
	from muertes_covid
    where location= "Mexico"
    order by porcentaje_casos desc;
#Observamos que el día 16-04-2023 se obtuvo la tasa más grande de casos de covid 

#Conociendo cuál país tuvo la tasa de infección más alta
Select location as país,max(total_cases) as maximo_casos,population as poblacion, max((total_cases/population))*100 as porcentaje_casos
	from muertes_covid
    group by país,poblacion
    order by porcentaje_casos desc;
#Se obtiene que Puerto Rico fue el país con la tasa de infectado más alta entre todos los demás países, con un total de 34.17% de casos


#Conociendo cuál país tuvo el máximo de muerte en total
Select location as país,max(total_deaths) as maximo_muertes,population as poblacion #Se toma el maximo porque en los datos las muertes se van sumando cada día
	from muertes_covid
    group by país,poblacion
    order by maximo_muertes desc;
#Observamos que México fue el país con la cantidad de muertes más alta

#Conociendo cuál país tuvo la tasa de muerte más alta por población
Select location as país,sum(total_deaths) as total_muertes,population as poblacion, max((total_deaths/population))*100 as porcentaje_muertes
	from muertes_covid
    group by país,poblacion
    order by porcentaje_muertes desc;
#De igual manera que en la consulta anterior, México tuvo la tasa de muertes más alta con una tasa del 0.26%

#Veamos el total de casos y de muertes en México por mes de cada año y la tasa de muertes por casos
select location as país, date_format(date,"%M") as mes,date_format(date,"%Y") as año, 
		max(total_cases) as total_casos, sum(total_deaths) as total_muertes, max(total_deaths/total_cases)*100 as tasa_muertes_casos
	from muertes_covid
    where location = "México"
    group by país, mes,año
    order by tasa_muertes_casos desc;
#Observamos que en el mes de Mayo de 2020 la tasa de muertes por casos fue la mayor en México con un valor de 17.17%

#Ahora, vamos a unir las tablas de muertes_covid y vacunas_covid
#Vamos a ver el total de población vs total de vacunados en cada país y la tasa de estos
Select m.location,m.population,
		MAX(v.people_vaccinated) as total_vacunados, (max(v.people_vaccinated)/m.population)*100 as proporcion_vacunados
        from muertes_covid m
join vacunas_covid v
	on m.iso_code = v.iso_code				#Unimos las tablas mediante la columna iso_code que ambas comparten
     where v.people_vaccinated is not null	
    GROUP BY m.location, m.population
    order by proporcion_vacunados desc;
#OBSERVAMOS QUE CUBA ES EL PAIS QUE TIENE LA PRPORCION MÁS ALTA DE VACUNADOS RESPECTO A SU POBLACION CON UN VALOR DE 95.74%
#MIENTRAS QUE HAITI ES EL PAIS CON LA TASA MAS BAJA CON UN VALOR DE 4.02%


#Vamos a guardar los datos obtenidos en la consulta anterior en una tabla llamada Proporcion_vacunados
#Creando la tabla
Create table Proporcion_vacunados
(Pais varchar(255),
poblacion int,
vacunados int,
proporcion int 
);

#Ingresando los valores de la consulta anterior a la tabla creada anteriormente 
insert into proporcion_vacunados
Select m.location,m.population,
		MAX(v.people_vaccinated) as total_vacunados, (max(v.people_vaccinated)/m.population)*100 as proporcion_vacunados
        from muertes_covid m
join vacunas_covid v
	on m.iso_code = v.iso_code				#Unimos las tablas mediante la columna iso_code que ambas comparten
     where v.people_vaccinated is not null	
    GROUP BY m.location, m.population
    order by proporcion_vacunados desc;
    
    
#Para finalizar vamos a crear ahora una vista con la consulta anterior que hicimos tabla para futuras visualizaciones

Create view Vista_prop_vacunas as
Select m.location,m.population,
		MAX(v.people_vaccinated) as total_vacunados, (max(v.people_vaccinated)/m.population)*100 as proporcion_vacunados
        from muertes_covid m
join vacunas_covid v
	on m.iso_code = v.iso_code				#Unimos las tablas mediante la columna iso_code que ambas comparten
     where v.people_vaccinated is not null	
    GROUP BY m.location, m.population
    order by proporcion_vacunados desc;
    