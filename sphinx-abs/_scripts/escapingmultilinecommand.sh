# XXX Demostració d'ús de \ per construir comandes en més d'una línia

(cd /source/directory && tar cf - . )\
    (cd /dest/directory && tar xpvf -)
# Repeating Alan Cox's directory tree copy command,
# but split into two lines for increased legibility.

# As an alternative:
tar cf - -C /source/directory .
tar xpvf - -C /dest/directory
# See note below.
# (Thanks, Stéphane Chazelas.)


