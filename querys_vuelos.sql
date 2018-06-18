
/* 1. Cantidad de vuelos */
SELECT COUNT(*) cantidadVuelos FROM flights


/* 2. Retraso promedio de salida y llegada según el aeropuerto origen */
SELECT 
	Origin,
	AVG(DepDelay) AS retrasoPromedioSalidaEnMinutos,  
	AVG(ArrDelay) AS retrasoPromedioLlegadaEnMinutos
FROM flights
GROUP BY Origin


/* 3. Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen. */
SELECT 
	CONCAT(
	Origin,', ',
	colYear,', ',
	colMonth,', ', 
	AVG(ArrDelay)) AS retrasoPromedioLlegadaEnMinutos
FROM flights
GROUP BY Origin,colYear,colMonth


/*4. Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen (misma
consulta que antes y con el mismo orden). Pero además, ahora quieren que en vez
del código del aeropuerto se muestra el nombre de la ciudad.*/
SELECT 
	CONCAT(
	B.City,', ',
	A.colYear,', ',
	A.colMonth,', ', 
	AVG(A.ArrDelay)) AS retrasoPromedioLlegadaEnMinutos
FROM flights A INNER JOIN usairports B ON A.Origin = B.IATA
GROUP BY A.Origin,A.colYear,A.colMonth


/*5. Las compañías con más vuelos cancelados. Además, deben estar ordenadas de forma
que las compañías con más cancelaciones aparezcan las primeras.*/
SELECT 
	B.Description, SUM(A.cancelled) AS vuelosCancelados
FROM flights A INNER JOIN carriers B ON A.UniqueCarrier = B.CarrierCode
GROUP BY B.Description ORDER BY vuelosCancelados DESC


/* 6. El identificador de los 10 aviones que más kilómetros han recorrido haciendo vuelos
comerciales: */
SELECT 
	B.Description, SUM(A.Distance) AS distanciaRecorrida
FROM flights A INNER JOIN carriers B ON A.UniqueCarrier = B.CarrierCode
GROUP BY B.Description ORDER BY distanciaRecorrida DESC 
LIMIT 10


/* 7. Compañías con su retraso promedio sólo de aquellas las que sus vuelos
llegan a su destino con un retraso promedio mayor de 10 minutos.*/
SELECT 
	B.Description, AVG(A.ArrDelay) AS retrasoPromedioLlegadaEnMinutos
FROM flights A INNER JOIN carriers B ON A.UniqueCarrier = B.CarrierCode
GROUP BY B.Description 
HAVING retrasoPromedioLlegadaEnMinutos > 10