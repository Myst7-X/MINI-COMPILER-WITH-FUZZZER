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
