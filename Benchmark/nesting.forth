( Forth nesting (NEXT) Benchmark     cas20101204 )
: bottom ;    
: 1st bottom bottom ;  : 2nd 1st 1st ;   : 3rd 2nd 2nd ;
: 4th 3rd 3rd ;   : 5th 4th 4th ;   : 6th 5th 5th ;
: 7th 6th 6th ;   : 8th 7th 7th ;   : 9th 8th 8th ;
: 10th 9th 9th ;   : 11th 10th 10th ;   : 12th 11th 11th ;
: 13th 12th 12th ;   : 14th 13th 13th ;   : 15th 14th 14th ;
: 16th 15th 15th ;   : 17th 16th 16th ;   : 18th 17th 17th ;
: 19th 18th 18th ;   : 20th 19th 19th ;   : 21th 20th 20th ;
: 22th 21th 21th ;   : 23th 22th 22th ;   : 24th 23th 23th ;
: 25th 24th 24th ;            

: 32million   CR ." 32 million nest/unnest operations" 25th ;
:  1million   CR ."  1 million nest/unnest operations" 20th ;

CR .( enter 1million or 32million )
