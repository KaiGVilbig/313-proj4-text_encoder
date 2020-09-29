#include <stdio.h>
#include <math.h>

int root(int num)
{
  float n = (float)num;
  float x = sqrtf(n);
  x = (int)floor(x);
  int ix = (int)x;
  
  return(ix);
}
