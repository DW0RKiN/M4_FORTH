/* Forth nesting (NEXT() Benchmark     cas20101204 () */

#include <stdio.h> 

int bottom() {}    
int _1st()  {bottom(); bottom(); } int  _2nd() {  _1st();  _1st(); }  int  _3rd() {  _2nd();  _2nd(); }
int _4th()  { _3rd();    _3rd(); } int  _5th() {  _4th();  _4th(); }  int  _6th() {  _5th();  _5th(); }
int _7th()  { _6th();    _6th(); } int  _8th() {  _7th();  _7th(); }  int  _9th() {  _8th();  _8th(); }
int _10th() { _9th();    _9th(); } int _11th() { _10th(); _10th(); }  int _12th() { _11th(); _11th(); }
int _13th() { _12th();  _12th(); } int _14th() { _13th(); _13th(); }  int _15th() { _14th(); _14th(); }
int _16th() { _15th();  _15th(); } int _17th() { _16th(); _16th(); }  int _18th() { _17th(); _17th(); }
int _19th() { _18th();  _18th(); } int _20th() { _19th(); _19th(); }  int _21th() { _20th(); _20th(); }
int _22th() { _21th();  _21th(); } int _23th() { _22th(); _22th(); }  int _24th() { _23th(); _23th(); }
int _25th() { _24th();  _24th(); }            

int _32million() { printf("32 million nest/unnest operations\n"); _25th(); }
int _1million()  { printf(" 1 million nest/unnest operations\n"); _20th(); }

int main() {
    printf("enter 1million or 32million\n");
    _1million();
    return 0;
}
