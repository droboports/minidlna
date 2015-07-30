/* convert icon data for icons.c" */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char *argv[])
{
    int i, c;
    FILE *rfp, *wfp;
    if (argc < 3) {fprintf(stderr, "Usage: %s inputfilename outputfilename\n\n", argv[0]); exit(1);}
    rfp = fopen (argv[1], "rb");
    if (rfp == NULL) {fprintf(stderr, "cannot open \"%s\"\n", argv[1]); exit(1);}
    wfp = fopen (argv[2], "wb");
    if (wfp == NULL) {fprintf(stderr, "cannot create  \"%s\"e\n", argv[2]); exit(1);}
    for (; ;) {
        fprintf(wfp, "             \"");
        for (i=0; i<24 ; i++) {
            c = fgetc(rfp); if (c == EOF) break;
            c = fprintf(wfp, "\\x%02x", c); if (c<0) goto end;
        }
        fprintf(wfp, "\"\n");
        if (c == EOF) break;
    }
end:
    fclose(rfp);
    fclose(wfp);
    exit(0);
}
