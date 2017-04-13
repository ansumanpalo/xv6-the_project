//---------------------------------------
/*
 	The program takes argument separated by space, 
	print them to ouput with 'Hello' in beginning. 
*/
//---------------------------------------

#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{

    int i;
  if(argc < 1){
    exit();
  }
  printf(1, "Hello ");
  for(i = 1; i<argc; i++){
    printf(1, argv[i]);
  }
  printf(1, "\n");
  exit();
}
