---
title: Resolviendo General Skills - picoCTF 2020
date: 2020-12-07
description: Writeup de los retos en picoCTF 2020 de la categoría General Skills
draft: false
author: Guillermo Ballesteros
tags:
- markdown
- css
- html
- themes
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