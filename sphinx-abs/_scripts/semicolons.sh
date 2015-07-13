# Exemples d'ús del punt i coma per concatenar comandes en la mateixa
# línia

echo hola; echo gent

if [ -x "$nomfitxer" ]; then
#+                   ^^ Fixat en l'espai després del punt i coma
  echo "El fitxer $nomfitxer existeix"; cp $nomfitxer $nomfitxer
else   #                       ^^
  echo "El fitxer $nomfitxer no s'ha trobat."; touch $nomfitxer
fi; echo "Completat el test del fitxer"

