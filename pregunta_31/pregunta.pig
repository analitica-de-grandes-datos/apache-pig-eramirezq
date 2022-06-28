/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:int,nombre:chararray,apellido:chararray,fecha:datetime,color:chararray,id:int);

a= FOREACH lines GENERATE GetYear(fecha) AS year;

grouped = GROUP a BY year;
wordcount = FOREACH grouped GENERATE group, COUNT(a);

STORE wordcount INTO 'output' USING PigStorage(',');

