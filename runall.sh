#!/bin/sh -exu
set -e

: "${generator:=Unix Makefiles}"

buildroot=$(dirname $(readlink -f $0))/build
mkdir -p "$buildroot"
for test in $(ls test); do

  if [ "$#" == "1" ] && [ "$1" != "$test" ]; then continue; fi
  source="$buildroot/$test-$generator-source"
  build="$buildroot/$test-$generator-build"
  [ -e "$source" ] && rm -rf "$source"
  [ -e "$build" ] && rm -rf "$build"
  echo "$source" "$build"
  cp -ra "test/$test" "$source"
  mkdir -p "$build"
  (cd "$build"
   # Generate, compile, test
   echo cmake -G "$generator" "$source"
   cmake -G "$generator" "$source"
   cp -a "$source/test-pch.h" "$source/test-pch-old.h"
   cmake --build .
   EXPECTED_PCH=1 ctest
   # Modify PCH, compile, test (dependencies should work)
   sleep 1
   echo "#undef PCH" >> "$source/test-pch.h"
   echo "#define PCH 2" >> "$source/test-pch.h"
   cmake --build .
   EXPECTED_PCH=2 ctest
   # Restore PCH with old timestamp (already compiled PCH should be used)
   sleep 1
   cp -a "$source/test-pch-old.h" "$source/test-pch.h"
   [ -f "$source/test.c" ] && touch "$source/test.c"
   [ -f "$source/test.cpp" ] && touch "$source/test.cpp"
   cmake --build .
   EXPECTED_PCH=2 ctest)
done
