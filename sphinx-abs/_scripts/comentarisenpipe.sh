# Construïm un fitxer amb alguns comentaris
cat > /tmp/fitxer << FINAL
Aquesta es mostra
# Aquesta no
Aquesta també # es mostra
   # Aquesta tampoc
FINAL

# Mostrem el fitxer sense línies de comentaris
cat /tmp/fitxer |\
# eliminem les línies de comentaris
sed -e '/^\s*#/d'
# Mostrarà:
#   Aquesta es mostra
#   Aquesta també # es mostra

