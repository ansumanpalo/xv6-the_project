//---------------------------------------
/*
 	The program is uses sleep() system call to sleep for seconds passed as data.
	It has been found by multiple iterations that when sleep(1000) is called then
	process sleep for nearly 14 seconds. Using this data the program implement 
	specified problem.
*/
//---------------------------------------

#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{

  if(argc < 1){
    exit();
  }
  int i = atoi(argv[1]);
  sleep(1000*i/14);
  exit();
}
