
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
    int max = -1;
    int mb = 0;
    char* buffer;

    if(argc > 1)
        max = atoi(argv[1]);

    while((buffer=malloc(1024*1024)) != NULL && mb != max) {
        memset(buffer, 0, 1024*1024);
        mb++;
        printf("Allocated %d MB\n", mb);
    }

    return 0;
}


gcc mem.c -o mem

./mem

#finds process and kilss it
#Allocated 19552 MB
#Allocated 19553 MB
#Allocated 19554 MB
#Allocated 19555 MB
#Killed
