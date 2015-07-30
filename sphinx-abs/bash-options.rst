#########################################
G.2. Opcions de la línia de comandes Bash
#########################################

*Bash* per si mateix te una sèrie d'opcions a la línia de comandes. Aquestes són algunes de les més útils.


-  ``        -c       ``

   *Llegir comandes de la següent cadena i assignar qualsevol argument als
   `paràmetres posicionals <internalvariables.html#POSPARAMREF>`__ .*


   .. code-block:: sh

       bash$ bash -c 'set a b c d; IFS="+-;"; echo "$*"'
       a+b+c+d




-  ``        -r       ``

   ``        --restricted       ``

   Executar la shell, o un guió en `mode restringit <restricted-sh.html#RESTRICTEDSHREF>`__ .


-  ``        --posix       ``

   Obliga a Bash a ajustar-se a l'estàndard `POSIX <sha-bang.html#POSIX2REF>`__ .

-  ``        --version       ``

   *Mostrar per pantalla informació de la versió i sortirda.*

-  ``        --       ``

   *Fi d'opcions. Qualsevol cosa més enllá en la línia de comandes és un argument, no una opció.*


