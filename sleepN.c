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
