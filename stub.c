#include <stdio.h>
#include <stdlib.h>

extern int min_caml_start(char *, char *);

int main() {
  char *hp, *sp;

  sp = malloc(4000000); hp = malloc(4000000);
  if (hp == NULL || sp == NULL) return 1;
  fprintf(stderr, "sp = %p, hp = %p\n", sp, hp);
  min_caml_start(sp, hp);

  return 0;
}
