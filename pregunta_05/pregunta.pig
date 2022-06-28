/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{T: TUPLE(p:CHARARRAY)}, f3:CHARARRAY);
r = FOREACH lines GENERATE FLATTEN(f2) As word;
grouped = GROUP r BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(r);
STORE wordcount INTO 'output' USING PigStorage(',');