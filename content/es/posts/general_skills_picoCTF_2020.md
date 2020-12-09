---
title: Resolviendo General Skills - picoCTF 2020
date: 2020-12-07
description: Writeup de los retos en picoCTF 2020 de la categoría General Skills
draft: false
author: Guillermo Ballesteros
tags:
- Bash
- Linux
- General skills
categories:
- CTF
- PicoCTF
series:
- picoCTF2020
---
## 2Warm - 50 points
### Descripción
{{< boxmd >}}
Can you convert the number 42 (base 10) to binary (base 2)? 
{{< /boxmd >}}
### Procedimiento
Este reto es el más sencillo, y lo digo sin miedo a equivocarme. Lo único que necesitamos es saber conversión de bases, o más fácil, tener una calculadora.
Para facilitar el trabajo usaré una calculadora en modo programador. Simplemente inntroducimos el valor decimal y nos retorna el mismo valor en binario.
{{< img src="/images/picoCTF/2Warm_01.jpg" title="Calculadora"  position="center" >}}
Como observamos el resultado es 101010 pero al tratarse de un CTF hay que poner la respuesta en el formato del mismo, que viene a ser "picoCTF{FLAG}"
### Solución
{{< box >}}
picoCTF{101010} 
{{< /box >}}
## Warmed Up - 50 points
### Descripción
{{< boxmd >}}
What is 0x3D (base 16) in decimal (base 10)?
{{< /boxmd >}}
### Procedimiento
Nos encontramos con otro reto sencillo de cambio de bases. Procedemos a usar el mismo método que en el anterior.
{{< img src="/images/picoCTF/WarmUp_01.jpg" title="Calculadora"  position="center" >}}
Como vemos la transformación de 0x3D a decimal es 61
### Solución
{{< box >}}
picoCTF{61} 
{{< /box >}}
## Lets Warm Up - 50 points
### Descripción
{{< boxmd >}}
If I told you a word started with 0x70 in hexadecimal, what would it start with in ASCII? 
{{< /boxmd >}}
### Procedimiento
En este caso no se trata de una conversión numérica sino una conversión de valor tal cual. Sin embargo, no es más complicado que buscar 0x70 en una tabla, específicamente en la tabla ASCII ya que hay en internet tablas con conversión de hexadecima a ASCII como es la siguiente:
{{< img src="/images/picoCTF/LetsWarmUp_01.jpg" title="TablaASCII"  position="center" >}}
Si nos fijamos la 3er columna se refiere al valor hexadecimal, y la cuarta columna es el caracter en ASCII. Por lo que concluímos que la letra referida es la **p**.
### Solución
{{< box >}}
picoCTF{p} 
{{< /box >}}
## Strings it - 100 points
### Descripción
{{< boxmd >}}
Can you find the flag in file without running it?
{{< /boxmd >}}
### Procedimiento
El archivo referido es un archivo ejecutable _.deb_. Y en este caso el nombre de el reto no solo nos da una pista de qué hacer, sino que literalmente nos dice qué hacer.
En Bash existe el comando _strings_ que nos muestra todas las cadenas de caracteres dentro de un archivo cualquiera, y al utilizarlo sobre este archivo nos muestra lo siguiente:
``` [ strings ]
~/Descargas/picoCTF2020 > strings bat_0.17.1_amd64.deb
/lib64/ld-linux-x86-64.so.2
libc.so.6
puts
stdout
__cxa_finalize
setvbuf
__libc_start_main
GLIBC_2.2.5
__gmon_start__
_ITM_deregisterTMCloneTable
_ITM_registerTMCloneTable
=11'
=g	 
=j	 
AWAVI
AUATL
[]A\A]A^A_
Maybe try the 'strings' function? Take a look at the man page
;*3$"
XMdasaWpAXqIHqvFBYTt
32VO1kKGW7st50mkv
B2WqFg3mFhCfUyvG3sNEs9Ep3FYP2gEkUePqFgUVN30MAZtV
zc2qhtc8wESHxGya1S9WpEXLgKo4D8ZrKODtQ4
```
Y esto se extiende cientos de lineas, algo común en ejecutables. Pero si te dijas, hay una linea que nos dice que vamos por el camino correcto `Maybe try the 'strings' function? Take a look at the man page`. Pues bien, ya tenemos todos los strings, pero ¿cuál de todas esas cadenas es la Flag?

Como ya mencioné antes, en todo CTF se tiene un formato para la bandera, en este caso `picoCTF{FLAG}`, y en situaciones como estas suelen poner la bandera completa para facilitarnos su ubicación, por lo que nuestro objetivo será ubicar una cadena que empiece con _picoCTF_, algo que podemos hacer con el comando `grep` de la forma siguiente:
`greo "picoCTF"`
Así pues, si mandamos el resultado del `strings` a el `grep` deberíamos encontrar la respuesta.
{{< img src="/images/picoCTF/StringsIt_01.jpg"   position="center" >}}
Y así es, encontramos la bandera.
### Solución
{{< box >}}
picoCTF{5tRIng5_1T_827aee91}
{{< /box >}}
## Bases - 100 points
### Descripción
{{< boxmd >}}
What does this **bDNhcm5fdGgzX3IwcDM1** mean? I think it has something to do with bases.
{{< /boxmd >}}
### Procedimiento
De nuevo, fijandonos en el nombre encontramos una pista enorme. Esta vez se trata de bases, una especie de cifrado u ocultamiento que consiste en tomar una cadena de texto plano, pasarlo a su valor en bits, y luego agrupar de a 6 bits y regresar esos valores a caractér ASCII. Para aprender más de cómo funciona recomiendo ampliamente [este ejemplo de Wikipedia](https://es.wikipedia.org/wiki/Base64#Ejemplo).

En fin, para este tipo de retos me gusta usar herramientas online pues permiten una mayor versatilidad, sin embargo hay muchas otras formas de resolverlo. Para bases el más común es Base64, por lo que será el primero a probar.
Usaré la página [base64decode](https://www.base64decode.org/), donde solo pegas el cifrado, das click en _DECODE_, y saldrá el resultado.
{{< img src="/images/picoCTF/Base_01.jpg" position="center" >}}
Pareciera que ese no es el resultado, pero si reemplazamos los número por la letra más parecida se convierte en un frase, lo cuál nos indica que en efecto esa es la respuesta.
### Solución
{{< box >}}
picoCTF{l3arn_th3_r0p35}
{{< /box >}}
Lo siguiente fue añadido el día 9 de Diciembre, 2020.
## First Grep - 100 points
### Descripción
{{< boxmd >}}
Can you find the flag in _file_? This would be really tedious to look through manually, something tells me there is a better way.
{{< /boxmd >}}
### Procedimiento
Este reto es extremadamente similar a strings, pues el nombre ya nos dice que hacer y de nueva forma, se basa en usar _grep_. Sin embargo, esta vez no tenemos un archivo ejecutable, sino un archivo de texto por lo que, pese a ser útil el comando _strings_, lo ideal sería usar el comando `cat`.
El comando `cat` realmente funciona para concatenar el contenido de dos archivos y lo mostrará como output, sin embargo, si solo se le pasa como argumento un archivo, mostrará el contenido de ese archivo como output. Usando este output en grep nos terminaría dando el mismo resultado que se obtuvo en el reto antes mencionado.
El comando final debería quedar algo así:
``` 
strings file | grep "picoCTF"
```
{{< img src="/images/picoCTF/FirstGrep_01.jpg"   position="center" >}}
### Solución
{{< box >}}
picoCTF{grep_is_good_to_find_things_dba08a45}
{{< /box >}}
## whay's a net cat? - 100 points
### Descripción
{{< boxmd >}}
Using netcat (nc) is going to be pretty important. Can you connect to _jupiter.challenges.picoctf.org_ at port _64287_ to get the flag?
{{< /boxmd >}}
### Procedimiento
Esta vez todo está claro desde el nombre y la descripción: debemos usar netcat en la url y puerto indicados. 
Netcat es una herramienta que permite asociar un script a un puerto específico de la IP publica propia. La forma de usarlo sería:
```
nc jupiter.challenges.picoctf.org 64287
```
{{< img src="/images/picoCTF/whatsanetcat_01.jpg"   position="center" >}}
### Solución
{{< box >}}
picoCTF{nEtCat_Mast3ry_284be8f7}
{{< /boxmd >}}
## plumbing - 200 points
### Descripción
Sometimes you need to handle process data outside of a file. Can you find a way to keep the output from this program and search for the flag? Connect to _jupiter.challenges.picoctf.org 7480_.
### Procedimiento
Por primera vez las cosas no parecen del todo claras, sin embargo recordando cómo usamos `grep` y `nc` podríamos guiarnos. La primer idea que se me viene a la mente es revisar la salida del netcar especificada:
{{< img src="/images/picoCTF/plumbing_01.jpg"   position="center" >}}
La salida es larga y repetitiva. Siguiendo con mi idea, habría que mandar esta salida al `grep` para que nos muestre directamente la linea que tenga _picoCTF_ en ella:
```
nc jupiter.challenges.picoctf.org 7480 | grep "picoCTF"
```
{{< img src="/images/picoCTF/plumbing_02.jpg"   position="center" >}}
Funcionó. Como se observa, toda salida en la terminal se puede enviar a grep para buscar información específica.
### Solución
{{< box >}}
picoCTF{digital_plumb3r_06e9d954}
{{< /box>}}
## Based - 200 points
### Descripción
{{< boxmd >}}
To get truly 1337, you must understand different data encodings, such as hexadecimal or binary. Can you get the flag from this program to prove you are on the way to becoming 1337? Connect with _nc jupiter.challenges.picoctf.org 29221_.
{{< /boxmd >}}
### Procedimiento
Para hacernos una idea de a qué nos enfrentamos, haré el netcat para ver qué me muestra:
{{< img src="/images/picoCTF/Based_01.jpg"   position="center" >}}
Pues bien, tenemos un reto contrareloj y que al menos en la primer parte nos pide conversión de valores. Se me ocurren dos soluciones: hacer uno por uno de forma manual, o hacer un script de python, o bash, para que lo resuelva por nosotros. Yo me iré por la opción más rápida que es resolverlo de forma manual. Y para hacerlo aún más rápido usaré herramientas online. 
#### Primer paso
Para el valor binario usaré este [convertidor de Binario a String](https://codebeautify.org/binary-string-converter):
{{< img src="/images/picoCTF/Based_02.jpg"   position="center" >}}
¡Bien! tenemos la primer palabra: `street`. Al introducirla en la terminal obtenemos la siguiente respuesta:
{{< box >}}
Please give me the  163 154 165 144 147 145 as a word.
Input:
{{< /box >}}
#### Segundo paso
Parece que la siguiente palabra tiene valores entre 140 y 170, lo cual me hace pensar que son valores decimales de ASCII, pero al revisar la tabla (que encontrarás en [Lets Warm Up](#lets-warm-up---50-points)), notamos que ASCII solo llega hasta el 127 así que descartamos la idea.
Podríamos pensar que es otro tipo de codificación para caracteres, pero la verdad es que todas se basan en ASCII por lo que valores más allá de 127 no serán caracteres del alfabeto inglés. Mirando un poco más de cerca los valores a decodificar notamos que no hay ningún 8 o 9, así que se podría tratar de un valor octal, donde el 141 es equivalente a 97 decimal, o _a_ en ASCII. Suena muy bien la idea, así que usaremos [esta página](https://onlineasciitools.com/convert-octal-to-ascii) que convierte de Octal a ASCII.
{{< img src="/images/picoCTF/Based_03.jpg"   position="center" >}}
Al introducir la palabra obtenida en la terminal obtenemos:
{{< box >}}
Please give me the 736f636b6574 as a word.
Input:
{{< /box >}}
#### Tercer paso
Observamos valores númericos normales, pero también letras, y también notamos que tenemos una cantidad par de caracteres, específicamente 12. Todo esto me hace pensar en Hexadecimal, que tendría sentido siguiendo el patrón establecido por los dos pasos anteriores.
Usando la misma herramienta que con el paso anterior, pero el valor introducido lo dividiremos en pares.
{{< img src="/images/picoCTF/Based_04.jpg"   position="center" >}}
¡Genial! lo introducimos en la terminal y obtenemos:
### Solucion
{{< box >}}
You've beaten the challenge
Flag: picoCTF{learning_about_converting_values_00a975ff}
{{< /box >}}