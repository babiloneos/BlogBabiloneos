---
title: Solving General Skills - picoCTF 2020
date: 2020-12-07
description: picoCTF 2020 General Skill's challenges writeups.
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
Year after year Carnegie Mellon University organize picoCTF, a CTF with challenges from the very basic to advanced, and at the end of the competition all is put to Internet so it can be solved by anyone.
The most interesting thing of this CTF is the amount of challenge and the variety. It has exploitation Web, criptography, reverse engineering, forensic, binary exploitation and general skills. Those are, generally, all the challenge's category on any CTF.
This year I decided to start my blog by solving some picoCTF's challenges while i'm studying for bigger challenges, so with this post I begin my blog and my picoCTF 2020 challenge.
## 2Warm - 50 points
### Description
{{< boxmd >}}
Can you convert the number 42 (base 10) to binary (base 2)? 
{{< /boxmd >}}
### Procedure
This challenge is the easiest, all we have to know is the conversion of numbers by base or even easier, have a calculator. I'll use my computer calculator in programmer mode. I just put the decimal value 42 and the calculator return us the same value but in binary.
{{< img src="/images/picoCTF/2Warm_01.jpg" title="Calculadora"  position="center" >}}
As seen, the solution is 101010 but we have to put it in the CTF format, as in any other CTF.
### Solution
{{< box >}}
picoCTF{101010} 
{{< /box >}}
## ::: Translation pending!!!
## Warmed Up - 50 points
### Description
{{< boxmd >}}
What is 0x3D (base 16) in decimal (base 10)?
{{< /boxmd >}}
### Procedure
Another easy challenge abput changing numbers base. Just as before, I'll use my computer's calculator.
{{< img src="/images/picoCTF/WarmUp_01.jpg" title="Calculadora"  position="center" >}}
### Solution
{{< box >}}
picoCTF{61} 
{{< /box >}}
## Lets Warm Up - 50 points
### Description
{{< boxmd >}}
If I told you a word started with 0x70 in hexadecimal, what would it start with in ASCII? 
{{< /boxmd >}}
### Procedure
In this case is not change of number base, but a conversion of values. This conversion is as simple as look up in a table for the 0x70 value. Specifically, the ASCII table, jus like this one:
{{< img src="/images/picoCTF/LetsWarmUp_01.jpg" title="TablaASCII"  position="center" >}}
### Solution
{{< box >}}
picoCTF{p} 
{{< /box >}}
## Strings it - 100 points
### Description
{{< boxmd >}}
Can you find the flag in file without running it?
{{< /boxmd >}}
### Procedure
The refered file is a _.deb_ executable file. Also, this challenge's name tell us what to do. There is a bash command called _strings_ which returns every character string in any file. Used in this _.deb_ file we get:
``` [ strings ]
~/Downloads/picoCTF2020 > strings bat_0.17.1_amd64.deb
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
And this continued by hundred of lines, something usual in executable files. But if you look closelly at it, there's a line telling us we are in the right path `Maybe try the 'strings' function? Take a look at the man page`. Well then, we have all the strings, but which one is the Flag?
As I told earlier, every CTF has his own Flag format, `picoCTF{FLAG}` in this case. And in challenges like this one, we will usually find the flag in that format. So we should search for some line which begins with _picoCTF_, a task that we can solve with the command `grep` using it like this:
`greo "picoCTF"`
If we take the output of the `strings` command and send it to `grep` we'll surelly find the solution:
{{< img src="/images/picoCTF/StringsIt_01.jpg"   position="center" >}}
And we do.
### Solution
{{< box >}}
picoCTF{5tRIng5_1T_827aee91}
{{< /box >}}
## Bases - 100 points
### Description
{{< boxmd >}}
What does this **bDNhcm5fdGgzX3IwcDM1** mean? I think it has something to do with bases.
{{< /boxmd >}}
### Procedure
Again, we found a hint in the name of the challenge. This time is about bases, a kind of criptography or hiding based on taking an array of characters, get its binary value of all them togethern then dividing them on groups of 6 bits an geting the character of every 6-bit value. You can learn more in [this wikipedia's example](https://en.wikipedia.org/wiki/Base64#Examples).
For this kind of challenge I usually use online tools, because is easier and faster. As we're talking about bases, the most used is Base64, so it'll be the first to test, using the page [base64decode](https://www.base64decode.org/), where you just have to paste your encoded string and push the DECODE button.
{{< img src="/images/picoCTF/Base_01.jpg" position="center" >}}
The result looks kinda weird, but replacing the numbers for letters you can find some interesting text, which indicates we find the solution.
### Solution
{{< box >}}
picoCTF{l3arn_th3_r0p35}
{{< /box >}}
## First Grep - 100 points
### Description
{{< boxmd >}}
Can you find the flag in _file_? This would be really tedious to look through manually, something tells me there is a better way.
{{< /boxmd >}}
### Procedure
This challenge is like [*strings*](#strings-it---100-points), and even the name tells us what to do, again using _grep_. However this time it's not an executable file, but a text file so depiste the _strings_ command being useful, it would be ideal to use the `cat` command.
The real purpose of `cat` command is to concatenate two files content, and show the result as the output, however, if you get only one file as argument it will shows the file content as output. Using that output with `grep` we'll get a result like the [*strings*](#strings-it---100-points) one. The final command should be like this:
``` 
cat file | grep "picoCTF"
```
{{< img src="/images/picoCTF/FirstGrep_01.jpg"   position="center" >}}
### Solution
{{< box >}}
picoCTF{grep_is_good_to_find_things_dba08a45}
{{< /box >}}
## whay's a net cat? - 100 points
### Description
{{< boxmd >}}
Using netcat (nc) is going to be pretty important. Can you connect to _jupiter.challenges.picoctf.org_ at port _64287_ to get the flag?
{{< /boxmd >}}
### Procedure
This time all is cleare since the name and the description: we have tod use `netcat` with the given url and port.
Netcat is a tool that allows us to associate a script, placed on the port of a remote computer, with our computer. The way we should use it is:
```
nc jupiter.challenges.picoctf.org 64287
```
{{< img src="/images/picoCTF/whatsanetcat_01.jpg"   position="center" >}}
### Solution
{{< box >}}
picoCTF{nEtCat_Mast3ry_284be8f7}
{{< /boxmd >}}
## plumbing - 200 points
### Description
Sometimes you need to handle process data outside of a file. Can you find a way to keep the output from this program and search for the flag? Connect to _jupiter.challenges.picoctf.org 7480_.
### Procedure
For the first we can't know what to do by the name or description. However we remember the use of `grep` and `nc`. My first idea was to check the netcat output:
{{< img src="/images/picoCTF/plumbing_01.jpg"   position="center" >}}
The output is long and repites himself. Following my idea we should send this output to `grep` so we can find a line starting with _picoCTF_:
```
nc jupiter.challenges.picoctf.org 7480 | grep "picoCTF"
```
{{< img src="/images/picoCTF/plumbing_02.jpg"   position="center" >}}
And it works. As we can see, we're able to sent any output to `grep`.
### Solution
{{< box >}}
picoCTF{digital_plumb3r_06e9d954}
{{< /box>}}
## Based - 200 points
### Description
{{< boxmd >}}
To get truly 1337, you must understand different data encodings, such as hexadecimal or binary. Can you get the flag from this program to prove you are on the way to becoming 1337? Connect with _nc jupiter.challenges.picoctf.org 29221_.
{{< /boxmd >}}
### Procedure
To know what are we confrontint to I'll use netcat to see what it shows:
{{< img src="/images/picoCTF/Based_01.jpg"   position="center" >}}
So this is a time challenge, and at least the first part ask us for a value conversion. I had two ideas: do one by one manually, or write a script on python or bash that solves it for us. I chose the first one to do it quicker, and to do it I'll use online tools.
#### First Step
For the binary balue I'll use this [Binary to String page](https://codebeautify.org/binary-string-converter):
{{< img src="/images/picoCTF/Based_02.jpg"   position="center" >}}
Good! We have the first word `street`. When we send it we get this answere:
{{< box >}}
Please give me the  163 154 165 144 147 145 as a word.
Input:
{{< /box >}}
#### Second Step
This word have values between 140 and 170, so I think it could be decimal values from some ASCII characters, but checking the ASCII table (you can find it in [Lets Warm Up](#lets-warm-up---50-points)) we notice there is only values under 127, so this isn't the way.
It could be other character codification, but all those codifications are based on ASCII, so values over 127 will not be characters from the English alphabet. Looking again I noticed there is no number bigger than 7, so they could be some octal values where octal 141 is decimal 97, or an _a_ in ASCII. It sounds right so we'll use [this web page](https://cryptii.com/pipes/decimal-text) that converts from octal to ASCII.
{{< img src="/images/picoCTF/Based_03.jpg"   position="center" >}}
When we send the word we haver this answer:
{{< box >}}
Please give me the 736f636b6574 as a word.
Input:
{{< /box >}}
#### Third Step
So now there are numbers and letters in the word. The letters looks like the first one of the alphabet, and also there are an even number of characters in the word. All of this makes me think in Hexadecimal, which would have sense if we follow the pattern of the last steps.
Using the same tool than the last step we get:
{{< img src="/images/picoCTF/Based_04.jpg"   position="center" >}}
Cool! we send it and get:
### Solution
{{< box >}}
You've beaten the challenge
Flag: picoCTF{learning_about_converting_values_00a975ff}
{{< /box >}}
## flag_shop - 300 points
### Description
{{< boxmd >}}
There's a flag shop selling stuff, can you buy a flag? _Source_. Connect with `nc jupiter.challenges.picoctf.org 4906`.
{{< /boxmd >}}
#### Pistas
{{< expand "Pistas" >}}Two's compliment can do some weird things when numbers get really big!{{< /expand >}}
### Procedure
We get a C script who explains what is about the challenge:
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
Pending solution :) but it is a binary exploitation based in Buffer Overflow.
## mus1c - 300 points
### Description
{{< boxmd >}}I wrote you a _song_. Put it in the picoCTF{} flag format.{{< /boxmd >}}
#### Pistas
{{< expand "Pistas" >}}Do you think you can master rockstar?{{< /expand >}}
### Procedure
The song the descriptions talks about is this one:
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
As you can see is very confusing what we should do here, so i'll use the [John Hammond](https://www.youtube.com/user/RootOfTheNull) tips. He is a famous youtuber who solves a lot of CTFs and he sais that we have to use google as our ally. If we chek it carfully we should see that the song has a structure similar to a programming code, so we could search some language that use words like _shout, biuld_ and _put_, but it doesn't sound very convenient. However, we could use the hints, specifically the `master rockstar` part. Let's search on Google:
{{< img src="/images/picoCTF/mus1c_01.jpg"   position="center" >}}
And there it is, we found a Github repository about a programming language called [**Rockstar**](https://github.com/RockstarLang/rockstar). If we look it we'll find some examples as:
``` arrays_Rockstar
Let my string be "abcdefg"
Shout my string at 0 (will print "a")
Shout my string at 1 (will print "b")
Let the character be my string at 2
```
So this is what we are looking for. Searching in the repository we found a compiler called [Rocky](https://github.com/gaborsch/rocky) which is based on Java, so we downloading it and compile the _.txt_:
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
Nice! If we remember what we watched in [Based](#based---200-points) and in [Let's Warm Up](#lets-warm-up---50-points) we'll note this numbers are ASCII values, so we use an online tool to get the string `rrrocknrn0113r`.
### Solution
{{< box >}}
picoCTF{rrrocknrn0113r}
{{< /box >}}
## 1_wanna_b3_a_r0ck5tar - 350 points
### Description
{{< boxmd >}}I wrote you another song. Put the flag in the picoCTF{} flag format{{< /boxmd >}}
### Procedure 01
Again, we have a song file:
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
Analyzing  closelly the text we found structures like _if_, and again _shout_ so this is the same programming language than the last challenge.
Unfortunatelly, when we try to compile the file we get a code error: `Error: BreakStatement cannot be applied to the block at line 25`, so we'll have to search another way.
Reading the repository of Rockstar we found some [interpreters of this language to others commonly used](https://github.com/RockstarLang/rockstar#implementations) like Javascript, Java, Python, etc. We'll try using this to translate to Python so we can analize the code and maybe execute it without errors.
This compiler returns this:
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
This code has errors too. But, as Python is a well known language, we can fix it until we get something like this:
``` output_executable.py
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
        print(They)     #Changed from 'it', it meant 'They'.
        Rock = 86
        print(Rock)     #Changed from 'it', it meant 'Rock'.
        Tommy = 73
        print(Tommy)    #Changed from 'it', it meant 'Tommy'.
        print("Bring on the rock!")
    else:
        print("That ain't it, Chief")
```
With this easier format we can understand what happens when we execute the code. It will ask us to input `10`, then `170` and only then we'll receive this numbers serie:
{{< boxmd >}}
cli: $ python3 output.py
$ 10
Keep on rocking!
$ 170
66
79
78
74
79
86
73
Bring on the rock!
{{< /boxmd >}}
If we use this last values returned in the execution and translate them to ASCII values we get the solution.
### Procedure 02
As I solved the challenge with the previous process I came across another method that leads us to the solution. This new solution allow us to avoid Python and go on just with the _.txt_ gived as in the last challenge.
In [this page](https://codewithrockstar.com/docs) we can find the Rockstar's documentation in a very friendly format. What we are looking for are the sections called **Poetic Number Literals** and **Loops**. After a brief read we can undersand the error in the Rockstar code:
- `Break it down` doesn't works to close 'if' blocks, it has to be a line break.
- There are number definitions that are replaced with random text, where the compile counts the letters of every word and the amount of letters is the number defined and every word position defines how much times the number is multiplied by 10. For example, `open the door`, where `open` value is 400 because it has 4 letters and is the first of three words getting then the hundreds position, `the` value is 30 as it has 3 letters ans has the decimals position and `door` value is 4 as it has 4 letters ans has the units position. So `open the door` is equal to 434 for the Rockstar compiler.
Now we can fix the _.txt._ so it can be compile without errors.
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
This code is now completely executable and to get the solution we just have to follow the execution done with python.
Obviously to completly understand the code we have to read all the documentation, but it is an insignificant problem. Also, in both solutions we have to read that documentation because the Python interpreter fails in the line `They are dazzled audiences`  and to be able to fix it we need to understand the Rockstar Language. If this line isn't fixed we would get an incomplete solution.
### Solution
{{< box >}}
picoCTF{BONJOVI}
{{< /box >}}