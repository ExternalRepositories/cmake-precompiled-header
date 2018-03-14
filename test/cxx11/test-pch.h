#define PCH 1
#ifdef __cplusplus
#include <cstdlib>
#include <iostream>

#if __cplusplus < 201100L
#error This PCH has to be compiled in C++11 mode
#endif

#if __cplusplus > 201112L
#error This PCH has to be compiled in C++11 mode
#endif

#else
#include <stdlib.h>
#endif
