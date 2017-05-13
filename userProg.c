#include "types.h"
#include "stat.h"
#include "user.h"

int nextprocessbirthtime(int, int);
int processruntime(int, int);
char* itoa(int, int);

int
main(int argc, char *argv[])
{
    int start = uptime();
    int minp_time = atoi(argv[1]), maxp_time = atoi(argv[2]);
    int minp_runtime = atoi(argv[3]), maxp_runtime = atoi(argv[4]);
    int maxnum_processes = atoi(argv[5]);

    int nextTime = nextprocessbirthtime(minp_time, maxp_time);
    int runTime = processruntime(minp_runtime, maxp_runtime);


    printf(1,"Parent %d: Sleeping %d \n",getpid(), nextTime);
    sleep(1000*nextTime/14);

    int i;
    int pid;
    for(i=0; i< maxnum_processes; i++){
        pid = fork();
        if(pid == 0){
            runTime = processruntime(minp_runtime, maxp_runtime);
            printf(1,"Child %d: Sleeping for %d sec \n", getpid(),runTime);
            char *arg[3];
            arg[0] = "sleepN";
            arg[1] = itoa(runTime, 10);
            arg[2] = 0;
            exec("sleepN",arg);
        }else if(pid > 0){
            nextTime = nextprocessbirthtime(minp_time, maxp_time);
            printf(1,"Parent: Sleeping %d \n", nextTime);
            sleep(1000*nextTime/14);
            //wait();
        }else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
        for(i=0; i< maxnum_processes; i++)
            printf(1,"Parent: Child %d exited \n", wait());
    }
    printf(1,"Parent: Exiting\n");
    printf(1,"%d \n",(uptime() - start)/72);
    exit();
}

int
nextprocessbirthtime(int min, int max){
    return uniformR(min, max);

}

int
processruntime(int min, int max){
    return uniformR(min, max);

}

