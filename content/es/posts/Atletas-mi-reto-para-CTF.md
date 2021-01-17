---
title: Atletas - Mi reto para un CTF
date: 2021-01-17
description: Durante mi movilidad en la UNLP desarrollé una reto para un CTF.
draft: false
author: Guillermo Ballesteros
tags:
- Python
- Docker
- Steganography
categories:
- CTF
- Web Explotaition
series:
- Development
meta_image: images/Atletas/Atletas01.png
image: images/Atletas/Atletas01.png
---
Durante el 2020 tuve la fortuna de realizar una movilidad internacional a la _Universidad Nacional de La Plata_ en Argentina. Por desgracia coincidió con el inicio de la pandemia por el COVID-19, sin embargo eso no impidio el desarrollo de proyectos interesantes, ni la posibilidad de aprender y de vivir nuevas experiencias.

Una de las materias que tomé durante esta movilidad fue **Desarrollo Seguro de Aplicaciones** de la mano del profesor Einar Lafranco, una materia que fue desde el software libre, hasta Vulnerabilidades Zero Day, pero que se enfocó sobre todo en el _Top Ten de OWASP_ para vulnerabilidades en aplicaciones web.

Como debería ser en una materia de Ingeniería, y a la vez en una materia de Informática, no bastó con un cursó teorico. ¡Teniamos que ver estas vulnerabilidades en acción! Por lo que parte fundamental del curso fue un CTF con retos desde lo más sencillo como lo es ocultamiento y criptografía básica, hasta aplicaciones de lo más complejas que nadie logró resolver. Y como cereza en el pastel, de proyecto final se nos pidió desarrollar un reto para el CTF, y es de eso de lo que va este articulo.
## Atletas
Como se puede leer en el [repositorio de Github](https://github.com/babiloneos/Atletas) de la aplicación, este cuenta con una versión [vulnerable](https://github.com/babiloneos/Atletas/tree/master) y otra [segura](https://github.com/babiloneos/Atletas/tree/Seguro). Es decir, una versión útil para el CTF, y otra versión donde arreglamos vulnerabilidades cumpliendo el objetivo de la materia. 
Para el desarrollo de la aplicación no nos quisimos complicar la vida, sin embargo, tampoco se la quisimos dejar fácil a nuestros compañeros, por lo que optamos por vulnerabilidades clásicas: Bruteforcing en el Login, posibilidad de SQLi en el buscador (aunque no es necesario), y ocultamiento en una imagen. El reto aquí era lograr ese Bruteforcing y encontrar la imagen correcta.
### Desarrollo
Debido a que el objetivo era poner en practica lo aprendido en el curso, optamos por apoyarnos en Docker para la aplicación web, utilizando Python y su framework flask para un desarrollo rápido y seguro de la aplicación.
#### Login
{{< img src="/images/Atletas/Atletas02.png" position="center" >}}
Para el Login fue relativamente sencillo. Por la parte de HTML solo se necesitó un _form_ sencillo con usuario, password, y botón. En cuanto a el POST requests tampoco se hizo nada del otro mundo, a excepción de no poner limite de intentos para iniciar sesión. Donde tuvimos que enfocarnos fue en la base de datos para los usuarios. En primer lugar elegimos usar sqlite debido a lo sencillo que es usarlo en Python, a demás en su implementación con Flask tiene un bloqueo de tablas de forma que si haces una inyección sql en la tabla de "productos" (por ejemplo), solo podrás ver esa tabla y no te dejará acceder a ningun otra tabla. Esto nos serviría para que pudieran hacer una inyección sql dentro del sistema pero que no pudieran acceder a los usuarios y contraseñas. Pero igual, y por si las dudas, pusimos las contraseñas en SHA256.

{{< img src="/images/Atletas/Atletas03.png" position="center" >}}

Y por último, los usuarios y contraseñas. Para los usuario se recurrió a los dos nombres de usuario más populares según [este archivo](https://github.com/danielmiessler/SecLists/blob/master/Usernames/top-usernames-shortlist.txt) del famoso repositorio de Github **SecLists**, los cuales son _admin_ y _root_. Y para las contraseñas usamos [la lista RockYou](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Leaked-Databases) del mismo repositorio, pero en este caso usamos un criterio más ridiculo para la selección: la contraseña número 69 para _root_ y la número 69420 para _admin_. Ahora, no solo fue por los números, también por el tiempo que tomaría llegar a las contraseñas, pues no creimos que nuestros compañeros llegaran a intentar el usuario root, pero si lo hacían entrarían rápido an sistema. Sin embargo, estabamos seguros de que intentarían usar el usuario Admin, por lo que hicimos que si era así, les costara mucho tiempo llegar a la respuesta.

Por desgracia aquí terminamos viendonos como los malos de la historia debido a que el servidor donde se publicó el reto resultó ser muy lento y no se podían hacer más que 30 request por minuto, así que para llegar a la contraseña 69420 resultaba eterno y había que rogar que el servidor no se callera.

#### Buscador
La interfaz real de la aplicación era un buscador simple que mostraba Atletas con su nombre y nacionalidad. Nada del otro mundo. Para esta parte no hizo falta nada más que poner el query plano en la configuración de la página, de esta forma:
``` app.py
@app.route('/buscador', methods=['POST', 'GET'])
def buscador():
    buscador_form = forms.BuscadorForm(request.form)
    buscar = request.args.get('Buscar')
    resultado = None
    if request.method == "GET" and buscar is not None:
        if buscar.isspace():
            error_message="Busqueda vacía."
            flash(error_message)
            buscar=None
        else:
            connection = db.engine.connect()
            resultado = connection.execute(
            "SELECT * FROM 'atletas' where nombre like '%"+buscar+"%' or pais like '%"+buscar+"%' ORDER BY atletas.nombre ASC")
            return render_template('buscador.html', busqueda=buscar, resultado=resultado, form=buscador_form)
    return render_template('buscador.html', busqueda=buscar, form=buscador_form)
```
Así hasta la inyección más sencilla funcionaría, y nos servía para ver todos los atletas disponibles con la famosa **' or 1=1'**.
{{< img src="/images/Atletas/Atletas04.png" position="center" >}}

#### Flag
Otra parte donde nos vimos como los malos de la historia. Para descrubrir qué imagen era la que tendría la Flag del reto había que encontrar una página oculta dentro de la app, pero esta página no era referida en ninguna parte de las páginas hasta ahora vistas, por lo que era cosa de curiosidad y suerte. Esta página era /flag, y dentro encontrarías un vídeo de la nostalgica serie "Cobarde el perro valiente" que nos daría una pista inconfundible de dónde buscar. Sin embargo, aquí vino la segunda falla, esta página solo mostraba el vídeo si estabas logueado como _admin_ y no como root, por lo que aquellos que no tuvieran paciencia nunca encontrarían esta pista. O al menos eso teníamos en mente hasta que supimos sobre los problemas con el servidor que ya he mencionado.

### Walkthrough
No hay mucho más que decir sobre la funcionalidad de la app, así que ahora hablaremos de el proceso completo para llegar a la flag.

#### Login
Dado que el objetivo aquí es hacer bruteforce usaremos hydra.
Desde el navegador revisamos que las credenciales se envían por POST en el formato `username=admin&password=admin`, y que recibimos el mensaje `Usuario o contraseña incorrecto.`
El comando para obtener la contraseña y que funcionó para _root_ y para _admin_ es el siguiente:
``` 
hydra -l root -P /usr/share/wordlists/rockyou.txt -f localhost -s 5000 http-post-form "/login:username=^USER^&password=^PASS^:Usuario o contraseña incorrecto."
```
Sin embargo hay que aclarar que yo estoy usando la aplicación en mi localhost por el puerto 5000, así que tal vez para alguien que lo publique, o use otro puerto deberá haber cambios en el comando.

#### Flag
Para la flag se va a intentar un método que aprendí hace poco, el llamado Fuzzing. Básicamente lo que haremos será usar un sofftware que hara peticiones a el dominio que queramos agregandole cosas como "index", "config", "static", etc al final para probar si existen esas páginas que son tan comunes.
Primero usaremos la herramienta **gobuster**, y la lista `big.txt` que también pertenece a el repositorio **SecList** y se puede conseguir [aqui](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/big.txt).
El comando es:
``` 
gobuster dir -u http://localhost:5000 -w /usr/share/wordlists/dirb/big.txt 
```
{{< img src="/images/Atletas/Atletas05.png" position="center" >}}

La segunda herramienta es **wfuzz** que de igual forma verifica nombres comunes de paginas en base a una lista. Usaremos la misma lista que en la anterior herramienta. El comando sería:
``` 
wfuzz -c -z file,/usr/share/wordlists/dirb/big.txt --hc=404 localhost:5000/FUZZ
```
{{< img src="/images/Atletas/Atletas06.png" position="center" >}}

#### Ocultamiento
Como se mencionó antes, el proceso erá: Bruteforce al login, entrar a _/flag_, y finalmente sacar la Flag de la imagen indicada. Bien, pues en /flag se puede ver el siguiente vídeo:
{<iframe width="560" height="315" src="https://www.youtube.com/embed/QJD6mT8u6fA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>}
El único atleta que se menciona en el vídeo es Diego Armando Maradona, por lo que debemos descargar su imagen y pasarla por alguna herramienta de ocultamiento. Nosotros usamos **steghide** para ocultar la bandera, por lo que será el mismo programa que usaremos para obtener la bandera. No sebería ser un problema terminar usando esta herramienta pues es de las más populares en los CTFs.
El comando es:
``` 
steghide --extract -sf Descargas/maradona.jpeg -xf flag.txt -p ""
```
Esto nos daría la flag en un archivo de texto llamado `flag.txt` cuyo contenido es:
``` flag.txt
flag{FLAG}
```

### Asegurando la aplicación
No puedo concluir el articulo sin antes mencionar los métodos que se usaron para hacer segura la aplicación.

Primero se metió un límite de intentos al login. Esto fue tan sencillo como agregar un contador a la cookie de sessión, que por cierto está cifrada, para que al 3er intento fallido se dejen de permitir logueos. Esto en una aplicación real tendría que cambiarse a una suspención temporal de la cuenta hasta que, por medio del correo electrónico del usuario, se verifique que todo está bien, y si se puede, incluso después de forzar un cambio de contraseña.

Después, en el buscador, simplemente se utilizo la query integrada de Flask para evitar la inyección SQL. Esta query lo que hace es "sanitizar" el input del usuario antes de meterlo en la query, así se evitan caracteres raros o comportamientos no deseados.

También, para evitar que herramientas como gobuster o wfuzz realmente funcionen, se podría hacer que las páginas que requieren estar logueado manden un error 404 cuando se trata de acceder a ellas sin estar logueado.

Y finalmente, lo ideal, sería poner un limite de peticiones por minuto para un usuario, y un bloqueo de IP en caso de ser necesario por medio de un Firewall, pero eso ya va más allá de la aplicación.

Para más detalles de cómo hicimos segura la aplicación, pueden verlo en el repositorio de github en el [branch seguro](https://github.com/babiloneos/Atletas/tree/Seguro).

### Conclusión
Hacer retos para CTF no es fácil, pero es muy útil cuando uno quiere entender cómo es que una vulnerailidad funciona, cuál es la perspecctiva del desarrollador, cuáles son sus errores, y cómo podemos guíarlo para evitar o enmendar esos errores.

Veo en los CTFs una oportunidad inmensa de aprendizaje para los estudiantes, tanto por el aspecto teorico, practico, como en las habilidades con herramientas, la linea de comandos, y las OSINT. Me pareció increible y muy acertado que la UNLP implementara esta actividad, permitiendonos aprender, mientras nos divertimos. Y es que es súper importante recordar que la mejor forma de aprender es haciendo las cosas de una forma divertida.