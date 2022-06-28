/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{T: TUPLE(p:CHARARRAY)}, f3:MAP[CHARARRAY]);

r = FOREACH lines GENERATE FLATTEN(f3);
a = FOREACH r GENERATE $0 AS word;

grouped = GROUP a BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(a);

STORE wordcount INTO 'output' USING PigStorage(',');
