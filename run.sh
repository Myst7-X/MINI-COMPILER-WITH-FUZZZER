bison -d Parser.y                           
flex Scanner.l         
afl-cc lex.yy.c Parser.tab.c -o compiler_afl -lm

cat << 'EOF' > fuzzme.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char input[100];
    if (!fgets(input, sizeof(input), stdin)) return 0;

    if (strcmp(input, "FUZZME\n") == 0) {
        fprintf(stderr, "🔥 Crash triggered! 💥\n");
        abort();
    }

    printf("Input was: %s", input);
    return 0;
}
EOF

afl-cc fuzzme.c -o fuzzme_afl
mkdir -p inputs
echo "FUZZME" > inputs/test 
afl-fuzz -i inputs -o outputs ./fuzzme_afl
