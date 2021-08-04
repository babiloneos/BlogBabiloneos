---
title: Atletas - My challenge for a CTF
date: 2021-01-17
description: Along my Academic Exchange I developed a challenge for a CTF.
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
It was 2020 when I had an Academic Exchange oportunity in _Universidad Nacional de La Plata_, Argentina. Unfortunately it coincided with the COVID-19 pandemic's begin, however that didn't stop interesting proyects development, neither the learning possibility, and neither stop me live new experiences.

One of the classes I toke along this Exchange was **Applications secure development** by proffesor Einar Lafranco, a class that covers since free software, until Zero Day vulnerabilities, but with web applications _OWASP Top Ten_ as main subject.

As common in Engineering classes, it wasn't enough with the theoric part. We needed to watch those vulnerabilities in action! That's why a essential part of the course was a CTF tournament with topics as basics as hidding and cryptography until very complex web application challenges (at least for us). And as the perfect close, we had to developed a challenge for the CTF as final project, and that's the context of this articule.

## Atletas
As you can read in the application's [Github repository](https://github.com/babiloneos/Atletas), this has a [vulnerable version](https://github.com/babiloneos/Atletas/tree/master), and a [safe one](https://github.com/babiloneos/Atletas/tree/Seguro). That means, a CTF version, and another one where we fix vulnerabilities to satisfy the course objective.
For the application development we was looking for something not so easy, but neither so hard for our colleagues, so we decided to use classic vulnerabilities: Login page bruteforcing, SQL Injectiuon (even though it was worthless for the challenge), and hidden information in an image. The challenge was to find the right image. 
### Development
As the objective was to practice the course learnings we decided to implement our project over Docker and to use Python and its framework Flask for the development of the application.
#### Login
{{< img src="/images/Atletas/Atletas02.png" position="center" >}}
For the login page it was kind of easy. Over HTML it was just a simple _form_ with user field, password field, and a button. The POST request was easy too, everything was usuall things with the exception of login tries limit. The important think was the users data base. First of all we choiced sqlite because of its easy implementation with python, along its flask implementation wich blocks the acces accross tables, so you won't be able to watch another table if you're consulting the users table. This will allow the users to do a sqlinjection in other pages, but won't allow them to get user's passwords this way. However, and just to be sure, we hashed passwords with SHA-256 algorithm.

{{< img src="/images/Atletas/Atletas03.png" position="center" >}}

Lastly, users and passwords. For users we choiced 2 popular usernames based on [this file](https://github.com/danielmiessler/SecLists/blob/master/Usernames/top-usernames-shortlist.txt) from the repository called **SecLists**, the names were _admin_ and _root_. And for the passwords we used [rockyou.txt](https://github.com/danielmiessler/SecLists/tree/master/Passwords/Leaked-Databases) from the already mentioned repository, but to choice them we used a ridiculous criteria: password number 69 for the _root_ user, and the password number 69420 for the _admin_ user. But this wasn't just because of the numbers, it was also because of the time our colleagues would waste brute forcing the login. If they tried _root_ first (which would be unlikely) they would get in really fast. But if they tried _admin_ first (very likely) they would waste a lot of time reaching the password and getting in. 

Unfortunately we finished as the bad guys because the server where the application was deployed was a potato and only allowed 30 requests per minute, so it was almost imposible to reach the _admin_ password.

#### Buscador
The main interface was a simple athlete searcher, which displayed a picture, name and nationality. Nothing special. This part needed to put the SQL query without any treatment, like this:
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
This way even the mos simple injection would work, allowing us to watch all athletes at once.
{{< img src="/images/Atletas/Atletas04.png" position="center" >}}

#### Flag
Another problem. To discover wich image had the flag hidden you had to find a hidded page inside the application, but this page hadn't any reference along the application. And this page was configured to be displayed only if you was the _admin_ user. This page is /flag, and inside you would find a very nostalgic video from "Courage the Cowardly Dog" but in his latam spanish version, this video would thell us exactly which athlete to search for.


> This is everything I've traslated. Sorry ...
### Walkthrough

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