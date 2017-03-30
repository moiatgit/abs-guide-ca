#!/bin/bash

# XXX TODO: translate-me! (I'm just translating variable names by now!)

# ---------------------------------------------
# El contingut d'aquest fitxer pot ser carregat (sourced) des d'un fitxer
# separat.
isdnElMeuProveidorRemot=172.16.0.100
isdnElTeuProveidorRemot=10.0.0.10
isdnServeiOnline="MyProvider"
# ---------------------------------------------


xarxaRemota=$(eval "echo \$$(echo isdn${isdnServeiOnline}xarxaRemota)")
xarxaRemota=$(eval "echo \$$(echo isdnElMeuProveidorRemot)")
xarxaRemota=$(eval "echo \$isdnElMeuProveidorRemot")
xarxaRemota=$(eval "echo $isdnElMeuProveidorRemot")

echo "$xarxaRemota"    # 172.16.0.100

# ================================================================

#  I encara pot ser millor.

#  Consider the following snippet given a variable named getSparc,
#+ but no such variable getIa64:

chkMirrorArchs () {
    arch="$1";
    if [ "$(eval "echo \${$(echo get$(echo -ne $arch
        sed 's/^\(.\).*/\1/g'tr 'a-z' 'A-Z'; echo $arch
        sed 's/^.\(.*\)/\1/g')):-false}")" = true ]
    then
        return 0;
    else
        return 1;
    fi;
}

getSparc="true"
unset getIa64
chkMirrorArchs sparc
echo $?        # 0
# True

chkMirrorArchs Ia64
echo $?        # 1
# False

# Notes:
# -----
# Even the to-be-substituted variable name part is built explicitly.
# The parameters to the chkMirrorArchs calls are all lower case.
# The variable name is composed of two parts: "get" and "Sparc" . . .




