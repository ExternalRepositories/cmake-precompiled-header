#ifndef PCH
#define PCH 1
#ifdef __cplusplus
#include <cstdlib>
#include <iostream>

#if __cplusplus < 201400L
#error This PCH has to be compiled in C++14 mode
#endif

#if __cplusplus > 201412L
#error This PCH has to be compiled in C++14 mode
#endif

#else
#include <stdlib.h>
#endif
#endif
