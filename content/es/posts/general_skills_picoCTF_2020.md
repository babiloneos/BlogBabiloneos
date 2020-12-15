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
Año tras año se lleva a cabo un CTF organizado por Carnegie Mellon University llamado picoCTF, el cuál alberga retos desde lo más básico hasta avanzados, y al terminar la competición formal se libera la plataforma en Internet para que todos podamos resolver los retos y, aprender o bien reforzar conocimientos. 

Lo interesante de este CTF es la gran cantidad de retos que tiene, y a demás su variedad, pues alberga retos de Explotación Web, Criptografía, Ingeniería Inversa, Forencia, Explotación Binaria y Habilidades Generales. Son, en lo general, todas las categorías que se encuentran en los CTFs.

Este año decidí empezar mi blog resolviendo los retos de picoCTF mientras estudio para retos más grandes, por lo que con este post declaro iniciado mi blog e iniciado mi reto con picoCTF 2020.

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
Y esto se extiende cientos de lineas, algo común en ejecutables. Pero si te fijas, hay una linea que nos dice que vamos por el camino correcto `Maybe try the 'strings' function? Take a look at the man page`. Pues bien, ya tenemos todos los strings, pero ¿cuál de todas esas cadenas es la Flag?

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
Podríamos pensar que es otro tipo de codificación para caracteres, pero la verdad es que todas se basan en ASCII por lo que valores más allá de 127 no serán caracteres del alfabeto inglés. Mirando un poco más de cerca los valores a decodificar notamos que no hay ningún 8 o 9, así que se podría tratar de un valor octal, donde el 141 es equivalente a 97 decimal, o _a_ en ASCII. Suena muy bien la idea, así que usaremos [esta página](https://cryptii.com/pipes/decimal-text) que convierte de Octal a ASCII.
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
## flag_shop - 300 points
### Descripción
{{< boxmd >}}
There's a flag shop selling stuff, can you buy a flag? _Source_. Connect with `nc jupiter.challenges.picoctf.org 4906`.
{{< /boxmd >}}
#### Pistas
{{< expand "Pistas" >}}Two's compliment can do some weird things when numbers get really big!{{< /expand >}}
### Procedimiento
Nos proporcionan un código fuente en C que nos explica un poco de qué trata el reto:
``` store.c
#include <stdio.h>
#include <stdlib.h>
int main()
{
    setbuf(stdout, NULL);
    int con;
    con = 0;
    int account_balance = 1100;
    while(con == 0){
        
        printf("Welcome to the flag exchange\n");
        printf("We sell flags\n");

        printf("\n1. Check Account Balance\n");
        printf("\n2. Buy Flags\n");
        printf("\n3. Exit\n");
        int menu;
        printf("\n Enter a menu selection\n");
        fflush(stdin);
        scanf("%d", &menu);
        if(menu == 1){
            printf("\n\n\n Balance: %d \n\n\n", account_balance);
        }
        else if(menu == 2){
            printf("Currently for sale\n");
            printf("1. Defintely not the flag Flag\n");
            printf("2. 1337 Flag\n");
            int auction_choice;
            fflush(stdin);
            scanf("%d", &auction_choice);
            if(auction_choice == 1){
                printf("These knockoff Flags cost 900 each, enter desired quantity\n");
                
                int number_flags = 0;
                fflush(stdin);
                scanf("%d", &number_flags);
                if(number_flags > 0){
                    int total_cost = 0;
                    total_cost = 900*number_flags;
                    printf("\nThe final cost is: %d\n", total_cost);
                    if(total_cost <= account_balance){
                        account_balance = account_balance - total_cost;
                        printf("\nYour current balance after transaction: %d\n\n", account_balance);
                    }
                    else{
                        printf("Not enough funds to complete purchase\n");
                    }
                                    
                    
                }
                    
                    
                    
                
            }
            else if(auction_choice == 2){
                printf("1337 flags cost 100000 dollars, and we only have 1 in stock\n");
                printf("Enter 1 to buy one");
                int bid = 0;
                fflush(stdin);
                scanf("%d", &bid);
                
                if(bid == 1){
                    
                    if(account_balance > 100000){
                        FILE *f = fopen("flag.txt", "r");
                        if(f == NULL){

                            printf("flag not found: please run this on the server\n");
                            exit(0);
                        }
                        char buf[64];
                        fgets(buf, 63, f);
                        printf("YOUR FLAG IS: %s\n", buf);
                        }
                    
                    else{
                        printf("\nNot enough funds for transaction\n\n\n");
                    }}

            }
        }
        else{
            con = 1;
        }

    }
    return 0;
}
```
Solución pendiente :) pero desde ya se ve que trata de explotación binaria por buffer overflow.
## mus1c - 300 points
### Descripción
{{< boxmd >}}I wrote you a _song_. Put it in the picoCTF{} flag format.{{< /boxmd >}}
#### Pistas
{{< expand "Pistas" >}}Do you think you can master rockstar?{{< /expand >}}
### Procedimiento
La _canción_ que se menciona en la descripción es esta:
``` lyrics.txt
Pico's a CTFFFFFFF
my mind is waitin
It's waitin

Put my mind of Pico into This
my flag is not found
put This into my flag
put my flag into Pico


shout Pico
shout Pico
shout Pico

My song's something
put Pico into This

Knock This down, down, down
put This into CTF

shout CTF
my lyric is nothing
Put This without my song into my lyric
Knock my lyric down, down, down

shout my lyric

Put my lyric into This
Put my song with This into my lyric
Knock my lyric down

shout my lyric

Build my lyric up, up ,up

shout my lyric
shout Pico
shout It

Pico CTF is fun
security is important
Fun is fun
Put security with fun into Pico CTF
Build Fun up
shout fun times Pico CTF
put fun times Pico CTF into my song

build it up

shout it
shout it

build it up, up
shout it
shout Pico
```
Como podrán observar, es muy confuso lo que se debería hacer y es aquí donde entra uno de los consejos que da [John Hammond](https://www.youtube.com/user/RootOfTheNull), un famoso youtuber que desde hace años resuelve CTFs, sobre usar google como aliado. Si analizamos un poco más cuidadosamente el archivo nos daremos cuenta que tiene una estructura peculiar, obvio simula estrofas, pero también pareciera un código de programación.
Podríamos guiarnos de ello y buscar en google algún lenguaje que use shout, build, y put, pero en vez de eso podríamos apoyarnos en las Pistas (o hints) que mencionan `master rockstar`. Busquemos eso en google:
{{< img src="/images/picoCTF/mus1c_01.jpg"   position="center" >}}
¡Ahí está! Encontramos el repositorio en GitHub de un Lenguaje de Programación llamado [**Rockstar**](https://github.com/RockstarLang/rockstar). No hay muchas pruebas de que se trate de lo que buscamos, pero mirando las especificaciones nos encontramos con ejemplos como:
``` arrays_Rockstar
Let my string be "abcdefg"
Shout my string at 0 (will print "a")
Shout my string at 1 (will print "b")
Let the character be my string at 2
```
Que nos dicen que en efecto esto es lo que buscamos. Mirando un poco más el repositorio nos encontramos con el compilador [Rocky](https://github.com/gaborsch/rocky) que está basado en Java, así que lo descargamos, compilamos el _.txt_ que tenemos y el resultado es:
{{< boxmd >}}
` > ./rocky.jar programs/lyrics.txt `
114
114
114
111
99
107
110
114
110
48
49
49
51
114
{{< /boxmd >}}
¡Excelente! Si recordamos lo visto en [Based](#based---200-points) y en [Let's Warm Up](#lets-warm-up---50-points) notaremos que estos números son valores de ASCII, por lo que ya sea usando una herramienta online, o de forma manual, llegaremos a el siguiente valor con esos números: `rrrocknrn0113r`
### Solución
{{< box >}}
picoCTF{rrrocknrn0113r}
{{< /box >}}
Lo siguiente fue añadido el 15 de Diciembre del 2020
## 1_wanna_b3_a_r0ck5tar - 350 points
### Descripción
{{< boxmd >}}I wrote you another song. Put the flag in the picoCTF{} flag format{{< /boxmd >}}
### Procedimiento 01
De nueva cuenta nos encontramos con un archivo que asemeja a una canción:
``` lyrics.txt
Rocknroll is right              
Silence is wrong                
A guitar is a six-string        
Tommy's been down               
Music is a billboard-burning razzmatazz!
Listen to the music             
If the music is a guitar                  
Say "Keep on rocking!"                
Listen to the rhythm
If the rhythm without Music is nothing
Tommy is rockin guitar
Shout Tommy!                    
Music is amazing sensation 
Jamming is awesome presence
Scream Music!                   
Scream Jamming!                 
Tommy is playing rock           
Scream Tommy!       
They are dazzled audiences                  
Shout it!
Rock is electric heaven                     
Scream it!
Tommy is jukebox god            
Say it!                                     
Break it down
Shout "Bring on the rock!"
Else Whisper "That ain't it, Chief"                 
Break it down 
```
Análizando más a detalle el texto nos encontramos con estructuras como _if_, también volvemos a ver los _shout_ por lo que sin duda se trata del mismo lenguaje de programación que el anterior reto.
Por desgracia, al intentar ejecutar el archivo con el compilador anteriormente usado nos encontramos con un error de  código que no nos permite avanzar, este error dice específicamente: `Error: BreakStatement cannot be applied to the block at line 25`. Así que tendrémos que buscar otra forma.
Releyendo el repositorio en Github de Rockstar nos encontramos con [interpretes de este lenguaje a otros de uso común](https://github.com/RockstarLang/rockstar#implementations), como JavaScript, Java, Pyton, etc. Por lo que probaremos interpretando el texto a código en Python para ánalizar lo que hace el programa y tal vez poder ejecutarlo sin errores.
El resultado es el siguiente:
``` output.py
Rocknroll = True
Silence = False
a_guitar = 10
Tommy = 44
Music = 170
the_music = input()
if the_music == a_guitar:
    print("Keep on rocking!")
    the_rhythm = input()
    if the_rhythm - Music == False:
        Tommy = 66
        print(Tommy!)
        Music = 79
        Jamming = 78
        print(Music!)
        print(Jamming!)
        Tommy = 74
        print(Tommy!)
        They are dazzled audiences
        print(it!)
        Rock = 86
        print(it!)
        Tommy = 73
        print(it!)
        break
        print("Bring on the rock!")
        Else print("That ain't it, Chief")
        break
```
Por desgracia esto también tiene errores en código, pero al ser un lenguaje más familiar para nosotros podemos corregirlo hasta que logremos hacerlo:
``` output_ejecutable.py
Rocknroll = True
Silence = False
a_guitar = 10
Tommy = 44
Music = 170
the_music = int(input('>'))
if the_music == a_guitar:
    print("Keep on rocking!")
    the_rhythm = int(input('>'))
    if the_rhythm - Music == False:
        Tommy = 66
        print(Tommy)
        Music = 79
        Jamming = 78
        print(Music)
        print(Jamming)
        Tommy = 74
        print(Tommy)
        They = 79       #They are dazzled audiences
        print(They)     #Decía it, pero se refería a Rock.
        Rock = 86
        print(Rock)     #Decía it, pero se refería a Rock.
        Tommy = 73
        print(Tommy)    #Decía it pero se refería a Tommy
        print("Bring on the rock!")
    else:
        print("That ain't it, Chief")
```
Con un formato mucho más fácil de entender vemos que al ejecutar el código se nos pedira introducir un valor, al poner `10` nos pedirá otro número que debe ser `170` y entonces nos retornará una serie de números.
{{< boxmd >}}
cli: > python3 output.py
>10
Keep on rocking!
>170
66
79
78
74
79
86
73
Bring on the rock!
{{< /boxmd >}}
Si tomamos los valores **NO introducidos por nosotros** y los pasamos a ASCII obtendremos la solución del reto.
### Procedimiento 02
Durante el desarrollo de la annterior solución, en el paso de hacer ejecutable el código Python, me encontré con otra solución que nos permite prescindir de Python y el interprete.
En [esta página](https://codewithrockstar.com/docs) podemos encontrar la documentación de Rockstar en un formato más amigable. Lo que nos interesaría es la sección de **Poetic Number Literals** y **Loops**. Después de darles una lectura rápda podemos comprender la falla al ejecutar el código Rockstar original:
- `Break it down` no sirve para cerrar bloques if, debe ser un salto de línea en véz de eso.
- Existen definiciones de números que se reemplazan con texto aleatorio, del cual, para saber su valor, hay que contar las letras del texto de forma que cada palabla es 10 veces mayor a la palabra siguiente. Ej: abrir puerta, donde abrir vale 50 (5 letras) y puerta vale 6 (6 letras y multiplica por 10 a la palabra anterior), resultando en un valor de 56.
Con esto en cuenta y conocimiento fundamental de programación podemos leer, corregir y útilizar el código en lenguaje Rockstar.
``` lyrics.txt
Rocknroll is right              
Silence is wrong                
A guitar is a six-string        
Tommy's been down               
Music is a billboard-burning razzmatazz!
Listen to the music             
If the music is a guitar                  
Say "Keep on rocking!"                
Listen to the rhythm
If the rhythm without Music is nothing
Tommy is rockin guitar
Shout Tommy!                    
Music is amazing sensation 
Jamming is awesome presence
Scream Music!                   
Scream Jamming!                 
Tommy is playing rock           
Scream Tommy!       
They are dazzled audiences                  
Shout it!
Rock is electric heaven                     
Scream it!
Tommy is jukebox god            
Say it!                                     

Shout "Bring on the rock!"
Else Whisper "That ain't it, Chief"                 

```
Obviamente para entenderlo en su totalidad habrá que leer la documentación anterior, pero no resultará en un problema significativo. A demás, en cualquiera de ambos casos habría que leer la documentación pues el interprete Rockstar a Python falla en una línea: `They are dazzled audiences` y para poder corregirla se necesita comprender el lenguaje Rockstar. Si no se corrige esa línea, obtendríamos una solución incompleta.
### Solución
{{< box >}}
picoCTF{BONJOVI}
{{< /box >}}