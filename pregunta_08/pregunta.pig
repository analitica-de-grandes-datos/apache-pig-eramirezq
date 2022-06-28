/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{T: TUPLE(p:CHARARRAY)}, f3:MAP[CHARARRAY]);

a = FOREACH lines GENERATE FLATTEN(f2) AS letra, FLATTEN(f3);

b= FOREACH a GENERATE TOTUPLE($0, $1) AS tupla;
grouped = GROUP b BY tupla;
wordcount = FOREACH grouped GENERATE group, COUNT(b);


STORE wordcount INTO 'output' USING PigStorage(',');
