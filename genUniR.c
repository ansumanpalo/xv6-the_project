#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    int a = atoi(argv[1]), b = atoi(argv[2]);
    int i;
    for(i=0; i< b-a+1; i++)
        printf(1,"%d \n",uniformR(a,b));

    exit();
}

