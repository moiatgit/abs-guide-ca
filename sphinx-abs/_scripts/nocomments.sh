# A continuació alguns exemples en els que # no inicia un comentari

echo "Aquest # no inicia un comentari."
echo 'Aquest # tampoc no inicia un comentari.'
echo Aquest \# tampoc no inicia un comentari.
echo En canvi aquest # sí que inicia un comentari.

echo ${PATH#*:}       # Una substitució de paràmetre, no un comentari
echo $(( 2#101011 ))  # Una conversió de base, no un comentari
