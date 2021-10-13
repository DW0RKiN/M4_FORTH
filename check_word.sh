#!/bin/sh

printf "include(\`../M4/FIRST.M4')dnl\n$1\n" | m4
