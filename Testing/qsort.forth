sort

: print (addr len -- )
    2* over + swap ( addr+len addr )
    do 
        i @ .
    2 +loop
    cr
;

: mid ( l r -- mid ) over - 2/ -cell and + ;
 
: exch ( addr1 addr2 -- ) dup @ >r over @ swap ! r> swap ! ;

: exch2 ( addr1 addr2 -- ) 
  OVER @ OVER @        ( read values)
  SWAP ROT ! SWAP !    ( exchange values)
;

: partition ( l r -- l r r2 l2 )
  2dup mid @ >r ( r: pivot )
  2dup begin
    swap begin dup @  r@ < while cell+ repeat
    swap begin r@ over @ < while cell- repeat
    2dup <= if 2dup exch >r cell+ r> cell- then
  2dup > until  r> drop ;
 
: qsort ( l r -- )
  partition  swap rot
  \ 2over 2over - + < if 2swap then
  2dup < if recurse else 2drop then
  2dup < if recurse else 2drop then ;
 
: sort ( array len -- )
  dup 2 < if 2drop exit then
  1- cells over + qsort ;
