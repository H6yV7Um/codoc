#!/bin/bash


g++ -o cplus.o -c cplus.cpp
g++ -o foo.o -c foo.c
ar r libc_test.so foo.o cplus.o