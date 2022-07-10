include(`../M4/FIRST.M4')dnl
dnl
   ORG 0x8000
   INIT(60000)
   BUFFER(buffer,10)

   CLEARKEY
   BEGIN 
      PRINT_Z({"Press any key: "}) 
      KEY 
      DUP_PUSH_NE_WHILE(0x0D) 
         DUP_EMIT PUTCHAR('=') UDOT CR 
   REPEAT 
   DROP
    
   PRINT_Z({0x0D,"10 char string: "})
   PUSH2(buffer,10) ACCEPT
   CR
   DUP
   PUSH_ADD(buffer) PUSH(buffer)
   BEGIN
      _2DUP_UGT_WHILE
         DUP_FETCH_EMIT
         _1ADD
   AGAIN
   _2DROP
   CR
   PUSH_SWAP(buffer) TYPE
    
   PRINT_Z({0x0D, "RAS: "}) __RAS UDOT
   PRINT_Z({0x0D, "Data stack: "}) DEPTH UDOT
   CR
   STOP
