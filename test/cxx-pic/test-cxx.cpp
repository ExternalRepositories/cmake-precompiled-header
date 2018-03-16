#include "test-pch.h"
#ifndef PCH
#error Missing precompiled header
#endif
int main() { return foo() == 1 && !(PCH == atoi(getenv("EXPECTED_PCH"))); }
