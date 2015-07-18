# Demostració d'ús del ! per negar una condició

true    # la funció "builtin"
echo "El valor de sortida de \"true\" = $?"     # 0

! true
echo "El valor de sortida de \"! true\" = $?"   # 1
# Atenció: ! necessita un espai que el separi de la comanda.
# !true   genera un error de comanda desconeguda
# El operador '!' sense separació amb la comanda, invoca el mecanisme 
# d'historial de comandes de Bash.

true
!true
# En aquest cas, no hi ha error, però tampoc no es produeix la negació.
# L'efecte és simplement la repetició de la comanda anterior (true).

# ============================================================================
# Quan precdeim una 'pipe' amb !, s'inverteix el valor que retorna.
ls | comanda_inexistent     # bash: comanda_inexistent: no s'ha trobat l'ordre
echo $?                # 127

! ls | comanda_inexistent   # bash: comanda_inexistent: no s'ha trobat l'ordre
echo $?                # 0
# Fixat que, mentre que ! no ha canviat l'execució de la pipe, si ha modificat
# el valor de retorn.
# ============================================================================
