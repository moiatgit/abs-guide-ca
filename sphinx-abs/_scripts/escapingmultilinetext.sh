# XXX Demostració de text en més d'una línia

echo "foo
bar"
#foo
#bar

echo

echo 'foo
bar'    # No difference yet.
#foo
#bar

echo

echo foo\
    bar     # Newline escaped.
#foobar

echo

echo "foo\
    bar"     # Same here, as \ still interpreted as escape within weak quotes.
#foobar

echo

echo 'foo\
    bar'     # Escape character \ taken literally because of strong quoting.
#foo\
    #bar

# Examples suggested by Stéphane Chazelas.


