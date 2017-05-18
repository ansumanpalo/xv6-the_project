#include "types.h"
#include "stat.h"
#include "user.h"
#define countval 3999

void counter(int delay){
    int i , j;
    for(i =0; i< delay; i++){

        for(j=0; j< delay; j++){
            //printf(1,"i: %d j: %d\n",i,j );
        }
    }
}

int
main(int argc, char *argv[])
{
    int i=0;
    int start = uptime();
    int childnum = argc-2;

    int ptemp = uptime() + atoi(argv[1]);
    setdeadline(ptemp);

    int pid;
    for(i=0; i< childnum; i++){
        pid = fork();
        
        if(pid == 0){
            int temp = uptime()+atoi(argv[i+2]);
            setdeadline(temp);
            printf(1,"--------Child %d: Deadline: %d\n", getpid(), temp);
            counter(countval);
            printf(1,"--------Child %d: Exit\n", getpid());
            exit();
        }

        else if(pid > 0){
            printf(1,"-----Parent: %d deadline: %d \n", getpid(), ptemp);
        }

        else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
        for(i=0; i< childnum; i++)
            printf(1,"Parent: Child %d exited \n", wait());
    }
    printf(1,"Parent: Exiting\n");
    printf(1,"%d \n",uptime() - start);
    exit();
}
