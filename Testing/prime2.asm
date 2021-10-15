ORG 0x6000

;   ===  b e g i n  ===
    ld  (Stop+1), SP    ; 4:20      init   storing the original SP value when the "bye" word is used
    ld    L, 0x1A       ; 2:7       init   Upper screen
    call 0x1605         ; 3:17      init   Open channel
    ld   HL, 0xF500     ; 3:10      init   Init Return address stack
    exx                 ; 1:4       init
   
    push DE             ; 1:11      push(1)
    ex   DE, HL         ; 1:4       push(1)
    ld   HL, 1          ; 3:10      push(1)
   
    push DE             ; 1:11      push2(2   ,3   )
    ld   DE, 2          ; 3:10      push2(2   ,3   )
    push HL             ; 1:11      push2(2   ,3   )
    ld   HL, 3          ; 3:10      push2(2   ,3   )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5   ,7   )
    ld   DE, 5          ; 3:10      push2(5   ,7   )
    push HL             ; 1:11      push2(5   ,7   )
    ld   HL, 7          ; 3:10      push2(5   ,7   ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(11  ,13  )
    ld   DE, 11         ; 3:10      push2(11  ,13  )
    push HL             ; 1:11      push2(11  ,13  )
    ld   HL, 13         ; 3:10      push2(11  ,13  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(17  ,19  )
    ld   DE, 17         ; 3:10      push2(17  ,19  )
    push HL             ; 1:11      push2(17  ,19  )
    ld   HL, 19         ; 3:10      push2(17  ,19  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(23  ,29 )
    ld   DE, 23         ; 3:10      push2(23  ,29 )
    push HL             ; 1:11      push2(23  ,29 )
    ld   HL, 29         ; 3:10      push2(23  ,29 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
   
    push DE             ; 1:11      push2(31  ,37  )
    ld   DE, 31         ; 3:10      push2(31  ,37  )
    push HL             ; 1:11      push2(31  ,37  )
    ld   HL, 37         ; 3:10      push2(31  ,37  )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(41  ,43  )
    ld   DE, 41         ; 3:10      push2(41  ,43  )
    push HL             ; 1:11      push2(41  ,43  )
    ld   HL, 43         ; 3:10      push2(41  ,43  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(47  ,53  )
    ld   DE, 47         ; 3:10      push2(47  ,53  )
    push HL             ; 1:11      push2(47  ,53  )
    ld   HL, 53         ; 3:10      push2(47  ,53  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(59  ,61  )
    ld   DE, 59         ; 3:10      push2(59  ,61  )
    push HL             ; 1:11      push2(59  ,61  )
    ld   HL, 61         ; 3:10      push2(59  ,61  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(67  ,71 )
    ld   DE, 67         ; 3:10      push2(67  ,71 )
    push HL             ; 1:11      push2(67  ,71 )
    ld   HL, 71         ; 3:10      push2(67  ,71 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *  
   
    push DE             ; 1:11      push2(73  ,79  )
    ld   DE, 73         ; 3:10      push2(73  ,79  )
    push HL             ; 1:11      push2(73  ,79  )
    ld   HL, 79         ; 3:10      push2(73  ,79  )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(83  ,89  )
    ld   DE, 83         ; 3:10      push2(83  ,89  )
    push HL             ; 1:11      push2(83  ,89  )
    ld   HL, 89         ; 3:10      push2(83  ,89  ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(97  ,101 )
    ld   DE, 97         ; 3:10      push2(97  ,101 )
    push HL             ; 1:11      push2(97  ,101 )
    ld   HL, 101        ; 3:10      push2(97  ,101 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(103 ,107 )
    ld   DE, 103        ; 3:10      push2(103 ,107 )
    push HL             ; 1:11      push2(103 ,107 )
    ld   HL, 107        ; 3:10      push2(103 ,107 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(109 ,113)
    ld   DE, 109        ; 3:10      push2(109 ,113)
    push HL             ; 1:11      push2(109 ,113)
    ld   HL, 113        ; 3:10      push2(109 ,113)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *  
   
    push DE             ; 1:11      push2(127 ,131 )
    ld   DE, 127        ; 3:10      push2(127 ,131 )
    push HL             ; 1:11      push2(127 ,131 )
    ld   HL, 131        ; 3:10      push2(127 ,131 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(137 ,139 )
    ld   DE, 137        ; 3:10      push2(137 ,139 )
    push HL             ; 1:11      push2(137 ,139 )
    ld   HL, 139        ; 3:10      push2(137 ,139 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(149 ,151 )
    ld   DE, 149        ; 3:10      push2(149 ,151 )
    push HL             ; 1:11      push2(149 ,151 )
    ld   HL, 151        ; 3:10      push2(149 ,151 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(157 ,163 )
    ld   DE, 157        ; 3:10      push2(157 ,163 )
    push HL             ; 1:11      push2(157 ,163 )
    ld   HL, 163        ; 3:10      push2(157 ,163 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(167 ,173)
    ld   DE, 167        ; 3:10      push2(167 ,173)
    push HL             ; 1:11      push2(167 ,173)
    ld   HL, 173        ; 3:10      push2(167 ,173)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(179 ,181 )
    ld   DE, 179        ; 3:10      push2(179 ,181 )
    push HL             ; 1:11      push2(179 ,181 )
    ld   HL, 181        ; 3:10      push2(179 ,181 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(191 ,193 )
    ld   DE, 191        ; 3:10      push2(191 ,193 )
    push HL             ; 1:11      push2(191 ,193 )
    ld   HL, 193        ; 3:10      push2(191 ,193 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(197 ,199 )
    ld   DE, 197        ; 3:10      push2(197 ,199 )
    push HL             ; 1:11      push2(197 ,199 )
    ld   HL, 199        ; 3:10      push2(197 ,199 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(211 ,223 )
    ld   DE, 211        ; 3:10      push2(211 ,223 )
    push HL             ; 1:11      push2(211 ,223 )
    ld   HL, 223        ; 3:10      push2(211 ,223 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(227 ,229)
    ld   DE, 227        ; 3:10      push2(227 ,229)
    push HL             ; 1:11      push2(227 ,229)
    ld   HL, 229        ; 3:10      push2(227 ,229)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(233 ,239 )
    ld   DE, 233        ; 3:10      push2(233 ,239 )
    push HL             ; 1:11      push2(233 ,239 )
    ld   HL, 239        ; 3:10      push2(233 ,239 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(241 ,251 )
    ld   DE, 241        ; 3:10      push2(241 ,251 )
    push HL             ; 1:11      push2(241 ,251 )
    ld   HL, 251        ; 3:10      push2(241 ,251 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(257 ,263 )
    ld   DE, 257        ; 3:10      push2(257 ,263 )
    push HL             ; 1:11      push2(257 ,263 )
    ld   HL, 263        ; 3:10      push2(257 ,263 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(269 ,271 )
    ld   DE, 269        ; 3:10      push2(269 ,271 )
    push HL             ; 1:11      push2(269 ,271 )
    ld   HL, 271        ; 3:10      push2(269 ,271 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(277 ,281)
    ld   DE, 277        ; 3:10      push2(277 ,281)
    push HL             ; 1:11      push2(277 ,281)
    ld   HL, 281        ; 3:10      push2(277 ,281)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(283 ,293 )
    ld   DE, 283        ; 3:10      push2(283 ,293 )
    push HL             ; 1:11      push2(283 ,293 )
    ld   HL, 293        ; 3:10      push2(283 ,293 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(307 ,311 )
    ld   DE, 307        ; 3:10      push2(307 ,311 )
    push HL             ; 1:11      push2(307 ,311 )
    ld   HL, 311        ; 3:10      push2(307 ,311 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(313 ,317 )
    ld   DE, 313        ; 3:10      push2(313 ,317 )
    push HL             ; 1:11      push2(313 ,317 )
    ld   HL, 317        ; 3:10      push2(313 ,317 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(331 ,337 )
    ld   DE, 331        ; 3:10      push2(331 ,337 )
    push HL             ; 1:11      push2(331 ,337 )
    ld   HL, 337        ; 3:10      push2(331 ,337 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(347 ,349)
    ld   DE, 347        ; 3:10      push2(347 ,349)
    push HL             ; 1:11      push2(347 ,349)
    ld   HL, 349        ; 3:10      push2(347 ,349)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(353 ,359 )
    ld   DE, 353        ; 3:10      push2(353 ,359 )
    push HL             ; 1:11      push2(353 ,359 )
    ld   HL, 359        ; 3:10      push2(353 ,359 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(367 ,373 )
    ld   DE, 367        ; 3:10      push2(367 ,373 )
    push HL             ; 1:11      push2(367 ,373 )
    ld   HL, 373        ; 3:10      push2(367 ,373 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(379 ,383 )
    ld   DE, 379        ; 3:10      push2(379 ,383 )
    push HL             ; 1:11      push2(379 ,383 )
    ld   HL, 383        ; 3:10      push2(379 ,383 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(389 ,397 )
    ld   DE, 389        ; 3:10      push2(389 ,397 )
    push HL             ; 1:11      push2(389 ,397 )
    ld   HL, 397        ; 3:10      push2(389 ,397 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(401 ,409)
    ld   DE, 401        ; 3:10      push2(401 ,409)
    push HL             ; 1:11      push2(401 ,409)
    ld   HL, 409        ; 3:10      push2(401 ,409)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(419 ,421 )
    ld   DE, 419        ; 3:10      push2(419 ,421 )
    push HL             ; 1:11      push2(419 ,421 )
    ld   HL, 421        ; 3:10      push2(419 ,421 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(431 ,433 )
    ld   DE, 431        ; 3:10      push2(431 ,433 )
    push HL             ; 1:11      push2(431 ,433 )
    ld   HL, 433        ; 3:10      push2(431 ,433 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(439 ,443 )
    ld   DE, 439        ; 3:10      push2(439 ,443 )
    push HL             ; 1:11      push2(439 ,443 )
    ld   HL, 443        ; 3:10      push2(439 ,443 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(449 ,457 )
    ld   DE, 449        ; 3:10      push2(449 ,457 )
    push HL             ; 1:11      push2(449 ,457 )
    ld   HL, 457        ; 3:10      push2(449 ,457 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(461 ,463)
    ld   DE, 461        ; 3:10      push2(461 ,463)
    push HL             ; 1:11      push2(461 ,463)
    ld   HL, 463        ; 3:10      push2(461 ,463)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(467 ,479 )
    ld   DE, 467        ; 3:10      push2(467 ,479 )
    push HL             ; 1:11      push2(467 ,479 )
    ld   HL, 479        ; 3:10      push2(467 ,479 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(487 ,491 )
    ld   DE, 487        ; 3:10      push2(487 ,491 )
    push HL             ; 1:11      push2(487 ,491 )
    ld   HL, 491        ; 3:10      push2(487 ,491 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(499 ,503 )
    ld   DE, 499        ; 3:10      push2(499 ,503 )
    push HL             ; 1:11      push2(499 ,503 )
    ld   HL, 503        ; 3:10      push2(499 ,503 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(509 ,521 )
    ld   DE, 509        ; 3:10      push2(509 ,521 )
    push HL             ; 1:11      push2(509 ,521 )
    ld   HL, 521        ; 3:10      push2(509 ,521 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(523 ,541)
    ld   DE, 523        ; 3:10      push2(523 ,541)
    push HL             ; 1:11      push2(523 ,541)
    ld   HL, 541        ; 3:10      push2(523 ,541)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(547 ,557 )
    ld   DE, 547        ; 3:10      push2(547 ,557 )
    push HL             ; 1:11      push2(547 ,557 )
    ld   HL, 557        ; 3:10      push2(547 ,557 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(563 ,569 )
    ld   DE, 563        ; 3:10      push2(563 ,569 )
    push HL             ; 1:11      push2(563 ,569 )
    ld   HL, 569        ; 3:10      push2(563 ,569 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(571 ,577 )
    ld   DE, 571        ; 3:10      push2(571 ,577 )
    push HL             ; 1:11      push2(571 ,577 )
    ld   HL, 577        ; 3:10      push2(571 ,577 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(587 ,593 )
    ld   DE, 587        ; 3:10      push2(587 ,593 )
    push HL             ; 1:11      push2(587 ,593 )
    ld   HL, 593        ; 3:10      push2(587 ,593 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(599 ,601)
    ld   DE, 599        ; 3:10      push2(599 ,601)
    push HL             ; 1:11      push2(599 ,601)
    ld   HL, 601        ; 3:10      push2(599 ,601)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(607 ,613 )
    ld   DE, 607        ; 3:10      push2(607 ,613 )
    push HL             ; 1:11      push2(607 ,613 )
    ld   HL, 613        ; 3:10      push2(607 ,613 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(617 ,619 )
    ld   DE, 617        ; 3:10      push2(617 ,619 )
    push HL             ; 1:11      push2(617 ,619 )
    ld   HL, 619        ; 3:10      push2(617 ,619 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(631 ,641 )
    ld   DE, 631        ; 3:10      push2(631 ,641 )
    push HL             ; 1:11      push2(631 ,641 )
    ld   HL, 641        ; 3:10      push2(631 ,641 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(643 ,647 )
    ld   DE, 643        ; 3:10      push2(643 ,647 )
    push HL             ; 1:11      push2(643 ,647 )
    ld   HL, 647        ; 3:10      push2(643 ,647 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(653 ,659)
    ld   DE, 653        ; 3:10      push2(653 ,659)
    push HL             ; 1:11      push2(653 ,659)
    ld   HL, 659        ; 3:10      push2(653 ,659)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(661 ,673 )
    ld   DE, 661        ; 3:10      push2(661 ,673 )
    push HL             ; 1:11      push2(661 ,673 )
    ld   HL, 673        ; 3:10      push2(661 ,673 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(677 ,683 )
    ld   DE, 677        ; 3:10      push2(677 ,683 )
    push HL             ; 1:11      push2(677 ,683 )
    ld   HL, 683        ; 3:10      push2(677 ,683 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(691 ,701 )
    ld   DE, 691        ; 3:10      push2(691 ,701 )
    push HL             ; 1:11      push2(691 ,701 )
    ld   HL, 701        ; 3:10      push2(691 ,701 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(709 ,719 )
    ld   DE, 709        ; 3:10      push2(709 ,719 )
    push HL             ; 1:11      push2(709 ,719 )
    ld   HL, 719        ; 3:10      push2(709 ,719 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(727 ,733)
    ld   DE, 727        ; 3:10      push2(727 ,733)
    push HL             ; 1:11      push2(727 ,733)
    ld   HL, 733        ; 3:10      push2(727 ,733)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(739 ,743 )
    ld   DE, 739        ; 3:10      push2(739 ,743 )
    push HL             ; 1:11      push2(739 ,743 )
    ld   HL, 743        ; 3:10      push2(739 ,743 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(751 ,757 )
    ld   DE, 751        ; 3:10      push2(751 ,757 )
    push HL             ; 1:11      push2(751 ,757 )
    ld   HL, 757        ; 3:10      push2(751 ,757 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(761 ,769 )
    ld   DE, 761        ; 3:10      push2(761 ,769 )
    push HL             ; 1:11      push2(761 ,769 )
    ld   HL, 769        ; 3:10      push2(761 ,769 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(773 ,787 )
    ld   DE, 773        ; 3:10      push2(773 ,787 )
    push HL             ; 1:11      push2(773 ,787 )
    ld   HL, 787        ; 3:10      push2(773 ,787 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(797 ,809)
    ld   DE, 797        ; 3:10      push2(797 ,809)
    push HL             ; 1:11      push2(797 ,809)
    ld   HL, 809        ; 3:10      push2(797 ,809)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(811 ,821 )
    ld   DE, 811        ; 3:10      push2(811 ,821 )
    push HL             ; 1:11      push2(811 ,821 )
    ld   HL, 821        ; 3:10      push2(811 ,821 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(823 ,827 )
    ld   DE, 823        ; 3:10      push2(823 ,827 )
    push HL             ; 1:11      push2(823 ,827 )
    ld   HL, 827        ; 3:10      push2(823 ,827 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(829 ,839 )
    ld   DE, 829        ; 3:10      push2(829 ,839 )
    push HL             ; 1:11      push2(829 ,839 )
    ld   HL, 839        ; 3:10      push2(829 ,839 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(853 ,857 )
    ld   DE, 853        ; 3:10      push2(853 ,857 )
    push HL             ; 1:11      push2(853 ,857 )
    ld   HL, 857        ; 3:10      push2(853 ,857 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(859 ,863)
    ld   DE, 859        ; 3:10      push2(859 ,863)
    push HL             ; 1:11      push2(859 ,863)
    ld   HL, 863        ; 3:10      push2(859 ,863)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(877 ,881 )
    ld   DE, 877        ; 3:10      push2(877 ,881 )
    push HL             ; 1:11      push2(877 ,881 )
    ld   HL, 881        ; 3:10      push2(877 ,881 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(883 ,887 )
    ld   DE, 883        ; 3:10      push2(883 ,887 )
    push HL             ; 1:11      push2(883 ,887 )
    ld   HL, 887        ; 3:10      push2(883 ,887 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(907 ,911 )
    ld   DE, 907        ; 3:10      push2(907 ,911 )
    push HL             ; 1:11      push2(907 ,911 )
    ld   HL, 911        ; 3:10      push2(907 ,911 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(919 ,929 )
    ld   DE, 919        ; 3:10      push2(919 ,929 )
    push HL             ; 1:11      push2(919 ,929 )
    ld   HL, 929        ; 3:10      push2(919 ,929 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(937 ,941)
    ld   DE, 937        ; 3:10      push2(937 ,941)
    push HL             ; 1:11      push2(937 ,941)
    ld   HL, 941        ; 3:10      push2(937 ,941)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(947 ,953 )
    ld   DE, 947        ; 3:10      push2(947 ,953 )
    push HL             ; 1:11      push2(947 ,953 )
    ld   HL, 953        ; 3:10      push2(947 ,953 )  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(967 ,971 )
    ld   DE, 967        ; 3:10      push2(967 ,971 )
    push HL             ; 1:11      push2(967 ,971 )
    ld   HL, 971        ; 3:10      push2(967 ,971 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(977 ,983 )
    ld   DE, 977        ; 3:10      push2(977 ,983 )
    push HL             ; 1:11      push2(977 ,983 )
    ld   HL, 983        ; 3:10      push2(977 ,983 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(991 ,997 )
    ld   DE, 991        ; 3:10      push2(991 ,997 )
    push HL             ; 1:11      push2(991 ,997 )
    ld   HL, 997        ; 3:10      push2(991 ,997 ) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1009,1013)
    ld   DE, 1009       ; 3:10      push2(1009,1013)
    push HL             ; 1:11      push2(1009,1013)
    ld   HL, 1013       ; 3:10      push2(1009,1013) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1019,1021)
    ld   DE, 1019       ; 3:10      push2(1019,1021)
    push HL             ; 1:11      push2(1019,1021)
    ld   HL, 1021       ; 3:10      push2(1019,1021)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1031,1033)
    ld   DE, 1031       ; 3:10      push2(1031,1033)
    push HL             ; 1:11      push2(1031,1033)
    ld   HL, 1033       ; 3:10      push2(1031,1033) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1039,1049)
    ld   DE, 1039       ; 3:10      push2(1039,1049)
    push HL             ; 1:11      push2(1039,1049)
    ld   HL, 1049       ; 3:10      push2(1039,1049) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1051,1061)
    ld   DE, 1051       ; 3:10      push2(1051,1061)
    push HL             ; 1:11      push2(1051,1061)
    ld   HL, 1061       ; 3:10      push2(1051,1061) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1063,1069)
    ld   DE, 1063       ; 3:10      push2(1063,1069)
    push HL             ; 1:11      push2(1063,1069)
    ld   HL, 1069       ; 3:10      push2(1063,1069) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1087,1091)
    ld   DE, 1087       ; 3:10      push2(1087,1091)
    push HL             ; 1:11      push2(1087,1091)
    ld   HL, 1091       ; 3:10      push2(1087,1091)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1093,1097)
    ld   DE, 1093       ; 3:10      push2(1093,1097)
    push HL             ; 1:11      push2(1093,1097)
    ld   HL, 1097       ; 3:10      push2(1093,1097) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1103,1109)
    ld   DE, 1103       ; 3:10      push2(1103,1109)
    push HL             ; 1:11      push2(1103,1109)
    ld   HL, 1109       ; 3:10      push2(1103,1109) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1117,1123)
    ld   DE, 1117       ; 3:10      push2(1117,1123)
    push HL             ; 1:11      push2(1117,1123)
    ld   HL, 1123       ; 3:10      push2(1117,1123) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1129,1151)
    ld   DE, 1129       ; 3:10      push2(1129,1151)
    push HL             ; 1:11      push2(1129,1151)
    ld   HL, 1151       ; 3:10      push2(1129,1151) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1153,1163)
    ld   DE, 1153       ; 3:10      push2(1153,1163)
    push HL             ; 1:11      push2(1153,1163)
    ld   HL, 1163       ; 3:10      push2(1153,1163)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1171,1181)
    ld   DE, 1171       ; 3:10      push2(1171,1181)
    push HL             ; 1:11      push2(1171,1181)
    ld   HL, 1181       ; 3:10      push2(1171,1181) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1187,1193)
    ld   DE, 1187       ; 3:10      push2(1187,1193)
    push HL             ; 1:11      push2(1187,1193)
    ld   HL, 1193       ; 3:10      push2(1187,1193) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1201,1213)
    ld   DE, 1201       ; 3:10      push2(1201,1213)
    push HL             ; 1:11      push2(1201,1213)
    ld   HL, 1213       ; 3:10      push2(1201,1213) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1217,1223)
    ld   DE, 1217       ; 3:10      push2(1217,1223)
    push HL             ; 1:11      push2(1217,1223)
    ld   HL, 1223       ; 3:10      push2(1217,1223) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1229,1231)
    ld   DE, 1229       ; 3:10      push2(1229,1231)
    push HL             ; 1:11      push2(1229,1231)
    ld   HL, 1231       ; 3:10      push2(1229,1231)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1237,1249)
    ld   DE, 1237       ; 3:10      push2(1237,1249)
    push HL             ; 1:11      push2(1237,1249)
    ld   HL, 1249       ; 3:10      push2(1237,1249) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1259,1277)
    ld   DE, 1259       ; 3:10      push2(1259,1277)
    push HL             ; 1:11      push2(1259,1277)
    ld   HL, 1277       ; 3:10      push2(1259,1277) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1279,1283)
    ld   DE, 1279       ; 3:10      push2(1279,1283)
    push HL             ; 1:11      push2(1279,1283)
    ld   HL, 1283       ; 3:10      push2(1279,1283) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1289,1291)
    ld   DE, 1289       ; 3:10      push2(1289,1291)
    push HL             ; 1:11      push2(1289,1291)
    ld   HL, 1291       ; 3:10      push2(1289,1291) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1297,1301)
    ld   DE, 1297       ; 3:10      push2(1297,1301)
    push HL             ; 1:11      push2(1297,1301)
    ld   HL, 1301       ; 3:10      push2(1297,1301)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1303,1307)
    ld   DE, 1303       ; 3:10      push2(1303,1307)
    push HL             ; 1:11      push2(1303,1307)
    ld   HL, 1307       ; 3:10      push2(1303,1307) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1319,1321)
    ld   DE, 1319       ; 3:10      push2(1319,1321)
    push HL             ; 1:11      push2(1319,1321)
    ld   HL, 1321       ; 3:10      push2(1319,1321) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1327,1361)
    ld   DE, 1327       ; 3:10      push2(1327,1361)
    push HL             ; 1:11      push2(1327,1361)
    ld   HL, 1361       ; 3:10      push2(1327,1361) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1367,1373)
    ld   DE, 1367       ; 3:10      push2(1367,1373)
    push HL             ; 1:11      push2(1367,1373)
    ld   HL, 1373       ; 3:10      push2(1367,1373) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1381,1399)
    ld   DE, 1381       ; 3:10      push2(1381,1399)
    push HL             ; 1:11      push2(1381,1399)
    ld   HL, 1399       ; 3:10      push2(1381,1399)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1409,1423)
    ld   DE, 1409       ; 3:10      push2(1409,1423)
    push HL             ; 1:11      push2(1409,1423)
    ld   HL, 1423       ; 3:10      push2(1409,1423) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1427,1429)
    ld   DE, 1427       ; 3:10      push2(1427,1429)
    push HL             ; 1:11      push2(1427,1429)
    ld   HL, 1429       ; 3:10      push2(1427,1429) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1433,1439)
    ld   DE, 1433       ; 3:10      push2(1433,1439)
    push HL             ; 1:11      push2(1433,1439)
    ld   HL, 1439       ; 3:10      push2(1433,1439) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1447,1451)
    ld   DE, 1447       ; 3:10      push2(1447,1451)
    push HL             ; 1:11      push2(1447,1451)
    ld   HL, 1451       ; 3:10      push2(1447,1451) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1453,1459)
    ld   DE, 1453       ; 3:10      push2(1453,1459)
    push HL             ; 1:11      push2(1453,1459)
    ld   HL, 1459       ; 3:10      push2(1453,1459)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1471,1481)
    ld   DE, 1471       ; 3:10      push2(1471,1481)
    push HL             ; 1:11      push2(1471,1481)
    ld   HL, 1481       ; 3:10      push2(1471,1481) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1483,1487)
    ld   DE, 1483       ; 3:10      push2(1483,1487)
    push HL             ; 1:11      push2(1483,1487)
    ld   HL, 1487       ; 3:10      push2(1483,1487) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1489,1493)
    ld   DE, 1489       ; 3:10      push2(1489,1493)
    push HL             ; 1:11      push2(1489,1493)
    ld   HL, 1493       ; 3:10      push2(1489,1493) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1499,1511)
    ld   DE, 1499       ; 3:10      push2(1499,1511)
    push HL             ; 1:11      push2(1499,1511)
    ld   HL, 1511       ; 3:10      push2(1499,1511) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1523,1531)
    ld   DE, 1523       ; 3:10      push2(1523,1531)
    push HL             ; 1:11      push2(1523,1531)
    ld   HL, 1531       ; 3:10      push2(1523,1531)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1543,1549)
    ld   DE, 1543       ; 3:10      push2(1543,1549)
    push HL             ; 1:11      push2(1543,1549)
    ld   HL, 1549       ; 3:10      push2(1543,1549) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1553,1559)
    ld   DE, 1553       ; 3:10      push2(1553,1559)
    push HL             ; 1:11      push2(1553,1559)
    ld   HL, 1559       ; 3:10      push2(1553,1559) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1567,1571)
    ld   DE, 1567       ; 3:10      push2(1567,1571)
    push HL             ; 1:11      push2(1567,1571)
    ld   HL, 1571       ; 3:10      push2(1567,1571) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1579,1583)
    ld   DE, 1579       ; 3:10      push2(1579,1583)
    push HL             ; 1:11      push2(1579,1583)
    ld   HL, 1583       ; 3:10      push2(1579,1583) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1597,1601)
    ld   DE, 1597       ; 3:10      push2(1597,1601)
    push HL             ; 1:11      push2(1597,1601)
    ld   HL, 1601       ; 3:10      push2(1597,1601)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1607,1609)
    ld   DE, 1607       ; 3:10      push2(1607,1609)
    push HL             ; 1:11      push2(1607,1609)
    ld   HL, 1609       ; 3:10      push2(1607,1609) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1613,1619)
    ld   DE, 1613       ; 3:10      push2(1613,1619)
    push HL             ; 1:11      push2(1613,1619)
    ld   HL, 1619       ; 3:10      push2(1613,1619) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1621,1627)
    ld   DE, 1621       ; 3:10      push2(1621,1627)
    push HL             ; 1:11      push2(1621,1627)
    ld   HL, 1627       ; 3:10      push2(1621,1627) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1637,1657)
    ld   DE, 1637       ; 3:10      push2(1637,1657)
    push HL             ; 1:11      push2(1637,1657)
    ld   HL, 1657       ; 3:10      push2(1637,1657) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1663,1667)
    ld   DE, 1663       ; 3:10      push2(1663,1667)
    push HL             ; 1:11      push2(1663,1667)
    ld   HL, 1667       ; 3:10      push2(1663,1667)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1669,1693)
    ld   DE, 1669       ; 3:10      push2(1669,1693)
    push HL             ; 1:11      push2(1669,1693)
    ld   HL, 1693       ; 3:10      push2(1669,1693) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1697,1699)
    ld   DE, 1697       ; 3:10      push2(1697,1699)
    push HL             ; 1:11      push2(1697,1699)
    ld   HL, 1699       ; 3:10      push2(1697,1699) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1709,1721)
    ld   DE, 1709       ; 3:10      push2(1709,1721)
    push HL             ; 1:11      push2(1709,1721)
    ld   HL, 1721       ; 3:10      push2(1709,1721) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1723,1733)
    ld   DE, 1723       ; 3:10      push2(1723,1733)
    push HL             ; 1:11      push2(1723,1733)
    ld   HL, 1733       ; 3:10      push2(1723,1733) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1741,1747)
    ld   DE, 1741       ; 3:10      push2(1741,1747)
    push HL             ; 1:11      push2(1741,1747)
    ld   HL, 1747       ; 3:10      push2(1741,1747)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1753,1759)
    ld   DE, 1753       ; 3:10      push2(1753,1759)
    push HL             ; 1:11      push2(1753,1759)
    ld   HL, 1759       ; 3:10      push2(1753,1759) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1777,1783)
    ld   DE, 1777       ; 3:10      push2(1777,1783)
    push HL             ; 1:11      push2(1777,1783)
    ld   HL, 1783       ; 3:10      push2(1777,1783) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1787,1789)
    ld   DE, 1787       ; 3:10      push2(1787,1789)
    push HL             ; 1:11      push2(1787,1789)
    ld   HL, 1789       ; 3:10      push2(1787,1789) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1801,1811)
    ld   DE, 1801       ; 3:10      push2(1801,1811)
    push HL             ; 1:11      push2(1801,1811)
    ld   HL, 1811       ; 3:10      push2(1801,1811) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1823,1831)
    ld   DE, 1823       ; 3:10      push2(1823,1831)
    push HL             ; 1:11      push2(1823,1831)
    ld   HL, 1831       ; 3:10      push2(1823,1831)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1847,1861)
    ld   DE, 1847       ; 3:10      push2(1847,1861)
    push HL             ; 1:11      push2(1847,1861)
    ld   HL, 1861       ; 3:10      push2(1847,1861) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1867,1871)
    ld   DE, 1867       ; 3:10      push2(1867,1871)
    push HL             ; 1:11      push2(1867,1871)
    ld   HL, 1871       ; 3:10      push2(1867,1871) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1873,1877)
    ld   DE, 1873       ; 3:10      push2(1873,1877)
    push HL             ; 1:11      push2(1873,1877)
    ld   HL, 1877       ; 3:10      push2(1873,1877) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1879,1889)
    ld   DE, 1879       ; 3:10      push2(1879,1889)
    push HL             ; 1:11      push2(1879,1889)
    ld   HL, 1889       ; 3:10      push2(1879,1889) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1901,1907)
    ld   DE, 1901       ; 3:10      push2(1901,1907)
    push HL             ; 1:11      push2(1901,1907)
    ld   HL, 1907       ; 3:10      push2(1901,1907)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1913,1931)
    ld   DE, 1913       ; 3:10      push2(1913,1931)
    push HL             ; 1:11      push2(1913,1931)
    ld   HL, 1931       ; 3:10      push2(1913,1931) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1933,1949)
    ld   DE, 1933       ; 3:10      push2(1933,1949)
    push HL             ; 1:11      push2(1933,1949)
    ld   HL, 1949       ; 3:10      push2(1933,1949) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1951,1973)
    ld   DE, 1951       ; 3:10      push2(1951,1973)
    push HL             ; 1:11      push2(1951,1973)
    ld   HL, 1973       ; 3:10      push2(1951,1973) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1979,1987)
    ld   DE, 1979       ; 3:10      push2(1979,1987)
    push HL             ; 1:11      push2(1979,1987)
    ld   HL, 1987       ; 3:10      push2(1979,1987) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(1993,1997)
    ld   DE, 1993       ; 3:10      push2(1993,1997)
    push HL             ; 1:11      push2(1993,1997)
    ld   HL, 1997       ; 3:10      push2(1993,1997)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(1999,2003)
    ld   DE, 1999       ; 3:10      push2(1999,2003)
    push HL             ; 1:11      push2(1999,2003)
    ld   HL, 2003       ; 3:10      push2(1999,2003) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2011,2017)
    ld   DE, 2011       ; 3:10      push2(2011,2017)
    push HL             ; 1:11      push2(2011,2017)
    ld   HL, 2017       ; 3:10      push2(2011,2017) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2027,2029)
    ld   DE, 2027       ; 3:10      push2(2027,2029)
    push HL             ; 1:11      push2(2027,2029)
    ld   HL, 2029       ; 3:10      push2(2027,2029) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2039,2053)
    ld   DE, 2039       ; 3:10      push2(2039,2053)
    push HL             ; 1:11      push2(2039,2053)
    ld   HL, 2053       ; 3:10      push2(2039,2053) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2063,2069)
    ld   DE, 2063       ; 3:10      push2(2063,2069)
    push HL             ; 1:11      push2(2063,2069)
    ld   HL, 2069       ; 3:10      push2(2063,2069)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2081,2083)
    ld   DE, 2081       ; 3:10      push2(2081,2083)
    push HL             ; 1:11      push2(2081,2083)
    ld   HL, 2083       ; 3:10      push2(2081,2083) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2087,2089)
    ld   DE, 2087       ; 3:10      push2(2087,2089)
    push HL             ; 1:11      push2(2087,2089)
    ld   HL, 2089       ; 3:10      push2(2087,2089) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2099,2111)
    ld   DE, 2099       ; 3:10      push2(2099,2111)
    push HL             ; 1:11      push2(2099,2111)
    ld   HL, 2111       ; 3:10      push2(2099,2111) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2113,2129)
    ld   DE, 2113       ; 3:10      push2(2113,2129)
    push HL             ; 1:11      push2(2113,2129)
    ld   HL, 2129       ; 3:10      push2(2113,2129) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2131,2137)
    ld   DE, 2131       ; 3:10      push2(2131,2137)
    push HL             ; 1:11      push2(2131,2137)
    ld   HL, 2137       ; 3:10      push2(2131,2137)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2141,2143)
    ld   DE, 2141       ; 3:10      push2(2141,2143)
    push HL             ; 1:11      push2(2141,2143)
    ld   HL, 2143       ; 3:10      push2(2141,2143) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2153,2161)
    ld   DE, 2153       ; 3:10      push2(2153,2161)
    push HL             ; 1:11      push2(2153,2161)
    ld   HL, 2161       ; 3:10      push2(2153,2161) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2179,2203)
    ld   DE, 2179       ; 3:10      push2(2179,2203)
    push HL             ; 1:11      push2(2179,2203)
    ld   HL, 2203       ; 3:10      push2(2179,2203) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2207,2213)
    ld   DE, 2207       ; 3:10      push2(2207,2213)
    push HL             ; 1:11      push2(2207,2213)
    ld   HL, 2213       ; 3:10      push2(2207,2213) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2221,2237)
    ld   DE, 2221       ; 3:10      push2(2221,2237)
    push HL             ; 1:11      push2(2221,2237)
    ld   HL, 2237       ; 3:10      push2(2221,2237)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2239,2243)
    ld   DE, 2239       ; 3:10      push2(2239,2243)
    push HL             ; 1:11      push2(2239,2243)
    ld   HL, 2243       ; 3:10      push2(2239,2243) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2251,2267)
    ld   DE, 2251       ; 3:10      push2(2251,2267)
    push HL             ; 1:11      push2(2251,2267)
    ld   HL, 2267       ; 3:10      push2(2251,2267) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2269,2273)
    ld   DE, 2269       ; 3:10      push2(2269,2273)
    push HL             ; 1:11      push2(2269,2273)
    ld   HL, 2273       ; 3:10      push2(2269,2273) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2281,2287)
    ld   DE, 2281       ; 3:10      push2(2281,2287)
    push HL             ; 1:11      push2(2281,2287)
    ld   HL, 2287       ; 3:10      push2(2281,2287) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2293,2297)
    ld   DE, 2293       ; 3:10      push2(2293,2297)
    push HL             ; 1:11      push2(2293,2297)
    ld   HL, 2297       ; 3:10      push2(2293,2297)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2309,2311)
    ld   DE, 2309       ; 3:10      push2(2309,2311)
    push HL             ; 1:11      push2(2309,2311)
    ld   HL, 2311       ; 3:10      push2(2309,2311) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2333,2339)
    ld   DE, 2333       ; 3:10      push2(2333,2339)
    push HL             ; 1:11      push2(2333,2339)
    ld   HL, 2339       ; 3:10      push2(2333,2339) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2341,2347)
    ld   DE, 2341       ; 3:10      push2(2341,2347)
    push HL             ; 1:11      push2(2341,2347)
    ld   HL, 2347       ; 3:10      push2(2341,2347) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2351,2357)
    ld   DE, 2351       ; 3:10      push2(2351,2357)
    push HL             ; 1:11      push2(2351,2357)
    ld   HL, 2357       ; 3:10      push2(2351,2357) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2371,2377)
    ld   DE, 2371       ; 3:10      push2(2371,2377)
    push HL             ; 1:11      push2(2371,2377)
    ld   HL, 2377       ; 3:10      push2(2371,2377)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2381,2383)
    ld   DE, 2381       ; 3:10      push2(2381,2383)
    push HL             ; 1:11      push2(2381,2383)
    ld   HL, 2383       ; 3:10      push2(2381,2383) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2389,2393)
    ld   DE, 2389       ; 3:10      push2(2389,2393)
    push HL             ; 1:11      push2(2389,2393)
    ld   HL, 2393       ; 3:10      push2(2389,2393) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2399,2411)
    ld   DE, 2399       ; 3:10      push2(2399,2411)
    push HL             ; 1:11      push2(2399,2411)
    ld   HL, 2411       ; 3:10      push2(2399,2411) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2417,2423)
    ld   DE, 2417       ; 3:10      push2(2417,2423)
    push HL             ; 1:11      push2(2417,2423)
    ld   HL, 2423       ; 3:10      push2(2417,2423) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2437,2441)
    ld   DE, 2437       ; 3:10      push2(2437,2441)
    push HL             ; 1:11      push2(2437,2441)
    ld   HL, 2441       ; 3:10      push2(2437,2441)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2447,2459)
    ld   DE, 2447       ; 3:10      push2(2447,2459)
    push HL             ; 1:11      push2(2447,2459)
    ld   HL, 2459       ; 3:10      push2(2447,2459) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2467,2473)
    ld   DE, 2467       ; 3:10      push2(2467,2473)
    push HL             ; 1:11      push2(2467,2473)
    ld   HL, 2473       ; 3:10      push2(2467,2473) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2477,2503)
    ld   DE, 2477       ; 3:10      push2(2477,2503)
    push HL             ; 1:11      push2(2477,2503)
    ld   HL, 2503       ; 3:10      push2(2477,2503) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2521,2531)
    ld   DE, 2521       ; 3:10      push2(2521,2531)
    push HL             ; 1:11      push2(2521,2531)
    ld   HL, 2531       ; 3:10      push2(2521,2531) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2539,2543)
    ld   DE, 2539       ; 3:10      push2(2539,2543)
    push HL             ; 1:11      push2(2539,2543)
    ld   HL, 2543       ; 3:10      push2(2539,2543)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2549,2551)
    ld   DE, 2549       ; 3:10      push2(2549,2551)
    push HL             ; 1:11      push2(2549,2551)
    ld   HL, 2551       ; 3:10      push2(2549,2551) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2557,2579)
    ld   DE, 2557       ; 3:10      push2(2557,2579)
    push HL             ; 1:11      push2(2557,2579)
    ld   HL, 2579       ; 3:10      push2(2557,2579) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2591,2593)
    ld   DE, 2591       ; 3:10      push2(2591,2593)
    push HL             ; 1:11      push2(2591,2593)
    ld   HL, 2593       ; 3:10      push2(2591,2593) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2609,2617)
    ld   DE, 2609       ; 3:10      push2(2609,2617)
    push HL             ; 1:11      push2(2609,2617)
    ld   HL, 2617       ; 3:10      push2(2609,2617) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2621,2633)
    ld   DE, 2621       ; 3:10      push2(2621,2633)
    push HL             ; 1:11      push2(2621,2633)
    ld   HL, 2633       ; 3:10      push2(2621,2633)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2647,2657)
    ld   DE, 2647       ; 3:10      push2(2647,2657)
    push HL             ; 1:11      push2(2647,2657)
    ld   HL, 2657       ; 3:10      push2(2647,2657) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2659,2663)
    ld   DE, 2659       ; 3:10      push2(2659,2663)
    push HL             ; 1:11      push2(2659,2663)
    ld   HL, 2663       ; 3:10      push2(2659,2663) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2671,2677)
    ld   DE, 2671       ; 3:10      push2(2671,2677)
    push HL             ; 1:11      push2(2671,2677)
    ld   HL, 2677       ; 3:10      push2(2671,2677) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2683,2687)
    ld   DE, 2683       ; 3:10      push2(2683,2687)
    push HL             ; 1:11      push2(2683,2687)
    ld   HL, 2687       ; 3:10      push2(2683,2687) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2689,2693)
    ld   DE, 2689       ; 3:10      push2(2689,2693)
    push HL             ; 1:11      push2(2689,2693)
    ld   HL, 2693       ; 3:10      push2(2689,2693)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2699,2707)
    ld   DE, 2699       ; 3:10      push2(2699,2707)
    push HL             ; 1:11      push2(2699,2707)
    ld   HL, 2707       ; 3:10      push2(2699,2707) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2711,2713)
    ld   DE, 2711       ; 3:10      push2(2711,2713)
    push HL             ; 1:11      push2(2711,2713)
    ld   HL, 2713       ; 3:10      push2(2711,2713) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2719,2729)
    ld   DE, 2719       ; 3:10      push2(2719,2729)
    push HL             ; 1:11      push2(2719,2729)
    ld   HL, 2729       ; 3:10      push2(2719,2729) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2731,2741)
    ld   DE, 2731       ; 3:10      push2(2731,2741)
    push HL             ; 1:11      push2(2731,2741)
    ld   HL, 2741       ; 3:10      push2(2731,2741) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2749,2753)
    ld   DE, 2749       ; 3:10      push2(2749,2753)
    push HL             ; 1:11      push2(2749,2753)
    ld   HL, 2753       ; 3:10      push2(2749,2753)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2767,2777)
    ld   DE, 2767       ; 3:10      push2(2767,2777)
    push HL             ; 1:11      push2(2767,2777)
    ld   HL, 2777       ; 3:10      push2(2767,2777) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2789,2791)
    ld   DE, 2789       ; 3:10      push2(2789,2791)
    push HL             ; 1:11      push2(2789,2791)
    ld   HL, 2791       ; 3:10      push2(2789,2791) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2797,2801)
    ld   DE, 2797       ; 3:10      push2(2797,2801)
    push HL             ; 1:11      push2(2797,2801)
    ld   HL, 2801       ; 3:10      push2(2797,2801) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2803,2819)
    ld   DE, 2803       ; 3:10      push2(2803,2819)
    push HL             ; 1:11      push2(2803,2819)
    ld   HL, 2819       ; 3:10      push2(2803,2819) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2833,2837)
    ld   DE, 2833       ; 3:10      push2(2833,2837)
    push HL             ; 1:11      push2(2833,2837)
    ld   HL, 2837       ; 3:10      push2(2833,2837)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2843,2851)
    ld   DE, 2843       ; 3:10      push2(2843,2851)
    push HL             ; 1:11      push2(2843,2851)
    ld   HL, 2851       ; 3:10      push2(2843,2851) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2857,2861)
    ld   DE, 2857       ; 3:10      push2(2857,2861)
    push HL             ; 1:11      push2(2857,2861)
    ld   HL, 2861       ; 3:10      push2(2857,2861) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2879,2887)
    ld   DE, 2879       ; 3:10      push2(2879,2887)
    push HL             ; 1:11      push2(2879,2887)
    ld   HL, 2887       ; 3:10      push2(2879,2887) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2897,2903)
    ld   DE, 2897       ; 3:10      push2(2897,2903)
    push HL             ; 1:11      push2(2897,2903)
    ld   HL, 2903       ; 3:10      push2(2897,2903) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(2909,2917)
    ld   DE, 2909       ; 3:10      push2(2909,2917)
    push HL             ; 1:11      push2(2909,2917)
    ld   HL, 2917       ; 3:10      push2(2909,2917)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2927,2939)
    ld   DE, 2927       ; 3:10      push2(2927,2939)
    push HL             ; 1:11      push2(2927,2939)
    ld   HL, 2939       ; 3:10      push2(2927,2939) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2953,2957)
    ld   DE, 2953       ; 3:10      push2(2953,2957)
    push HL             ; 1:11      push2(2953,2957)
    ld   HL, 2957       ; 3:10      push2(2953,2957) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2963,2969)
    ld   DE, 2963       ; 3:10      push2(2963,2969)
    push HL             ; 1:11      push2(2963,2969)
    ld   HL, 2969       ; 3:10      push2(2963,2969) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(2971,2999)
    ld   DE, 2971       ; 3:10      push2(2971,2999)
    push HL             ; 1:11      push2(2971,2999)
    ld   HL, 2999       ; 3:10      push2(2971,2999) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3001,3011)
    ld   DE, 3001       ; 3:10      push2(3001,3011)
    push HL             ; 1:11      push2(3001,3011)
    ld   HL, 3011       ; 3:10      push2(3001,3011)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3019,3023)
    ld   DE, 3019       ; 3:10      push2(3019,3023)
    push HL             ; 1:11      push2(3019,3023)
    ld   HL, 3023       ; 3:10      push2(3019,3023) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3037,3041)
    ld   DE, 3037       ; 3:10      push2(3037,3041)
    push HL             ; 1:11      push2(3037,3041)
    ld   HL, 3041       ; 3:10      push2(3037,3041) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3049,3061)
    ld   DE, 3049       ; 3:10      push2(3049,3061)
    push HL             ; 1:11      push2(3049,3061)
    ld   HL, 3061       ; 3:10      push2(3049,3061) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3067,3079)
    ld   DE, 3067       ; 3:10      push2(3067,3079)
    push HL             ; 1:11      push2(3067,3079)
    ld   HL, 3079       ; 3:10      push2(3067,3079) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3083,3089)
    ld   DE, 3083       ; 3:10      push2(3083,3089)
    push HL             ; 1:11      push2(3083,3089)
    ld   HL, 3089       ; 3:10      push2(3083,3089)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3109,3119)
    ld   DE, 3109       ; 3:10      push2(3109,3119)
    push HL             ; 1:11      push2(3109,3119)
    ld   HL, 3119       ; 3:10      push2(3109,3119) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3121,3137)
    ld   DE, 3121       ; 3:10      push2(3121,3137)
    push HL             ; 1:11      push2(3121,3137)
    ld   HL, 3137       ; 3:10      push2(3121,3137) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3163,3167)
    ld   DE, 3163       ; 3:10      push2(3163,3167)
    push HL             ; 1:11      push2(3163,3167)
    ld   HL, 3167       ; 3:10      push2(3163,3167) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3169,3181)
    ld   DE, 3169       ; 3:10      push2(3169,3181)
    push HL             ; 1:11      push2(3169,3181)
    ld   HL, 3181       ; 3:10      push2(3169,3181) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3187,3191)
    ld   DE, 3187       ; 3:10      push2(3187,3191)
    push HL             ; 1:11      push2(3187,3191)
    ld   HL, 3191       ; 3:10      push2(3187,3191)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3203,3209)
    ld   DE, 3203       ; 3:10      push2(3203,3209)
    push HL             ; 1:11      push2(3203,3209)
    ld   HL, 3209       ; 3:10      push2(3203,3209) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3217,3221)
    ld   DE, 3217       ; 3:10      push2(3217,3221)
    push HL             ; 1:11      push2(3217,3221)
    ld   HL, 3221       ; 3:10      push2(3217,3221) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3229,3251)
    ld   DE, 3229       ; 3:10      push2(3229,3251)
    push HL             ; 1:11      push2(3229,3251)
    ld   HL, 3251       ; 3:10      push2(3229,3251) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3253,3257)
    ld   DE, 3253       ; 3:10      push2(3253,3257)
    push HL             ; 1:11      push2(3253,3257)
    ld   HL, 3257       ; 3:10      push2(3253,3257) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3259,3271)
    ld   DE, 3259       ; 3:10      push2(3259,3271)
    push HL             ; 1:11      push2(3259,3271)
    ld   HL, 3271       ; 3:10      push2(3259,3271)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3299,3301)
    ld   DE, 3299       ; 3:10      push2(3299,3301)
    push HL             ; 1:11      push2(3299,3301)
    ld   HL, 3301       ; 3:10      push2(3299,3301) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3307,3313)
    ld   DE, 3307       ; 3:10      push2(3307,3313)
    push HL             ; 1:11      push2(3307,3313)
    ld   HL, 3313       ; 3:10      push2(3307,3313) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3319,3323)
    ld   DE, 3319       ; 3:10      push2(3319,3323)
    push HL             ; 1:11      push2(3319,3323)
    ld   HL, 3323       ; 3:10      push2(3319,3323) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3329,3331)
    ld   DE, 3329       ; 3:10      push2(3329,3331)
    push HL             ; 1:11      push2(3329,3331)
    ld   HL, 3331       ; 3:10      push2(3329,3331) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3343,3347)
    ld   DE, 3343       ; 3:10      push2(3343,3347)
    push HL             ; 1:11      push2(3343,3347)
    ld   HL, 3347       ; 3:10      push2(3343,3347)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3359,3361)
    ld   DE, 3359       ; 3:10      push2(3359,3361)
    push HL             ; 1:11      push2(3359,3361)
    ld   HL, 3361       ; 3:10      push2(3359,3361) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3371,3373)
    ld   DE, 3371       ; 3:10      push2(3371,3373)
    push HL             ; 1:11      push2(3371,3373)
    ld   HL, 3373       ; 3:10      push2(3371,3373) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3389,3391)
    ld   DE, 3389       ; 3:10      push2(3389,3391)
    push HL             ; 1:11      push2(3389,3391)
    ld   HL, 3391       ; 3:10      push2(3389,3391) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3407,3413)
    ld   DE, 3407       ; 3:10      push2(3407,3413)
    push HL             ; 1:11      push2(3407,3413)
    ld   HL, 3413       ; 3:10      push2(3407,3413) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3433,3449)
    ld   DE, 3433       ; 3:10      push2(3433,3449)
    push HL             ; 1:11      push2(3433,3449)
    ld   HL, 3449       ; 3:10      push2(3433,3449)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3457,3461)
    ld   DE, 3457       ; 3:10      push2(3457,3461)
    push HL             ; 1:11      push2(3457,3461)
    ld   HL, 3461       ; 3:10      push2(3457,3461) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3463,3467)
    ld   DE, 3463       ; 3:10      push2(3463,3467)
    push HL             ; 1:11      push2(3463,3467)
    ld   HL, 3467       ; 3:10      push2(3463,3467) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3469,3491)
    ld   DE, 3469       ; 3:10      push2(3469,3491)
    push HL             ; 1:11      push2(3469,3491)
    ld   HL, 3491       ; 3:10      push2(3469,3491) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3499,3511)
    ld   DE, 3499       ; 3:10      push2(3499,3511)
    push HL             ; 1:11      push2(3499,3511)
    ld   HL, 3511       ; 3:10      push2(3499,3511) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3517,3527)
    ld   DE, 3517       ; 3:10      push2(3517,3527)
    push HL             ; 1:11      push2(3517,3527)
    ld   HL, 3527       ; 3:10      push2(3517,3527)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3529,3533)
    ld   DE, 3529       ; 3:10      push2(3529,3533)
    push HL             ; 1:11      push2(3529,3533)
    ld   HL, 3533       ; 3:10      push2(3529,3533) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3539,3541)
    ld   DE, 3539       ; 3:10      push2(3539,3541)
    push HL             ; 1:11      push2(3539,3541)
    ld   HL, 3541       ; 3:10      push2(3539,3541) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3547,3557)
    ld   DE, 3547       ; 3:10      push2(3547,3557)
    push HL             ; 1:11      push2(3547,3557)
    ld   HL, 3557       ; 3:10      push2(3547,3557) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3559,3571)
    ld   DE, 3559       ; 3:10      push2(3559,3571)
    push HL             ; 1:11      push2(3559,3571)
    ld   HL, 3571       ; 3:10      push2(3559,3571) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3581,3583)
    ld   DE, 3581       ; 3:10      push2(3581,3583)
    push HL             ; 1:11      push2(3581,3583)
    ld   HL, 3583       ; 3:10      push2(3581,3583)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3593,3607)
    ld   DE, 3593       ; 3:10      push2(3593,3607)
    push HL             ; 1:11      push2(3593,3607)
    ld   HL, 3607       ; 3:10      push2(3593,3607) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3613,3617)
    ld   DE, 3613       ; 3:10      push2(3613,3617)
    push HL             ; 1:11      push2(3613,3617)
    ld   HL, 3617       ; 3:10      push2(3613,3617) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3623,3631)
    ld   DE, 3623       ; 3:10      push2(3623,3631)
    push HL             ; 1:11      push2(3623,3631)
    ld   HL, 3631       ; 3:10      push2(3623,3631) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3637,3643)
    ld   DE, 3637       ; 3:10      push2(3637,3643)
    push HL             ; 1:11      push2(3637,3643)
    ld   HL, 3643       ; 3:10      push2(3637,3643) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3659,3671)
    ld   DE, 3659       ; 3:10      push2(3659,3671)
    push HL             ; 1:11      push2(3659,3671)
    ld   HL, 3671       ; 3:10      push2(3659,3671)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3673,3677)
    ld   DE, 3673       ; 3:10      push2(3673,3677)
    push HL             ; 1:11      push2(3673,3677)
    ld   HL, 3677       ; 3:10      push2(3673,3677) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3691,3697)
    ld   DE, 3691       ; 3:10      push2(3691,3697)
    push HL             ; 1:11      push2(3691,3697)
    ld   HL, 3697       ; 3:10      push2(3691,3697) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3701,3709)
    ld   DE, 3701       ; 3:10      push2(3701,3709)
    push HL             ; 1:11      push2(3701,3709)
    ld   HL, 3709       ; 3:10      push2(3701,3709) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3719,3727)
    ld   DE, 3719       ; 3:10      push2(3719,3727)
    push HL             ; 1:11      push2(3719,3727)
    ld   HL, 3727       ; 3:10      push2(3719,3727) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3733,3739)
    ld   DE, 3733       ; 3:10      push2(3733,3739)
    push HL             ; 1:11      push2(3733,3739)
    ld   HL, 3739       ; 3:10      push2(3733,3739)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3761,3767)
    ld   DE, 3761       ; 3:10      push2(3761,3767)
    push HL             ; 1:11      push2(3761,3767)
    ld   HL, 3767       ; 3:10      push2(3761,3767) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3769,3779)
    ld   DE, 3769       ; 3:10      push2(3769,3779)
    push HL             ; 1:11      push2(3769,3779)
    ld   HL, 3779       ; 3:10      push2(3769,3779) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3793,3797)
    ld   DE, 3793       ; 3:10      push2(3793,3797)
    push HL             ; 1:11      push2(3793,3797)
    ld   HL, 3797       ; 3:10      push2(3793,3797) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3803,3821)
    ld   DE, 3803       ; 3:10      push2(3803,3821)
    push HL             ; 1:11      push2(3803,3821)
    ld   HL, 3821       ; 3:10      push2(3803,3821) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3823,3833)
    ld   DE, 3823       ; 3:10      push2(3823,3833)
    push HL             ; 1:11      push2(3823,3833)
    ld   HL, 3833       ; 3:10      push2(3823,3833)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3847,3851)
    ld   DE, 3847       ; 3:10      push2(3847,3851)
    push HL             ; 1:11      push2(3847,3851)
    ld   HL, 3851       ; 3:10      push2(3847,3851) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3853,3863)
    ld   DE, 3853       ; 3:10      push2(3853,3863)
    push HL             ; 1:11      push2(3853,3863)
    ld   HL, 3863       ; 3:10      push2(3853,3863) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3877,3881)
    ld   DE, 3877       ; 3:10      push2(3877,3881)
    push HL             ; 1:11      push2(3877,3881)
    ld   HL, 3881       ; 3:10      push2(3877,3881) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3889,3907)
    ld   DE, 3889       ; 3:10      push2(3889,3907)
    push HL             ; 1:11      push2(3889,3907)
    ld   HL, 3907       ; 3:10      push2(3889,3907) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(3911,3917)
    ld   DE, 3911       ; 3:10      push2(3911,3917)
    push HL             ; 1:11      push2(3911,3917)
    ld   HL, 3917       ; 3:10      push2(3911,3917)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3919,3923)
    ld   DE, 3919       ; 3:10      push2(3919,3923)
    push HL             ; 1:11      push2(3919,3923)
    ld   HL, 3923       ; 3:10      push2(3919,3923) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3929,3931)
    ld   DE, 3929       ; 3:10      push2(3929,3931)
    push HL             ; 1:11      push2(3929,3931)
    ld   HL, 3931       ; 3:10      push2(3929,3931) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3943,3947)
    ld   DE, 3943       ; 3:10      push2(3943,3947)
    push HL             ; 1:11      push2(3943,3947)
    ld   HL, 3947       ; 3:10      push2(3943,3947) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(3967,3989)
    ld   DE, 3967       ; 3:10      push2(3967,3989)
    push HL             ; 1:11      push2(3967,3989)
    ld   HL, 3989       ; 3:10      push2(3967,3989) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4001,4003)
    ld   DE, 4001       ; 3:10      push2(4001,4003)
    push HL             ; 1:11      push2(4001,4003)
    ld   HL, 4003       ; 3:10      push2(4001,4003)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4007,4013)
    ld   DE, 4007       ; 3:10      push2(4007,4013)
    push HL             ; 1:11      push2(4007,4013)
    ld   HL, 4013       ; 3:10      push2(4007,4013) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4019,4021)
    ld   DE, 4019       ; 3:10      push2(4019,4021)
    push HL             ; 1:11      push2(4019,4021)
    ld   HL, 4021       ; 3:10      push2(4019,4021) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4027,4049)
    ld   DE, 4027       ; 3:10      push2(4027,4049)
    push HL             ; 1:11      push2(4027,4049)
    ld   HL, 4049       ; 3:10      push2(4027,4049) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4051,4057)
    ld   DE, 4051       ; 3:10      push2(4051,4057)
    push HL             ; 1:11      push2(4051,4057)
    ld   HL, 4057       ; 3:10      push2(4051,4057) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4073,4079)
    ld   DE, 4073       ; 3:10      push2(4073,4079)
    push HL             ; 1:11      push2(4073,4079)
    ld   HL, 4079       ; 3:10      push2(4073,4079)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4091,4093)
    ld   DE, 4091       ; 3:10      push2(4091,4093)
    push HL             ; 1:11      push2(4091,4093)
    ld   HL, 4093       ; 3:10      push2(4091,4093) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4099,4111)
    ld   DE, 4099       ; 3:10      push2(4099,4111)
    push HL             ; 1:11      push2(4099,4111)
    ld   HL, 4111       ; 3:10      push2(4099,4111) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4127,4129)
    ld   DE, 4127       ; 3:10      push2(4127,4129)
    push HL             ; 1:11      push2(4127,4129)
    ld   HL, 4129       ; 3:10      push2(4127,4129) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4133,4139)
    ld   DE, 4133       ; 3:10      push2(4133,4139)
    push HL             ; 1:11      push2(4133,4139)
    ld   HL, 4139       ; 3:10      push2(4133,4139) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4153,4157)
    ld   DE, 4153       ; 3:10      push2(4153,4157)
    push HL             ; 1:11      push2(4153,4157)
    ld   HL, 4157       ; 3:10      push2(4153,4157)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4159,4177)
    ld   DE, 4159       ; 3:10      push2(4159,4177)
    push HL             ; 1:11      push2(4159,4177)
    ld   HL, 4177       ; 3:10      push2(4159,4177) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4201,4211)
    ld   DE, 4201       ; 3:10      push2(4201,4211)
    push HL             ; 1:11      push2(4201,4211)
    ld   HL, 4211       ; 3:10      push2(4201,4211) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4217,4219)
    ld   DE, 4217       ; 3:10      push2(4217,4219)
    push HL             ; 1:11      push2(4217,4219)
    ld   HL, 4219       ; 3:10      push2(4217,4219) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4229,4231)
    ld   DE, 4229       ; 3:10      push2(4229,4231)
    push HL             ; 1:11      push2(4229,4231)
    ld   HL, 4231       ; 3:10      push2(4229,4231) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4241,4243)
    ld   DE, 4241       ; 3:10      push2(4241,4243)
    push HL             ; 1:11      push2(4241,4243)
    ld   HL, 4243       ; 3:10      push2(4241,4243)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4253,4259)
    ld   DE, 4253       ; 3:10      push2(4253,4259)
    push HL             ; 1:11      push2(4253,4259)
    ld   HL, 4259       ; 3:10      push2(4253,4259) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4261,4271)
    ld   DE, 4261       ; 3:10      push2(4261,4271)
    push HL             ; 1:11      push2(4261,4271)
    ld   HL, 4271       ; 3:10      push2(4261,4271) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4273,4283)
    ld   DE, 4273       ; 3:10      push2(4273,4283)
    push HL             ; 1:11      push2(4273,4283)
    ld   HL, 4283       ; 3:10      push2(4273,4283) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4289,4297)
    ld   DE, 4289       ; 3:10      push2(4289,4297)
    push HL             ; 1:11      push2(4289,4297)
    ld   HL, 4297       ; 3:10      push2(4289,4297) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4327,4337)
    ld   DE, 4327       ; 3:10      push2(4327,4337)
    push HL             ; 1:11      push2(4327,4337)
    ld   HL, 4337       ; 3:10      push2(4327,4337)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4339,4349)
    ld   DE, 4339       ; 3:10      push2(4339,4349)
    push HL             ; 1:11      push2(4339,4349)
    ld   HL, 4349       ; 3:10      push2(4339,4349) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4357,4363)
    ld   DE, 4357       ; 3:10      push2(4357,4363)
    push HL             ; 1:11      push2(4357,4363)
    ld   HL, 4363       ; 3:10      push2(4357,4363) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4373,4391)
    ld   DE, 4373       ; 3:10      push2(4373,4391)
    push HL             ; 1:11      push2(4373,4391)
    ld   HL, 4391       ; 3:10      push2(4373,4391) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4397,4409)
    ld   DE, 4397       ; 3:10      push2(4397,4409)
    push HL             ; 1:11      push2(4397,4409)
    ld   HL, 4409       ; 3:10      push2(4397,4409) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4421,4423)
    ld   DE, 4421       ; 3:10      push2(4421,4423)
    push HL             ; 1:11      push2(4421,4423)
    ld   HL, 4423       ; 3:10      push2(4421,4423)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4441,4447)
    ld   DE, 4441       ; 3:10      push2(4441,4447)
    push HL             ; 1:11      push2(4441,4447)
    ld   HL, 4447       ; 3:10      push2(4441,4447) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4451,4457)
    ld   DE, 4451       ; 3:10      push2(4451,4457)
    push HL             ; 1:11      push2(4451,4457)
    ld   HL, 4457       ; 3:10      push2(4451,4457) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4463,4481)
    ld   DE, 4463       ; 3:10      push2(4463,4481)
    push HL             ; 1:11      push2(4463,4481)
    ld   HL, 4481       ; 3:10      push2(4463,4481) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4483,4493)
    ld   DE, 4483       ; 3:10      push2(4483,4493)
    push HL             ; 1:11      push2(4483,4493)
    ld   HL, 4493       ; 3:10      push2(4483,4493) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4507,4513)
    ld   DE, 4507       ; 3:10      push2(4507,4513)
    push HL             ; 1:11      push2(4507,4513)
    ld   HL, 4513       ; 3:10      push2(4507,4513)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4517,4519)
    ld   DE, 4517       ; 3:10      push2(4517,4519)
    push HL             ; 1:11      push2(4517,4519)
    ld   HL, 4519       ; 3:10      push2(4517,4519) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4523,4547)
    ld   DE, 4523       ; 3:10      push2(4523,4547)
    push HL             ; 1:11      push2(4523,4547)
    ld   HL, 4547       ; 3:10      push2(4523,4547) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4549,4561)
    ld   DE, 4549       ; 3:10      push2(4549,4561)
    push HL             ; 1:11      push2(4549,4561)
    ld   HL, 4561       ; 3:10      push2(4549,4561) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4567,4583)
    ld   DE, 4567       ; 3:10      push2(4567,4583)
    push HL             ; 1:11      push2(4567,4583)
    ld   HL, 4583       ; 3:10      push2(4567,4583) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4591,4597)
    ld   DE, 4591       ; 3:10      push2(4591,4597)
    push HL             ; 1:11      push2(4591,4597)
    ld   HL, 4597       ; 3:10      push2(4591,4597)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4603,4621)
    ld   DE, 4603       ; 3:10      push2(4603,4621)
    push HL             ; 1:11      push2(4603,4621)
    ld   HL, 4621       ; 3:10      push2(4603,4621) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4637,4639)
    ld   DE, 4637       ; 3:10      push2(4637,4639)
    push HL             ; 1:11      push2(4637,4639)
    ld   HL, 4639       ; 3:10      push2(4637,4639) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4643,4649)
    ld   DE, 4643       ; 3:10      push2(4643,4649)
    push HL             ; 1:11      push2(4643,4649)
    ld   HL, 4649       ; 3:10      push2(4643,4649) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4651,4657)
    ld   DE, 4651       ; 3:10      push2(4651,4657)
    push HL             ; 1:11      push2(4651,4657)
    ld   HL, 4657       ; 3:10      push2(4651,4657) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4663,4673)
    ld   DE, 4663       ; 3:10      push2(4663,4673)
    push HL             ; 1:11      push2(4663,4673)
    ld   HL, 4673       ; 3:10      push2(4663,4673)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4679,4691)
    ld   DE, 4679       ; 3:10      push2(4679,4691)
    push HL             ; 1:11      push2(4679,4691)
    ld   HL, 4691       ; 3:10      push2(4679,4691) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4703,4721)
    ld   DE, 4703       ; 3:10      push2(4703,4721)
    push HL             ; 1:11      push2(4703,4721)
    ld   HL, 4721       ; 3:10      push2(4703,4721) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4723,4729)
    ld   DE, 4723       ; 3:10      push2(4723,4729)
    push HL             ; 1:11      push2(4723,4729)
    ld   HL, 4729       ; 3:10      push2(4723,4729) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4733,4751)
    ld   DE, 4733       ; 3:10      push2(4733,4751)
    push HL             ; 1:11      push2(4733,4751)
    ld   HL, 4751       ; 3:10      push2(4733,4751) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4759,4783)
    ld   DE, 4759       ; 3:10      push2(4759,4783)
    push HL             ; 1:11      push2(4759,4783)
    ld   HL, 4783       ; 3:10      push2(4759,4783)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4787,4789)
    ld   DE, 4787       ; 3:10      push2(4787,4789)
    push HL             ; 1:11      push2(4787,4789)
    ld   HL, 4789       ; 3:10      push2(4787,4789) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4793,4799)
    ld   DE, 4793       ; 3:10      push2(4793,4799)
    push HL             ; 1:11      push2(4793,4799)
    ld   HL, 4799       ; 3:10      push2(4793,4799) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4801,4813)
    ld   DE, 4801       ; 3:10      push2(4801,4813)
    push HL             ; 1:11      push2(4801,4813)
    ld   HL, 4813       ; 3:10      push2(4801,4813) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4817,4831)
    ld   DE, 4817       ; 3:10      push2(4817,4831)
    push HL             ; 1:11      push2(4817,4831)
    ld   HL, 4831       ; 3:10      push2(4817,4831) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4861,4871)
    ld   DE, 4861       ; 3:10      push2(4861,4871)
    push HL             ; 1:11      push2(4861,4871)
    ld   HL, 4871       ; 3:10      push2(4861,4871)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4877,4889)
    ld   DE, 4877       ; 3:10      push2(4877,4889)
    push HL             ; 1:11      push2(4877,4889)
    ld   HL, 4889       ; 3:10      push2(4877,4889) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4903,4909)
    ld   DE, 4903       ; 3:10      push2(4903,4909)
    push HL             ; 1:11      push2(4903,4909)
    ld   HL, 4909       ; 3:10      push2(4903,4909) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4919,4931)
    ld   DE, 4919       ; 3:10      push2(4919,4931)
    push HL             ; 1:11      push2(4919,4931)
    ld   HL, 4931       ; 3:10      push2(4919,4931) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4933,4937)
    ld   DE, 4933       ; 3:10      push2(4933,4937)
    push HL             ; 1:11      push2(4933,4937)
    ld   HL, 4937       ; 3:10      push2(4933,4937) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(4943,4951)
    ld   DE, 4943       ; 3:10      push2(4943,4951)
    push HL             ; 1:11      push2(4943,4951)
    ld   HL, 4951       ; 3:10      push2(4943,4951)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4957,4967)
    ld   DE, 4957       ; 3:10      push2(4957,4967)
    push HL             ; 1:11      push2(4957,4967)
    ld   HL, 4967       ; 3:10      push2(4957,4967) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4969,4973)
    ld   DE, 4969       ; 3:10      push2(4969,4973)
    push HL             ; 1:11      push2(4969,4973)
    ld   HL, 4973       ; 3:10      push2(4969,4973) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4987,4993)
    ld   DE, 4987       ; 3:10      push2(4987,4993)
    push HL             ; 1:11      push2(4987,4993)
    ld   HL, 4993       ; 3:10      push2(4987,4993) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(4999,5003)
    ld   DE, 4999       ; 3:10      push2(4999,5003)
    push HL             ; 1:11      push2(4999,5003)
    ld   HL, 5003       ; 3:10      push2(4999,5003) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5009,5011)
    ld   DE, 5009       ; 3:10      push2(5009,5011)
    push HL             ; 1:11      push2(5009,5011)
    ld   HL, 5011       ; 3:10      push2(5009,5011)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5021,5023)
    ld   DE, 5021       ; 3:10      push2(5021,5023)
    push HL             ; 1:11      push2(5021,5023)
    ld   HL, 5023       ; 3:10      push2(5021,5023) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5039,5051)
    ld   DE, 5039       ; 3:10      push2(5039,5051)
    push HL             ; 1:11      push2(5039,5051)
    ld   HL, 5051       ; 3:10      push2(5039,5051) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5059,5077)
    ld   DE, 5059       ; 3:10      push2(5059,5077)
    push HL             ; 1:11      push2(5059,5077)
    ld   HL, 5077       ; 3:10      push2(5059,5077) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5081,5087)
    ld   DE, 5081       ; 3:10      push2(5081,5087)
    push HL             ; 1:11      push2(5081,5087)
    ld   HL, 5087       ; 3:10      push2(5081,5087) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5099,5101)
    ld   DE, 5099       ; 3:10      push2(5099,5101)
    push HL             ; 1:11      push2(5099,5101)
    ld   HL, 5101       ; 3:10      push2(5099,5101)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5107,5113)
    ld   DE, 5107       ; 3:10      push2(5107,5113)
    push HL             ; 1:11      push2(5107,5113)
    ld   HL, 5113       ; 3:10      push2(5107,5113) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5119,5147)
    ld   DE, 5119       ; 3:10      push2(5119,5147)
    push HL             ; 1:11      push2(5119,5147)
    ld   HL, 5147       ; 3:10      push2(5119,5147) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5153,5167)
    ld   DE, 5153       ; 3:10      push2(5153,5167)
    push HL             ; 1:11      push2(5153,5167)
    ld   HL, 5167       ; 3:10      push2(5153,5167) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5171,5179)
    ld   DE, 5171       ; 3:10      push2(5171,5179)
    push HL             ; 1:11      push2(5171,5179)
    ld   HL, 5179       ; 3:10      push2(5171,5179) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5189,5197)
    ld   DE, 5189       ; 3:10      push2(5189,5197)
    push HL             ; 1:11      push2(5189,5197)
    ld   HL, 5197       ; 3:10      push2(5189,5197)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5209,5227)
    ld   DE, 5209       ; 3:10      push2(5209,5227)
    push HL             ; 1:11      push2(5209,5227)
    ld   HL, 5227       ; 3:10      push2(5209,5227) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5231,5233)
    ld   DE, 5231       ; 3:10      push2(5231,5233)
    push HL             ; 1:11      push2(5231,5233)
    ld   HL, 5233       ; 3:10      push2(5231,5233) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5237,5261)
    ld   DE, 5237       ; 3:10      push2(5237,5261)
    push HL             ; 1:11      push2(5237,5261)
    ld   HL, 5261       ; 3:10      push2(5237,5261) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5273,5279)
    ld   DE, 5273       ; 3:10      push2(5273,5279)
    push HL             ; 1:11      push2(5273,5279)
    ld   HL, 5279       ; 3:10      push2(5273,5279) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5281,5297)
    ld   DE, 5281       ; 3:10      push2(5281,5297)
    push HL             ; 1:11      push2(5281,5297)
    ld   HL, 5297       ; 3:10      push2(5281,5297)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5303,5309)
    ld   DE, 5303       ; 3:10      push2(5303,5309)
    push HL             ; 1:11      push2(5303,5309)
    ld   HL, 5309       ; 3:10      push2(5303,5309) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5323,5333)
    ld   DE, 5323       ; 3:10      push2(5323,5333)
    push HL             ; 1:11      push2(5323,5333)
    ld   HL, 5333       ; 3:10      push2(5323,5333) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5347,5351)
    ld   DE, 5347       ; 3:10      push2(5347,5351)
    push HL             ; 1:11      push2(5347,5351)
    ld   HL, 5351       ; 3:10      push2(5347,5351) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5381,5387)
    ld   DE, 5381       ; 3:10      push2(5381,5387)
    push HL             ; 1:11      push2(5381,5387)
    ld   HL, 5387       ; 3:10      push2(5381,5387) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5393,5399)
    ld   DE, 5393       ; 3:10      push2(5393,5399)
    push HL             ; 1:11      push2(5393,5399)
    ld   HL, 5399       ; 3:10      push2(5393,5399)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5407,5413)
    ld   DE, 5407       ; 3:10      push2(5407,5413)
    push HL             ; 1:11      push2(5407,5413)
    ld   HL, 5413       ; 3:10      push2(5407,5413) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5417,5419)
    ld   DE, 5417       ; 3:10      push2(5417,5419)
    push HL             ; 1:11      push2(5417,5419)
    ld   HL, 5419       ; 3:10      push2(5417,5419) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5431,5437)
    ld   DE, 5431       ; 3:10      push2(5431,5437)
    push HL             ; 1:11      push2(5431,5437)
    ld   HL, 5437       ; 3:10      push2(5431,5437) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5441,5443)
    ld   DE, 5441       ; 3:10      push2(5441,5443)
    push HL             ; 1:11      push2(5441,5443)
    ld   HL, 5443       ; 3:10      push2(5441,5443) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5449,5471)
    ld   DE, 5449       ; 3:10      push2(5449,5471)
    push HL             ; 1:11      push2(5449,5471)
    ld   HL, 5471       ; 3:10      push2(5449,5471)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5477,5479)
    ld   DE, 5477       ; 3:10      push2(5477,5479)
    push HL             ; 1:11      push2(5477,5479)
    ld   HL, 5479       ; 3:10      push2(5477,5479) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5483,5501)
    ld   DE, 5483       ; 3:10      push2(5483,5501)
    push HL             ; 1:11      push2(5483,5501)
    ld   HL, 5501       ; 3:10      push2(5483,5501) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5503,5507)
    ld   DE, 5503       ; 3:10      push2(5503,5507)
    push HL             ; 1:11      push2(5503,5507)
    ld   HL, 5507       ; 3:10      push2(5503,5507) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5519,5521)
    ld   DE, 5519       ; 3:10      push2(5519,5521)
    push HL             ; 1:11      push2(5519,5521)
    ld   HL, 5521       ; 3:10      push2(5519,5521) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5527,5531)
    ld   DE, 5527       ; 3:10      push2(5527,5531)
    push HL             ; 1:11      push2(5527,5531)
    ld   HL, 5531       ; 3:10      push2(5527,5531)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5557,5563)
    ld   DE, 5557       ; 3:10      push2(5557,5563)
    push HL             ; 1:11      push2(5557,5563)
    ld   HL, 5563       ; 3:10      push2(5557,5563) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5569,5573)
    ld   DE, 5569       ; 3:10      push2(5569,5573)
    push HL             ; 1:11      push2(5569,5573)
    ld   HL, 5573       ; 3:10      push2(5569,5573) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5581,5591)
    ld   DE, 5581       ; 3:10      push2(5581,5591)
    push HL             ; 1:11      push2(5581,5591)
    ld   HL, 5591       ; 3:10      push2(5581,5591) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5623,5639)
    ld   DE, 5623       ; 3:10      push2(5623,5639)
    push HL             ; 1:11      push2(5623,5639)
    ld   HL, 5639       ; 3:10      push2(5623,5639) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5641,5647)
    ld   DE, 5641       ; 3:10      push2(5641,5647)
    push HL             ; 1:11      push2(5641,5647)
    ld   HL, 5647       ; 3:10      push2(5641,5647)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5651,5653)
    ld   DE, 5651       ; 3:10      push2(5651,5653)
    push HL             ; 1:11      push2(5651,5653)
    ld   HL, 5653       ; 3:10      push2(5651,5653) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5657,5659)
    ld   DE, 5657       ; 3:10      push2(5657,5659)
    push HL             ; 1:11      push2(5657,5659)
    ld   HL, 5659       ; 3:10      push2(5657,5659) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5669,5683)
    ld   DE, 5669       ; 3:10      push2(5669,5683)
    push HL             ; 1:11      push2(5669,5683)
    ld   HL, 5683       ; 3:10      push2(5669,5683) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5689,5693)
    ld   DE, 5689       ; 3:10      push2(5689,5693)
    push HL             ; 1:11      push2(5689,5693)
    ld   HL, 5693       ; 3:10      push2(5689,5693) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5701,5711)
    ld   DE, 5701       ; 3:10      push2(5701,5711)
    push HL             ; 1:11      push2(5701,5711)
    ld   HL, 5711       ; 3:10      push2(5701,5711)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5717,5737)
    ld   DE, 5717       ; 3:10      push2(5717,5737)
    push HL             ; 1:11      push2(5717,5737)
    ld   HL, 5737       ; 3:10      push2(5717,5737) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5741,5743)
    ld   DE, 5741       ; 3:10      push2(5741,5743)
    push HL             ; 1:11      push2(5741,5743)
    ld   HL, 5743       ; 3:10      push2(5741,5743) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5749,5779)
    ld   DE, 5749       ; 3:10      push2(5749,5779)
    push HL             ; 1:11      push2(5749,5779)
    ld   HL, 5779       ; 3:10      push2(5749,5779) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5783,5791)
    ld   DE, 5783       ; 3:10      push2(5783,5791)
    push HL             ; 1:11      push2(5783,5791)
    ld   HL, 5791       ; 3:10      push2(5783,5791) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5801,5807)
    ld   DE, 5801       ; 3:10      push2(5801,5807)
    push HL             ; 1:11      push2(5801,5807)
    ld   HL, 5807       ; 3:10      push2(5801,5807)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5813,5821)
    ld   DE, 5813       ; 3:10      push2(5813,5821)
    push HL             ; 1:11      push2(5813,5821)
    ld   HL, 5821       ; 3:10      push2(5813,5821) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5827,5839)
    ld   DE, 5827       ; 3:10      push2(5827,5839)
    push HL             ; 1:11      push2(5827,5839)
    ld   HL, 5839       ; 3:10      push2(5827,5839) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5843,5849)
    ld   DE, 5843       ; 3:10      push2(5843,5849)
    push HL             ; 1:11      push2(5843,5849)
    ld   HL, 5849       ; 3:10      push2(5843,5849) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5851,5857)
    ld   DE, 5851       ; 3:10      push2(5851,5857)
    push HL             ; 1:11      push2(5851,5857)
    ld   HL, 5857       ; 3:10      push2(5851,5857) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5861,5867)
    ld   DE, 5861       ; 3:10      push2(5861,5867)
    push HL             ; 1:11      push2(5861,5867)
    ld   HL, 5867       ; 3:10      push2(5861,5867)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5869,5879)
    ld   DE, 5869       ; 3:10      push2(5869,5879)
    push HL             ; 1:11      push2(5869,5879)
    ld   HL, 5879       ; 3:10      push2(5869,5879) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5881,5897)
    ld   DE, 5881       ; 3:10      push2(5881,5897)
    push HL             ; 1:11      push2(5881,5897)
    ld   HL, 5897       ; 3:10      push2(5881,5897) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5903,5923)
    ld   DE, 5903       ; 3:10      push2(5903,5923)
    push HL             ; 1:11      push2(5903,5923)
    ld   HL, 5923       ; 3:10      push2(5903,5923) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5927,5939)
    ld   DE, 5927       ; 3:10      push2(5927,5939)
    push HL             ; 1:11      push2(5927,5939)
    ld   HL, 5939       ; 3:10      push2(5927,5939) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(5953,5981)
    ld   DE, 5953       ; 3:10      push2(5953,5981)
    push HL             ; 1:11      push2(5953,5981)
    ld   HL, 5981       ; 3:10      push2(5953,5981)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(5987,6007)
    ld   DE, 5987       ; 3:10      push2(5987,6007)
    push HL             ; 1:11      push2(5987,6007)
    ld   HL, 6007       ; 3:10      push2(5987,6007) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6011,6029)
    ld   DE, 6011       ; 3:10      push2(6011,6029)
    push HL             ; 1:11      push2(6011,6029)
    ld   HL, 6029       ; 3:10      push2(6011,6029) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6037,6043)
    ld   DE, 6037       ; 3:10      push2(6037,6043)
    push HL             ; 1:11      push2(6037,6043)
    ld   HL, 6043       ; 3:10      push2(6037,6043) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6047,6053)
    ld   DE, 6047       ; 3:10      push2(6047,6053)
    push HL             ; 1:11      push2(6047,6053)
    ld   HL, 6053       ; 3:10      push2(6047,6053) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6067,6073)
    ld   DE, 6067       ; 3:10      push2(6067,6073)
    push HL             ; 1:11      push2(6067,6073)
    ld   HL, 6073       ; 3:10      push2(6067,6073)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6079,6089)
    ld   DE, 6079       ; 3:10      push2(6079,6089)
    push HL             ; 1:11      push2(6079,6089)
    ld   HL, 6089       ; 3:10      push2(6079,6089) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6091,6101)
    ld   DE, 6091       ; 3:10      push2(6091,6101)
    push HL             ; 1:11      push2(6091,6101)
    ld   HL, 6101       ; 3:10      push2(6091,6101) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6113,6121)
    ld   DE, 6113       ; 3:10      push2(6113,6121)
    push HL             ; 1:11      push2(6113,6121)
    ld   HL, 6121       ; 3:10      push2(6113,6121) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6131,6133)
    ld   DE, 6131       ; 3:10      push2(6131,6133)
    push HL             ; 1:11      push2(6131,6133)
    ld   HL, 6133       ; 3:10      push2(6131,6133) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6143,6151)
    ld   DE, 6143       ; 3:10      push2(6143,6151)
    push HL             ; 1:11      push2(6143,6151)
    ld   HL, 6151       ; 3:10      push2(6143,6151)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6163,6173)
    ld   DE, 6163       ; 3:10      push2(6163,6173)
    push HL             ; 1:11      push2(6163,6173)
    ld   HL, 6173       ; 3:10      push2(6163,6173) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6197,6199)
    ld   DE, 6197       ; 3:10      push2(6197,6199)
    push HL             ; 1:11      push2(6197,6199)
    ld   HL, 6199       ; 3:10      push2(6197,6199) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6203,6211)
    ld   DE, 6203       ; 3:10      push2(6203,6211)
    push HL             ; 1:11      push2(6203,6211)
    ld   HL, 6211       ; 3:10      push2(6203,6211) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6217,6221)
    ld   DE, 6217       ; 3:10      push2(6217,6221)
    push HL             ; 1:11      push2(6217,6221)
    ld   HL, 6221       ; 3:10      push2(6217,6221) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6229,6247)
    ld   DE, 6229       ; 3:10      push2(6229,6247)
    push HL             ; 1:11      push2(6229,6247)
    ld   HL, 6247       ; 3:10      push2(6229,6247)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6257,6263)
    ld   DE, 6257       ; 3:10      push2(6257,6263)
    push HL             ; 1:11      push2(6257,6263)
    ld   HL, 6263       ; 3:10      push2(6257,6263) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6269,6271)
    ld   DE, 6269       ; 3:10      push2(6269,6271)
    push HL             ; 1:11      push2(6269,6271)
    ld   HL, 6271       ; 3:10      push2(6269,6271) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6277,6287)
    ld   DE, 6277       ; 3:10      push2(6277,6287)
    push HL             ; 1:11      push2(6277,6287)
    ld   HL, 6287       ; 3:10      push2(6277,6287) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6299,6301)
    ld   DE, 6299       ; 3:10      push2(6299,6301)
    push HL             ; 1:11      push2(6299,6301)
    ld   HL, 6301       ; 3:10      push2(6299,6301) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6311,6317)
    ld   DE, 6311       ; 3:10      push2(6311,6317)
    push HL             ; 1:11      push2(6311,6317)
    ld   HL, 6317       ; 3:10      push2(6311,6317)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6323,6329)
    ld   DE, 6323       ; 3:10      push2(6323,6329)
    push HL             ; 1:11      push2(6323,6329)
    ld   HL, 6329       ; 3:10      push2(6323,6329) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6337,6343)
    ld   DE, 6337       ; 3:10      push2(6337,6343)
    push HL             ; 1:11      push2(6337,6343)
    ld   HL, 6343       ; 3:10      push2(6337,6343) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6353,6359)
    ld   DE, 6353       ; 3:10      push2(6353,6359)
    push HL             ; 1:11      push2(6353,6359)
    ld   HL, 6359       ; 3:10      push2(6353,6359) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6361,6367)
    ld   DE, 6361       ; 3:10      push2(6361,6367)
    push HL             ; 1:11      push2(6361,6367)
    ld   HL, 6367       ; 3:10      push2(6361,6367) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6373,6379)
    ld   DE, 6373       ; 3:10      push2(6373,6379)
    push HL             ; 1:11      push2(6373,6379)
    ld   HL, 6379       ; 3:10      push2(6373,6379)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6389,6397)
    ld   DE, 6389       ; 3:10      push2(6389,6397)
    push HL             ; 1:11      push2(6389,6397)
    ld   HL, 6397       ; 3:10      push2(6389,6397) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6421,6427)
    ld   DE, 6421       ; 3:10      push2(6421,6427)
    push HL             ; 1:11      push2(6421,6427)
    ld   HL, 6427       ; 3:10      push2(6421,6427) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6449,6451)
    ld   DE, 6449       ; 3:10      push2(6449,6451)
    push HL             ; 1:11      push2(6449,6451)
    ld   HL, 6451       ; 3:10      push2(6449,6451) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6469,6473)
    ld   DE, 6469       ; 3:10      push2(6469,6473)
    push HL             ; 1:11      push2(6469,6473)
    ld   HL, 6473       ; 3:10      push2(6469,6473) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6481,6491)
    ld   DE, 6481       ; 3:10      push2(6481,6491)
    push HL             ; 1:11      push2(6481,6491)
    ld   HL, 6491       ; 3:10      push2(6481,6491)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6521,6529)
    ld   DE, 6521       ; 3:10      push2(6521,6529)
    push HL             ; 1:11      push2(6521,6529)
    ld   HL, 6529       ; 3:10      push2(6521,6529) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6547,6551)
    ld   DE, 6547       ; 3:10      push2(6547,6551)
    push HL             ; 1:11      push2(6547,6551)
    ld   HL, 6551       ; 3:10      push2(6547,6551) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6553,6563)
    ld   DE, 6553       ; 3:10      push2(6553,6563)
    push HL             ; 1:11      push2(6553,6563)
    ld   HL, 6563       ; 3:10      push2(6553,6563) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6569,6571)
    ld   DE, 6569       ; 3:10      push2(6569,6571)
    push HL             ; 1:11      push2(6569,6571)
    ld   HL, 6571       ; 3:10      push2(6569,6571) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6577,6581)
    ld   DE, 6577       ; 3:10      push2(6577,6581)
    push HL             ; 1:11      push2(6577,6581)
    ld   HL, 6581       ; 3:10      push2(6577,6581)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6599,6607)
    ld   DE, 6599       ; 3:10      push2(6599,6607)
    push HL             ; 1:11      push2(6599,6607)
    ld   HL, 6607       ; 3:10      push2(6599,6607) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6619,6637)
    ld   DE, 6619       ; 3:10      push2(6619,6637)
    push HL             ; 1:11      push2(6619,6637)
    ld   HL, 6637       ; 3:10      push2(6619,6637) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6653,6659)
    ld   DE, 6653       ; 3:10      push2(6653,6659)
    push HL             ; 1:11      push2(6653,6659)
    ld   HL, 6659       ; 3:10      push2(6653,6659) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6661,6673)
    ld   DE, 6661       ; 3:10      push2(6661,6673)
    push HL             ; 1:11      push2(6661,6673)
    ld   HL, 6673       ; 3:10      push2(6661,6673) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6679,6689)
    ld   DE, 6679       ; 3:10      push2(6679,6689)
    push HL             ; 1:11      push2(6679,6689)
    ld   HL, 6689       ; 3:10      push2(6679,6689)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6691,6701)
    ld   DE, 6691       ; 3:10      push2(6691,6701)
    push HL             ; 1:11      push2(6691,6701)
    ld   HL, 6701       ; 3:10      push2(6691,6701) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6703,6709)
    ld   DE, 6703       ; 3:10      push2(6703,6709)
    push HL             ; 1:11      push2(6703,6709)
    ld   HL, 6709       ; 3:10      push2(6703,6709) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6719,6733)
    ld   DE, 6719       ; 3:10      push2(6719,6733)
    push HL             ; 1:11      push2(6719,6733)
    ld   HL, 6733       ; 3:10      push2(6719,6733) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6737,6761)
    ld   DE, 6737       ; 3:10      push2(6737,6761)
    push HL             ; 1:11      push2(6737,6761)
    ld   HL, 6761       ; 3:10      push2(6737,6761) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6763,6779)
    ld   DE, 6763       ; 3:10      push2(6763,6779)
    push HL             ; 1:11      push2(6763,6779)
    ld   HL, 6779       ; 3:10      push2(6763,6779)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6781,6791)
    ld   DE, 6781       ; 3:10      push2(6781,6791)
    push HL             ; 1:11      push2(6781,6791)
    ld   HL, 6791       ; 3:10      push2(6781,6791) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6793,6803)
    ld   DE, 6793       ; 3:10      push2(6793,6803)
    push HL             ; 1:11      push2(6793,6803)
    ld   HL, 6803       ; 3:10      push2(6793,6803) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6823,6827)
    ld   DE, 6823       ; 3:10      push2(6823,6827)
    push HL             ; 1:11      push2(6823,6827)
    ld   HL, 6827       ; 3:10      push2(6823,6827) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6829,6833)
    ld   DE, 6829       ; 3:10      push2(6829,6833)
    push HL             ; 1:11      push2(6829,6833)
    ld   HL, 6833       ; 3:10      push2(6829,6833) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6841,6857)
    ld   DE, 6841       ; 3:10      push2(6841,6857)
    push HL             ; 1:11      push2(6841,6857)
    ld   HL, 6857       ; 3:10      push2(6841,6857)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6863,6869)
    ld   DE, 6863       ; 3:10      push2(6863,6869)
    push HL             ; 1:11      push2(6863,6869)
    ld   HL, 6869       ; 3:10      push2(6863,6869) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6871,6883)
    ld   DE, 6871       ; 3:10      push2(6871,6883)
    push HL             ; 1:11      push2(6871,6883)
    ld   HL, 6883       ; 3:10      push2(6871,6883) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6899,6907)
    ld   DE, 6899       ; 3:10      push2(6899,6907)
    push HL             ; 1:11      push2(6899,6907)
    ld   HL, 6907       ; 3:10      push2(6899,6907) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6911,6917)
    ld   DE, 6911       ; 3:10      push2(6911,6917)
    push HL             ; 1:11      push2(6911,6917)
    ld   HL, 6917       ; 3:10      push2(6911,6917) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(6947,6949)
    ld   DE, 6947       ; 3:10      push2(6947,6949)
    push HL             ; 1:11      push2(6947,6949)
    ld   HL, 6949       ; 3:10      push2(6947,6949)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6959,6961)
    ld   DE, 6959       ; 3:10      push2(6959,6961)
    push HL             ; 1:11      push2(6959,6961)
    ld   HL, 6961       ; 3:10      push2(6959,6961) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6967,6971)
    ld   DE, 6967       ; 3:10      push2(6967,6971)
    push HL             ; 1:11      push2(6967,6971)
    ld   HL, 6971       ; 3:10      push2(6967,6971) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6977,6983)
    ld   DE, 6977       ; 3:10      push2(6977,6983)
    push HL             ; 1:11      push2(6977,6983)
    ld   HL, 6983       ; 3:10      push2(6977,6983) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(6991,6997)
    ld   DE, 6991       ; 3:10      push2(6991,6997)
    push HL             ; 1:11      push2(6991,6997)
    ld   HL, 6997       ; 3:10      push2(6991,6997) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7001,7013)
    ld   DE, 7001       ; 3:10      push2(7001,7013)
    push HL             ; 1:11      push2(7001,7013)
    ld   HL, 7013       ; 3:10      push2(7001,7013)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7019,7027)
    ld   DE, 7019       ; 3:10      push2(7019,7027)
    push HL             ; 1:11      push2(7019,7027)
    ld   HL, 7027       ; 3:10      push2(7019,7027) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7039,7043)
    ld   DE, 7039       ; 3:10      push2(7039,7043)
    push HL             ; 1:11      push2(7039,7043)
    ld   HL, 7043       ; 3:10      push2(7039,7043) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7057,7069)
    ld   DE, 7057       ; 3:10      push2(7057,7069)
    push HL             ; 1:11      push2(7057,7069)
    ld   HL, 7069       ; 3:10      push2(7057,7069) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7079,7103)
    ld   DE, 7079       ; 3:10      push2(7079,7103)
    push HL             ; 1:11      push2(7079,7103)
    ld   HL, 7103       ; 3:10      push2(7079,7103) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7109,7121)
    ld   DE, 7109       ; 3:10      push2(7109,7121)
    push HL             ; 1:11      push2(7109,7121)
    ld   HL, 7121       ; 3:10      push2(7109,7121)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7127,7129)
    ld   DE, 7127       ; 3:10      push2(7127,7129)
    push HL             ; 1:11      push2(7127,7129)
    ld   HL, 7129       ; 3:10      push2(7127,7129) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7151,7159)
    ld   DE, 7151       ; 3:10      push2(7151,7159)
    push HL             ; 1:11      push2(7151,7159)
    ld   HL, 7159       ; 3:10      push2(7151,7159) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7177,7187)
    ld   DE, 7177       ; 3:10      push2(7177,7187)
    push HL             ; 1:11      push2(7177,7187)
    ld   HL, 7187       ; 3:10      push2(7177,7187) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7193,7207)
    ld   DE, 7193       ; 3:10      push2(7193,7207)
    push HL             ; 1:11      push2(7193,7207)
    ld   HL, 7207       ; 3:10      push2(7193,7207) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7211,7213)
    ld   DE, 7211       ; 3:10      push2(7211,7213)
    push HL             ; 1:11      push2(7211,7213)
    ld   HL, 7213       ; 3:10      push2(7211,7213)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7219,7229)
    ld   DE, 7219       ; 3:10      push2(7219,7229)
    push HL             ; 1:11      push2(7219,7229)
    ld   HL, 7229       ; 3:10      push2(7219,7229) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7237,7243)
    ld   DE, 7237       ; 3:10      push2(7237,7243)
    push HL             ; 1:11      push2(7237,7243)
    ld   HL, 7243       ; 3:10      push2(7237,7243) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7247,7253)
    ld   DE, 7247       ; 3:10      push2(7247,7253)
    push HL             ; 1:11      push2(7247,7253)
    ld   HL, 7253       ; 3:10      push2(7247,7253) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7283,7297)
    ld   DE, 7283       ; 3:10      push2(7283,7297)
    push HL             ; 1:11      push2(7283,7297)
    ld   HL, 7297       ; 3:10      push2(7283,7297) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7307,7309)
    ld   DE, 7307       ; 3:10      push2(7307,7309)
    push HL             ; 1:11      push2(7307,7309)
    ld   HL, 7309       ; 3:10      push2(7307,7309)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7321,7331)
    ld   DE, 7321       ; 3:10      push2(7321,7331)
    push HL             ; 1:11      push2(7321,7331)
    ld   HL, 7331       ; 3:10      push2(7321,7331) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7333,7349)
    ld   DE, 7333       ; 3:10      push2(7333,7349)
    push HL             ; 1:11      push2(7333,7349)
    ld   HL, 7349       ; 3:10      push2(7333,7349) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7351,7369)
    ld   DE, 7351       ; 3:10      push2(7351,7369)
    push HL             ; 1:11      push2(7351,7369)
    ld   HL, 7369       ; 3:10      push2(7351,7369) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7393,7411)
    ld   DE, 7393       ; 3:10      push2(7393,7411)
    push HL             ; 1:11      push2(7393,7411)
    ld   HL, 7411       ; 3:10      push2(7393,7411) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7417,7433)
    ld   DE, 7417       ; 3:10      push2(7417,7433)
    push HL             ; 1:11      push2(7417,7433)
    ld   HL, 7433       ; 3:10      push2(7417,7433)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7451,7457)
    ld   DE, 7451       ; 3:10      push2(7451,7457)
    push HL             ; 1:11      push2(7451,7457)
    ld   HL, 7457       ; 3:10      push2(7451,7457) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7459,7477)
    ld   DE, 7459       ; 3:10      push2(7459,7477)
    push HL             ; 1:11      push2(7459,7477)
    ld   HL, 7477       ; 3:10      push2(7459,7477) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7481,7487)
    ld   DE, 7481       ; 3:10      push2(7481,7487)
    push HL             ; 1:11      push2(7481,7487)
    ld   HL, 7487       ; 3:10      push2(7481,7487) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7489,7499)
    ld   DE, 7489       ; 3:10      push2(7489,7499)
    push HL             ; 1:11      push2(7489,7499)
    ld   HL, 7499       ; 3:10      push2(7489,7499) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7507,7517)
    ld   DE, 7507       ; 3:10      push2(7507,7517)
    push HL             ; 1:11      push2(7507,7517)
    ld   HL, 7517       ; 3:10      push2(7507,7517)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7523,7529)
    ld   DE, 7523       ; 3:10      push2(7523,7529)
    push HL             ; 1:11      push2(7523,7529)
    ld   HL, 7529       ; 3:10      push2(7523,7529) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7537,7541)
    ld   DE, 7537       ; 3:10      push2(7537,7541)
    push HL             ; 1:11      push2(7537,7541)
    ld   HL, 7541       ; 3:10      push2(7537,7541) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7547,7549)
    ld   DE, 7547       ; 3:10      push2(7547,7549)
    push HL             ; 1:11      push2(7547,7549)
    ld   HL, 7549       ; 3:10      push2(7547,7549) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7559,7561)
    ld   DE, 7559       ; 3:10      push2(7559,7561)
    push HL             ; 1:11      push2(7559,7561)
    ld   HL, 7561       ; 3:10      push2(7559,7561) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7573,7577)
    ld   DE, 7573       ; 3:10      push2(7573,7577)
    push HL             ; 1:11      push2(7573,7577)
    ld   HL, 7577       ; 3:10      push2(7573,7577)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7583,7589)
    ld   DE, 7583       ; 3:10      push2(7583,7589)
    push HL             ; 1:11      push2(7583,7589)
    ld   HL, 7589       ; 3:10      push2(7583,7589) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7591,7603)
    ld   DE, 7591       ; 3:10      push2(7591,7603)
    push HL             ; 1:11      push2(7591,7603)
    ld   HL, 7603       ; 3:10      push2(7591,7603) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7607,7621)
    ld   DE, 7607       ; 3:10      push2(7607,7621)
    push HL             ; 1:11      push2(7607,7621)
    ld   HL, 7621       ; 3:10      push2(7607,7621) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7639,7643)
    ld   DE, 7639       ; 3:10      push2(7639,7643)
    push HL             ; 1:11      push2(7639,7643)
    ld   HL, 7643       ; 3:10      push2(7639,7643) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7649,7669)
    ld   DE, 7649       ; 3:10      push2(7649,7669)
    push HL             ; 1:11      push2(7649,7669)
    ld   HL, 7669       ; 3:10      push2(7649,7669)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7673,7681)
    ld   DE, 7673       ; 3:10      push2(7673,7681)
    push HL             ; 1:11      push2(7673,7681)
    ld   HL, 7681       ; 3:10      push2(7673,7681) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7687,7691)
    ld   DE, 7687       ; 3:10      push2(7687,7691)
    push HL             ; 1:11      push2(7687,7691)
    ld   HL, 7691       ; 3:10      push2(7687,7691) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7699,7703)
    ld   DE, 7699       ; 3:10      push2(7699,7703)
    push HL             ; 1:11      push2(7699,7703)
    ld   HL, 7703       ; 3:10      push2(7699,7703) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7717,7723)
    ld   DE, 7717       ; 3:10      push2(7717,7723)
    push HL             ; 1:11      push2(7717,7723)
    ld   HL, 7723       ; 3:10      push2(7717,7723) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7727,7741)
    ld   DE, 7727       ; 3:10      push2(7727,7741)
    push HL             ; 1:11      push2(7727,7741)
    ld   HL, 7741       ; 3:10      push2(7727,7741)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7753,7757)
    ld   DE, 7753       ; 3:10      push2(7753,7757)
    push HL             ; 1:11      push2(7753,7757)
    ld   HL, 7757       ; 3:10      push2(7753,7757) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7759,7789)
    ld   DE, 7759       ; 3:10      push2(7759,7789)
    push HL             ; 1:11      push2(7759,7789)
    ld   HL, 7789       ; 3:10      push2(7759,7789) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7793,7817)
    ld   DE, 7793       ; 3:10      push2(7793,7817)
    push HL             ; 1:11      push2(7793,7817)
    ld   HL, 7817       ; 3:10      push2(7793,7817) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7823,7829)
    ld   DE, 7823       ; 3:10      push2(7823,7829)
    push HL             ; 1:11      push2(7823,7829)
    ld   HL, 7829       ; 3:10      push2(7823,7829) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7841,7853)
    ld   DE, 7841       ; 3:10      push2(7841,7853)
    push HL             ; 1:11      push2(7841,7853)
    ld   HL, 7853       ; 3:10      push2(7841,7853)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7867,7873)
    ld   DE, 7867       ; 3:10      push2(7867,7873)
    push HL             ; 1:11      push2(7867,7873)
    ld   HL, 7873       ; 3:10      push2(7867,7873) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7877,7879)
    ld   DE, 7877       ; 3:10      push2(7877,7879)
    push HL             ; 1:11      push2(7877,7879)
    ld   HL, 7879       ; 3:10      push2(7877,7879) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7883,7901)
    ld   DE, 7883       ; 3:10      push2(7883,7901)
    push HL             ; 1:11      push2(7883,7901)
    ld   HL, 7901       ; 3:10      push2(7883,7901) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7907,7919)
    ld   DE, 7907       ; 3:10      push2(7907,7919)
    push HL             ; 1:11      push2(7907,7919)
    ld   HL, 7919       ; 3:10      push2(7907,7919) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(7927,7933)
    ld   DE, 7927       ; 3:10      push2(7927,7933)
    push HL             ; 1:11      push2(7927,7933)
    ld   HL, 7933       ; 3:10      push2(7927,7933)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7937,7949)
    ld   DE, 7937       ; 3:10      push2(7937,7949)
    push HL             ; 1:11      push2(7937,7949)
    ld   HL, 7949       ; 3:10      push2(7937,7949) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7951,7963)
    ld   DE, 7951       ; 3:10      push2(7951,7963)
    push HL             ; 1:11      push2(7951,7963)
    ld   HL, 7963       ; 3:10      push2(7951,7963) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(7993,8009)
    ld   DE, 7993       ; 3:10      push2(7993,8009)
    push HL             ; 1:11      push2(7993,8009)
    ld   HL, 8009       ; 3:10      push2(7993,8009) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8011,8017)
    ld   DE, 8011       ; 3:10      push2(8011,8017)
    push HL             ; 1:11      push2(8011,8017)
    ld   HL, 8017       ; 3:10      push2(8011,8017) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8039,8053)
    ld   DE, 8039       ; 3:10      push2(8039,8053)
    push HL             ; 1:11      push2(8039,8053)
    ld   HL, 8053       ; 3:10      push2(8039,8053)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8059,8069)
    ld   DE, 8059       ; 3:10      push2(8059,8069)
    push HL             ; 1:11      push2(8059,8069)
    ld   HL, 8069       ; 3:10      push2(8059,8069) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8081,8087)
    ld   DE, 8081       ; 3:10      push2(8081,8087)
    push HL             ; 1:11      push2(8081,8087)
    ld   HL, 8087       ; 3:10      push2(8081,8087) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8089,8093)
    ld   DE, 8089       ; 3:10      push2(8089,8093)
    push HL             ; 1:11      push2(8089,8093)
    ld   HL, 8093       ; 3:10      push2(8089,8093) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8101,8111)
    ld   DE, 8101       ; 3:10      push2(8101,8111)
    push HL             ; 1:11      push2(8101,8111)
    ld   HL, 8111       ; 3:10      push2(8101,8111) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8117,8123)
    ld   DE, 8117       ; 3:10      push2(8117,8123)
    push HL             ; 1:11      push2(8117,8123)
    ld   HL, 8123       ; 3:10      push2(8117,8123)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8147,8161)
    ld   DE, 8147       ; 3:10      push2(8147,8161)
    push HL             ; 1:11      push2(8147,8161)
    ld   HL, 8161       ; 3:10      push2(8147,8161) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8167,8171)
    ld   DE, 8167       ; 3:10      push2(8167,8171)
    push HL             ; 1:11      push2(8167,8171)
    ld   HL, 8171       ; 3:10      push2(8167,8171) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8179,8191)
    ld   DE, 8179       ; 3:10      push2(8179,8191)
    push HL             ; 1:11      push2(8179,8191)
    ld   HL, 8191       ; 3:10      push2(8179,8191) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8209,8219)
    ld   DE, 8209       ; 3:10      push2(8209,8219)
    push HL             ; 1:11      push2(8209,8219)
    ld   HL, 8219       ; 3:10      push2(8209,8219) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8221,8231)
    ld   DE, 8221       ; 3:10      push2(8221,8231)
    push HL             ; 1:11      push2(8221,8231)
    ld   HL, 8231       ; 3:10      push2(8221,8231)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8233,8237)
    ld   DE, 8233       ; 3:10      push2(8233,8237)
    push HL             ; 1:11      push2(8233,8237)
    ld   HL, 8237       ; 3:10      push2(8233,8237) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8243,8263)
    ld   DE, 8243       ; 3:10      push2(8243,8263)
    push HL             ; 1:11      push2(8243,8263)
    ld   HL, 8263       ; 3:10      push2(8243,8263) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8269,8273)
    ld   DE, 8269       ; 3:10      push2(8269,8273)
    push HL             ; 1:11      push2(8269,8273)
    ld   HL, 8273       ; 3:10      push2(8269,8273) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8287,8291)
    ld   DE, 8287       ; 3:10      push2(8287,8291)
    push HL             ; 1:11      push2(8287,8291)
    ld   HL, 8291       ; 3:10      push2(8287,8291) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8293,8297)
    ld   DE, 8293       ; 3:10      push2(8293,8297)
    push HL             ; 1:11      push2(8293,8297)
    ld   HL, 8297       ; 3:10      push2(8293,8297)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8311,8317)
    ld   DE, 8311       ; 3:10      push2(8311,8317)
    push HL             ; 1:11      push2(8311,8317)
    ld   HL, 8317       ; 3:10      push2(8311,8317) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8329,8353)
    ld   DE, 8329       ; 3:10      push2(8329,8353)
    push HL             ; 1:11      push2(8329,8353)
    ld   HL, 8353       ; 3:10      push2(8329,8353) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8363,8369)
    ld   DE, 8363       ; 3:10      push2(8363,8369)
    push HL             ; 1:11      push2(8363,8369)
    ld   HL, 8369       ; 3:10      push2(8363,8369) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8377,8387)
    ld   DE, 8377       ; 3:10      push2(8377,8387)
    push HL             ; 1:11      push2(8377,8387)
    ld   HL, 8387       ; 3:10      push2(8377,8387) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8389,8419)
    ld   DE, 8389       ; 3:10      push2(8389,8419)
    push HL             ; 1:11      push2(8389,8419)
    ld   HL, 8419       ; 3:10      push2(8389,8419)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8423,8429)
    ld   DE, 8423       ; 3:10      push2(8423,8429)
    push HL             ; 1:11      push2(8423,8429)
    ld   HL, 8429       ; 3:10      push2(8423,8429) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8431,8443)
    ld   DE, 8431       ; 3:10      push2(8431,8443)
    push HL             ; 1:11      push2(8431,8443)
    ld   HL, 8443       ; 3:10      push2(8431,8443) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8447,8461)
    ld   DE, 8447       ; 3:10      push2(8447,8461)
    push HL             ; 1:11      push2(8447,8461)
    ld   HL, 8461       ; 3:10      push2(8447,8461) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8467,8501)
    ld   DE, 8467       ; 3:10      push2(8467,8501)
    push HL             ; 1:11      push2(8467,8501)
    ld   HL, 8501       ; 3:10      push2(8467,8501) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8513,8521)
    ld   DE, 8513       ; 3:10      push2(8513,8521)
    push HL             ; 1:11      push2(8513,8521)
    ld   HL, 8521       ; 3:10      push2(8513,8521)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8527,8537)
    ld   DE, 8527       ; 3:10      push2(8527,8537)
    push HL             ; 1:11      push2(8527,8537)
    ld   HL, 8537       ; 3:10      push2(8527,8537) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8539,8543)
    ld   DE, 8539       ; 3:10      push2(8539,8543)
    push HL             ; 1:11      push2(8539,8543)
    ld   HL, 8543       ; 3:10      push2(8539,8543) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8563,8573)
    ld   DE, 8563       ; 3:10      push2(8563,8573)
    push HL             ; 1:11      push2(8563,8573)
    ld   HL, 8573       ; 3:10      push2(8563,8573) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8581,8597)
    ld   DE, 8581       ; 3:10      push2(8581,8597)
    push HL             ; 1:11      push2(8581,8597)
    ld   HL, 8597       ; 3:10      push2(8581,8597) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8599,8609)
    ld   DE, 8599       ; 3:10      push2(8599,8609)
    push HL             ; 1:11      push2(8599,8609)
    ld   HL, 8609       ; 3:10      push2(8599,8609)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8623,8627)
    ld   DE, 8623       ; 3:10      push2(8623,8627)
    push HL             ; 1:11      push2(8623,8627)
    ld   HL, 8627       ; 3:10      push2(8623,8627) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8629,8641)
    ld   DE, 8629       ; 3:10      push2(8629,8641)
    push HL             ; 1:11      push2(8629,8641)
    ld   HL, 8641       ; 3:10      push2(8629,8641) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8647,8663)
    ld   DE, 8647       ; 3:10      push2(8647,8663)
    push HL             ; 1:11      push2(8647,8663)
    ld   HL, 8663       ; 3:10      push2(8647,8663) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8669,8677)
    ld   DE, 8669       ; 3:10      push2(8669,8677)
    push HL             ; 1:11      push2(8669,8677)
    ld   HL, 8677       ; 3:10      push2(8669,8677) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8681,8689)
    ld   DE, 8681       ; 3:10      push2(8681,8689)
    push HL             ; 1:11      push2(8681,8689)
    ld   HL, 8689       ; 3:10      push2(8681,8689)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8693,8699)
    ld   DE, 8693       ; 3:10      push2(8693,8699)
    push HL             ; 1:11      push2(8693,8699)
    ld   HL, 8699       ; 3:10      push2(8693,8699) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8707,8713)
    ld   DE, 8707       ; 3:10      push2(8707,8713)
    push HL             ; 1:11      push2(8707,8713)
    ld   HL, 8713       ; 3:10      push2(8707,8713) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8719,8731)
    ld   DE, 8719       ; 3:10      push2(8719,8731)
    push HL             ; 1:11      push2(8719,8731)
    ld   HL, 8731       ; 3:10      push2(8719,8731) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8737,8741)
    ld   DE, 8737       ; 3:10      push2(8737,8741)
    push HL             ; 1:11      push2(8737,8741)
    ld   HL, 8741       ; 3:10      push2(8737,8741) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8747,8753)
    ld   DE, 8747       ; 3:10      push2(8747,8753)
    push HL             ; 1:11      push2(8747,8753)
    ld   HL, 8753       ; 3:10      push2(8747,8753)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8761,8779)
    ld   DE, 8761       ; 3:10      push2(8761,8779)
    push HL             ; 1:11      push2(8761,8779)
    ld   HL, 8779       ; 3:10      push2(8761,8779) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8783,8803)
    ld   DE, 8783       ; 3:10      push2(8783,8803)
    push HL             ; 1:11      push2(8783,8803)
    ld   HL, 8803       ; 3:10      push2(8783,8803) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8807,8819)
    ld   DE, 8807       ; 3:10      push2(8807,8819)
    push HL             ; 1:11      push2(8807,8819)
    ld   HL, 8819       ; 3:10      push2(8807,8819) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8821,8831)
    ld   DE, 8821       ; 3:10      push2(8821,8831)
    push HL             ; 1:11      push2(8821,8831)
    ld   HL, 8831       ; 3:10      push2(8821,8831) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8837,8839)
    ld   DE, 8837       ; 3:10      push2(8837,8839)
    push HL             ; 1:11      push2(8837,8839)
    ld   HL, 8839       ; 3:10      push2(8837,8839)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8849,8861)
    ld   DE, 8849       ; 3:10      push2(8849,8861)
    push HL             ; 1:11      push2(8849,8861)
    ld   HL, 8861       ; 3:10      push2(8849,8861) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8863,8867)
    ld   DE, 8863       ; 3:10      push2(8863,8867)
    push HL             ; 1:11      push2(8863,8867)
    ld   HL, 8867       ; 3:10      push2(8863,8867) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8887,8893)
    ld   DE, 8887       ; 3:10      push2(8887,8893)
    push HL             ; 1:11      push2(8887,8893)
    ld   HL, 8893       ; 3:10      push2(8887,8893) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8923,8929)
    ld   DE, 8923       ; 3:10      push2(8923,8929)
    push HL             ; 1:11      push2(8923,8929)
    ld   HL, 8929       ; 3:10      push2(8923,8929) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(8933,8941)
    ld   DE, 8933       ; 3:10      push2(8933,8941)
    push HL             ; 1:11      push2(8933,8941)
    ld   HL, 8941       ; 3:10      push2(8933,8941)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8951,8963)
    ld   DE, 8951       ; 3:10      push2(8951,8963)
    push HL             ; 1:11      push2(8951,8963)
    ld   HL, 8963       ; 3:10      push2(8951,8963) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8969,8971)
    ld   DE, 8969       ; 3:10      push2(8969,8971)
    push HL             ; 1:11      push2(8969,8971)
    ld   HL, 8971       ; 3:10      push2(8969,8971) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(8999,9001)
    ld   DE, 8999       ; 3:10      push2(8999,9001)
    push HL             ; 1:11      push2(8999,9001)
    ld   HL, 9001       ; 3:10      push2(8999,9001) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9007,9011)
    ld   DE, 9007       ; 3:10      push2(9007,9011)
    push HL             ; 1:11      push2(9007,9011)
    ld   HL, 9011       ; 3:10      push2(9007,9011) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9013,9029)
    ld   DE, 9013       ; 3:10      push2(9013,9029)
    push HL             ; 1:11      push2(9013,9029)
    ld   HL, 9029       ; 3:10      push2(9013,9029)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9041,9043)
    ld   DE, 9041       ; 3:10      push2(9041,9043)
    push HL             ; 1:11      push2(9041,9043)
    ld   HL, 9043       ; 3:10      push2(9041,9043) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9049,9059)
    ld   DE, 9049       ; 3:10      push2(9049,9059)
    push HL             ; 1:11      push2(9049,9059)
    ld   HL, 9059       ; 3:10      push2(9049,9059) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9067,9091)
    ld   DE, 9067       ; 3:10      push2(9067,9091)
    push HL             ; 1:11      push2(9067,9091)
    ld   HL, 9091       ; 3:10      push2(9067,9091) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9103,9109)
    ld   DE, 9103       ; 3:10      push2(9103,9109)
    push HL             ; 1:11      push2(9103,9109)
    ld   HL, 9109       ; 3:10      push2(9103,9109) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9127,9133)
    ld   DE, 9127       ; 3:10      push2(9127,9133)
    push HL             ; 1:11      push2(9127,9133)
    ld   HL, 9133       ; 3:10      push2(9127,9133)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9137,9151)
    ld   DE, 9137       ; 3:10      push2(9137,9151)
    push HL             ; 1:11      push2(9137,9151)
    ld   HL, 9151       ; 3:10      push2(9137,9151) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9157,9161)
    ld   DE, 9157       ; 3:10      push2(9157,9161)
    push HL             ; 1:11      push2(9157,9161)
    ld   HL, 9161       ; 3:10      push2(9157,9161) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9173,9181)
    ld   DE, 9173       ; 3:10      push2(9173,9181)
    push HL             ; 1:11      push2(9173,9181)
    ld   HL, 9181       ; 3:10      push2(9173,9181) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9187,9199)
    ld   DE, 9187       ; 3:10      push2(9187,9199)
    push HL             ; 1:11      push2(9187,9199)
    ld   HL, 9199       ; 3:10      push2(9187,9199) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9203,9209)
    ld   DE, 9203       ; 3:10      push2(9203,9209)
    push HL             ; 1:11      push2(9203,9209)
    ld   HL, 9209       ; 3:10      push2(9203,9209)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9221,9227)
    ld   DE, 9221       ; 3:10      push2(9221,9227)
    push HL             ; 1:11      push2(9221,9227)
    ld   HL, 9227       ; 3:10      push2(9221,9227) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9239,9241)
    ld   DE, 9239       ; 3:10      push2(9239,9241)
    push HL             ; 1:11      push2(9239,9241)
    ld   HL, 9241       ; 3:10      push2(9239,9241) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9257,9277)
    ld   DE, 9257       ; 3:10      push2(9257,9277)
    push HL             ; 1:11      push2(9257,9277)
    ld   HL, 9277       ; 3:10      push2(9257,9277) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9281,9283)
    ld   DE, 9281       ; 3:10      push2(9281,9283)
    push HL             ; 1:11      push2(9281,9283)
    ld   HL, 9283       ; 3:10      push2(9281,9283) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9293,9311)
    ld   DE, 9293       ; 3:10      push2(9293,9311)
    push HL             ; 1:11      push2(9293,9311)
    ld   HL, 9311       ; 3:10      push2(9293,9311)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9319,9323)
    ld   DE, 9319       ; 3:10      push2(9319,9323)
    push HL             ; 1:11      push2(9319,9323)
    ld   HL, 9323       ; 3:10      push2(9319,9323) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9337,9341)
    ld   DE, 9337       ; 3:10      push2(9337,9341)
    push HL             ; 1:11      push2(9337,9341)
    ld   HL, 9341       ; 3:10      push2(9337,9341) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9343,9349)
    ld   DE, 9343       ; 3:10      push2(9343,9349)
    push HL             ; 1:11      push2(9343,9349)
    ld   HL, 9349       ; 3:10      push2(9343,9349) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9371,9377)
    ld   DE, 9371       ; 3:10      push2(9371,9377)
    push HL             ; 1:11      push2(9371,9377)
    ld   HL, 9377       ; 3:10      push2(9371,9377) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9391,9397)
    ld   DE, 9391       ; 3:10      push2(9391,9397)
    push HL             ; 1:11      push2(9391,9397)
    ld   HL, 9397       ; 3:10      push2(9391,9397)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9403,9413)
    ld   DE, 9403       ; 3:10      push2(9403,9413)
    push HL             ; 1:11      push2(9403,9413)
    ld   HL, 9413       ; 3:10      push2(9403,9413) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9419,9421)
    ld   DE, 9419       ; 3:10      push2(9419,9421)
    push HL             ; 1:11      push2(9419,9421)
    ld   HL, 9421       ; 3:10      push2(9419,9421) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9431,9433)
    ld   DE, 9431       ; 3:10      push2(9431,9433)
    push HL             ; 1:11      push2(9431,9433)
    ld   HL, 9433       ; 3:10      push2(9431,9433) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9437,9439)
    ld   DE, 9437       ; 3:10      push2(9437,9439)
    push HL             ; 1:11      push2(9437,9439)
    ld   HL, 9439       ; 3:10      push2(9437,9439) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9461,9463)
    ld   DE, 9461       ; 3:10      push2(9461,9463)
    push HL             ; 1:11      push2(9461,9463)
    ld   HL, 9463       ; 3:10      push2(9461,9463)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9467,9473)
    ld   DE, 9467       ; 3:10      push2(9467,9473)
    push HL             ; 1:11      push2(9467,9473)
    ld   HL, 9473       ; 3:10      push2(9467,9473) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9479,9491)
    ld   DE, 9479       ; 3:10      push2(9479,9491)
    push HL             ; 1:11      push2(9479,9491)
    ld   HL, 9491       ; 3:10      push2(9479,9491) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9497,9511)
    ld   DE, 9497       ; 3:10      push2(9497,9511)
    push HL             ; 1:11      push2(9497,9511)
    ld   HL, 9511       ; 3:10      push2(9497,9511) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9521,9533)
    ld   DE, 9521       ; 3:10      push2(9521,9533)
    push HL             ; 1:11      push2(9521,9533)
    ld   HL, 9533       ; 3:10      push2(9521,9533) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9539,9547)
    ld   DE, 9539       ; 3:10      push2(9539,9547)
    push HL             ; 1:11      push2(9539,9547)
    ld   HL, 9547       ; 3:10      push2(9539,9547)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9551,9587)
    ld   DE, 9551       ; 3:10      push2(9551,9587)
    push HL             ; 1:11      push2(9551,9587)
    ld   HL, 9587       ; 3:10      push2(9551,9587) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9601,9613)
    ld   DE, 9601       ; 3:10      push2(9601,9613)
    push HL             ; 1:11      push2(9601,9613)
    ld   HL, 9613       ; 3:10      push2(9601,9613) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9619,9623)
    ld   DE, 9619       ; 3:10      push2(9619,9623)
    push HL             ; 1:11      push2(9619,9623)
    ld   HL, 9623       ; 3:10      push2(9619,9623) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9629,9631)
    ld   DE, 9629       ; 3:10      push2(9629,9631)
    push HL             ; 1:11      push2(9629,9631)
    ld   HL, 9631       ; 3:10      push2(9629,9631) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9643,9649)
    ld   DE, 9643       ; 3:10      push2(9643,9649)
    push HL             ; 1:11      push2(9643,9649)
    ld   HL, 9649       ; 3:10      push2(9643,9649)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9661,9677)
    ld   DE, 9661       ; 3:10      push2(9661,9677)
    push HL             ; 1:11      push2(9661,9677)
    ld   HL, 9677       ; 3:10      push2(9661,9677) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9679,9689)
    ld   DE, 9679       ; 3:10      push2(9679,9689)
    push HL             ; 1:11      push2(9679,9689)
    ld   HL, 9689       ; 3:10      push2(9679,9689) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9697,9719)
    ld   DE, 9697       ; 3:10      push2(9697,9719)
    push HL             ; 1:11      push2(9697,9719)
    ld   HL, 9719       ; 3:10      push2(9697,9719) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9721,9733)
    ld   DE, 9721       ; 3:10      push2(9721,9733)
    push HL             ; 1:11      push2(9721,9733)
    ld   HL, 9733       ; 3:10      push2(9721,9733) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9739,9743)
    ld   DE, 9739       ; 3:10      push2(9739,9743)
    push HL             ; 1:11      push2(9739,9743)
    ld   HL, 9743       ; 3:10      push2(9739,9743)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9749,9767)
    ld   DE, 9749       ; 3:10      push2(9749,9767)
    push HL             ; 1:11      push2(9749,9767)
    ld   HL, 9767       ; 3:10      push2(9749,9767) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9769,9781)
    ld   DE, 9769       ; 3:10      push2(9769,9781)
    push HL             ; 1:11      push2(9769,9781)
    ld   HL, 9781       ; 3:10      push2(9769,9781) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9787,9791)
    ld   DE, 9787       ; 3:10      push2(9787,9791)
    push HL             ; 1:11      push2(9787,9791)
    ld   HL, 9791       ; 3:10      push2(9787,9791) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9803,9811)
    ld   DE, 9803       ; 3:10      push2(9803,9811)
    push HL             ; 1:11      push2(9803,9811)
    ld   HL, 9811       ; 3:10      push2(9803,9811) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9817,9829)
    ld   DE, 9817       ; 3:10      push2(9817,9829)
    push HL             ; 1:11      push2(9817,9829)
    ld   HL, 9829       ; 3:10      push2(9817,9829)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9833,9839)
    ld   DE, 9833       ; 3:10      push2(9833,9839)
    push HL             ; 1:11      push2(9833,9839)
    ld   HL, 9839       ; 3:10      push2(9833,9839) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9851,9857)
    ld   DE, 9851       ; 3:10      push2(9851,9857)
    push HL             ; 1:11      push2(9851,9857)
    ld   HL, 9857       ; 3:10      push2(9851,9857) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9859,9871)
    ld   DE, 9859       ; 3:10      push2(9859,9871)
    push HL             ; 1:11      push2(9859,9871)
    ld   HL, 9871       ; 3:10      push2(9859,9871) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9883,9887)
    ld   DE, 9883       ; 3:10      push2(9883,9887)
    push HL             ; 1:11      push2(9883,9887)
    ld   HL, 9887       ; 3:10      push2(9883,9887) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      *
   
    push DE             ; 1:11      push2(9901,9907)
    ld   DE, 9901       ; 3:10      push2(9901,9907)
    push HL             ; 1:11      push2(9901,9907)
    ld   HL, 9907       ; 3:10      push2(9901,9907)  
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9923,9929)
    ld   DE, 9923       ; 3:10      push2(9923,9929)
    push HL             ; 1:11      push2(9923,9929)
    ld   HL, 9929       ; 3:10      push2(9923,9929) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9931,9941)
    ld   DE, 9931       ; 3:10      push2(9931,9941)
    push HL             ; 1:11      push2(9931,9941)
    ld   HL, 9941       ; 3:10      push2(9931,9941) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push2(9949,9967)
    ld   DE, 9949       ; 3:10      push2(9949,9967)
    push HL             ; 1:11      push2(9949,9967)
    ld   HL, 9967       ; 3:10      push2(9949,9967) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    push DE             ; 1:11      push(9973)
    ex   DE, HL         ; 1:4       push(9973)
    ld   HL, 9973       ; 3:10      push(9973) 
    call MULTIPLY       ; 3:17      *
    pop  DE             ; 1:10      * 
    call PRINT_S16      ; 3:17      .

Stop:                   ;           stop
    ld   SP, 0x0000     ; 3:10      stop   restoring the original SP value when the "bye" word is used
    ld   HL, 0x2758     ; 3:10      stop
    exx                 ; 1:4       stop
    ret                 ; 1:10      stop
;   =====  e n d  =====

; Input: HL
; Output: Print space and signed decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_S16:
    ld    A, H          ; 1:4
    add   A, A          ; 1:4
    jr   nc, PRINT_U16  ; 2:7/12

    xor   A             ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    L, A          ; 1:4       neg
    sbc   A, H          ; 1:4       neg
    sub   L             ; 1:4       neg
    ld    H, A          ; 1:4       neg
    
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ld    A, '-'        ; 2:7       putchar Pollutes: AF, DE', BC'
    db 0x01             ; 3:10      ld   BC, **

    ; fall to print_u16
; Input: HL
; Output: Print space and unsigned decimal number in HL
; Pollutes: AF, AF', BC, DE, HL = DE, DE = (SP)
PRINT_U16:
    ld    A, ' '        ; 2:7       putchar Pollutes: AF, DE', BC'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A

; Input: HL
; Output: Print unsigned decimal number in HL
; Pollutes: AF, BC, DE, HL = DE, DE = (SP)
PRINT_U16_ONLY:
    call BIN2DEC        ; 3:17
    pop  BC             ; 1:10      ret
    ex   DE, HL         ; 1:4
    pop  DE             ; 1:10
    push BC             ; 1:10      ret
    ret                 ; 1:10

; Input: HL = number
; Output: print number
; Pollutes: AF, HL, BC
BIN2DEC:
    xor   A             ; 1:4       A=0 => 103, A='0' => 00103
    ld   BC, -10000     ; 3:10
    call BIN2DEC_CHAR+2 ; 3:17
    ld   BC, -1000      ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld   BC, -100       ; 3:10
    call BIN2DEC_CHAR   ; 3:17
    ld    C, -10        ; 2:7
    call BIN2DEC_CHAR   ; 3:17
    ld    A, L          ; 1:4
    add   A,'0'         ; 2:7
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10

BIN2DEC_CHAR:
    and  0xF0           ; 2:7       '0'..'9' => '0', unchanged 0

    add  HL, BC         ; 1:11
    inc   A             ; 1:4
    jr    c, $-2        ; 2:7/12
    sbc  HL, BC         ; 2:15
    dec   A             ; 1:4
    ret   z             ; 1:5/11

    or   '0'            ; 2:7       0 => '0', unchanged '0'..'9'
    rst   0x10          ; 1:11      putchar with ZX 48K ROM in, this will print char in A
    ret                 ; 1:10
; Input: HL,DE
; Output: HL=HL*DE ((un)signed)
; It does not matter whether it is signed or unsigned multiplication.
; HL = HL*DE = H0*E + L*DE
; Pollutes: AF, C, DE
MULTIPLY:
                        ;[36:471-627] # default version can be changed with "define({TYPMUL},{name})", name=fast,small,test,test2,...   
    xor   A             ; 1:4
    ld    C, E          ; 1:4

    srl   H             ; 2:8       H /= 2
    jr   nc, $+3        ; 2:7/12        
MULTIPLY1:              ;           H0*0E
    add   A, C          ; 1:4       A += C(original E)

    sla   C             ; 2:8       C(original E) *= 2
    srl   H             ; 2:8       H /= 2
    jr    c, MULTIPLY1  ; 2:7/12
    jp   nz, MULTIPLY1+1; 3:10      H = ?

    ld    C, L          ; 1:4
    ld    L, H          ; 1:4       L = 0
    ld    H, A          ; 1:4       HL *= E

    srl   C             ; 2:8       C(original L) /= 2
    jr   nc, $+3        ; 2:7/12    
MULTIPLY2:              ;           0L*DE
    add  HL, DE         ; 1:11
    
    sla   E             ; 2:8
    rl    D             ; 2:8       DE *= 2    

    srl   C             ; 2:8       C(original L) /= 2
    jr    c, MULTIPLY2  ; 2:7/12
    jp   nz, MULTIPLY2+1; 3:10      C(original L) = ?

    ret                 ; 1:10
MULTIPLY_SIZE EQU  $-MULTIPLY