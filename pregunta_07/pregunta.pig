/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:CHARARRAY, f3:CHARARRAY);

a = FOREACH lines GENERATE f1, TOKENIZE(f2,',') AS letra, TOKENIZE(f3,',') AS keys;

b= FOREACH a GENERATE $0, COUNT(letra) AS cant_letra, COUNT(keys) AS cant_keys;

c = ORDER b BY $0, cant_letra, cant_keys;

STORE c INTO 'output' USING PigStorage(',');