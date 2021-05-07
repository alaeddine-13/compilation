flex main.l
bison -d syntaxique.y
gcc -o main syntaxique.tab.c lex.yy.c
echo "source.pasc"
./main <source.pasc