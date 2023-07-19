BEGIN {

  reserved_words["AT-XY"]       = "AT_XY"               # facility ext      
  reserved_words["ERASE"]       = "PUSH(0) FILL"        # for compatibility with the core-ext   
  reserved_words["PAUSE"]       = "PAUSE"               # not standard   
  reserved_words["WAIT"]        = "WAIT"                # not standard   
  reserved_words["MS"]          = "PUSH(20) UDIV WAIT"  # for compatibility with facility ext   

  
  
  reserved_words["ABORT"]       = "BYE ;# Originally ABORT\n"  # After compilation, there is no difference between ABORT and BYE.  
#   reserved_words["ABORT\""]     = It's complicated, it has to be read as a string --> "IF PRINT({"..."}) BYE THEN ;# Originally ABORTq\n"  # After compilation, there is no difference between ABORT and BYE.  
  reserved_words["ALIGN"]       = "ALIGN"           # + integer --> ALIGN(integer)
  reserved_words["IF"]          = "IF"
  reserved_words["ELSE"]        = "ELSE"
  reserved_words["THEN"]        = "THEN"
  reserved_words["DO"]          = "DO"
  reserved_words["UNLOOP"]      = "UNLOOP"
  reserved_words["LOOP"]        = "LOOP"
  reserved_words["BEGIN"]       = "BEGIN"
  reserved_words["UNTIL"]       = "UNTIL"
  reserved_words["AGAIN"]       = "AGAIN"
  reserved_words["WHILE"]       = "WHILE"
  reserved_words["REPEAT"]      = "REPEAT"
  
  reserved_words["CASE"]        = "CASE"
  reserved_words["OF"]          = "OF DROP"         # for compatibility with the standard   
  reserved_words["ENDOF"]       = "ENDOF"
  reserved_words["ENDCASE"]     = "DROP ENDCASE"    # for compatibility with the standard
  
  reserved_words["DUP"]         = "DUP"
  reserved_words["DROP"]        = "DROP"
  reserved_words["SWAP"]        = "SWAP"
  reserved_words["WITHIN"]      = "WITHIN"
  reserved_words["AND"]         = "AND"
  reserved_words["OR"]          = "OR"
  reserved_words["XOR"]         = "XOR"
  reserved_words["NIP"]         = "NIP"
  reserved_words["TUCK"]        = "TUCK"
  reserved_words["OVER"]        = "OVER"
  reserved_words["ROT"]         = "ROT"
  reserved_words["PICK"]        = "PICK"
  reserved_words["DEPTH"]       = "DEPTH"
  reserved_words["RDROP"]       = "RDROP"
  
  reserved_words["MIN"]         = "MIN"
  reserved_words["MAX"]         = "MAX"
  reserved_words["DMIN"]        = "DMIN"
  reserved_words["DMAX"]        = "DMAX"
  
  reserved_words["EXIT"]        = "EXIT"
  reserved_words["FILL"]        = "FILL"
  reserved_words["MOVE"]        = "MOVE"
  reserved_words["CMOVE"]       = "CMOVE"
  reserved_words["BYE"]         = "BYE"
  reserved_words["RND"]         = "RND"
  reserved_words["RANDOM"]      = "RANDOM"
  
  
  reserved_words["ALLOT"]       = "ALLOT"
  reserved_words["HERE"]        = "HERE"
  reserved_words["CREATE"]      = "CREATE"
  reserved_words["I"]           = "I"
  reserved_words["J"]           = "J"
  reserved_words["K"]           = "K"
  reserved_words["ABS"]         = "ABS"
  reserved_words["UMOD"]        = "UMOD"
  reserved_words["MOD"]         = "MOD"
  reserved_words["ACCEPT"]      = "ACCEPT"
  reserved_words["ACCEPT_Z"]    = "ACCEPT_Z"            # not standard

  reserved_words["EMIT"]        = "EMIT"
  reserved_words["TYPE"]        = "TYPE"
  reserved_words["TYPE_Z"]      = "TYPE_Z"              # not standard

  reserved_words["SPACE"]       = "SPACE"
  reserved_words["SPACES"]      = "CALL(__SPACES,( n -- ))"     # for compatibility with the standard
    
  use_reserved_words["SPACES"]  = 0

  reserved_words["CR"]          = "CR"
  reserved_words["FOR"]         = "FOR"
  reserved_words["NEXT"]        = "NEXT"
  reserved_words["TRUE"]        = "TRUE"
  reserved_words["FALSE"]       = "FALSE"
  reserved_words["VARIABLE"]    = "VARIABLE"
  reserved_words["2VARIABLE"]   = "DVARIABLE"
  reserved_words["DVARIABLE"]   = "DVARIABLE"       # not standard

  reserved_words["VALUE"]       = "VALUE"
  reserved_words["2VALUE"]      = "DVALUE"
  reserved_words["DVALUE"]      = "DVALUE"          # not standard
  reserved_words["TO"]          = "TO"
  reserved_words["CONSTANT"]    = "CONSTANT"
  reserved_words["[CHAR]"]      = ""
  reserved_words["CHAR"]        = ""
  reserved_words["BOUNDS"]      = "OVER ADD SWAP"   # not standard
  
  reserved_words["INVERT"]      = "INVERT" 
  reserved_words["LSHIFT"]      = "LSHIFT"
  reserved_words["RSHIFT"]      = "RSHIFT"
  reserved_words["<<"]          = "LSHIFT"          # not standard
  reserved_words[">>"]          = "RSHIFT"          # not standard
  reserved_words["NEGATE"]      = "NEGATE"
  
  reserved_words["DINVERT"]     = "DINVERT"         # not standard
  reserved_words["DLSHIFT"]     = "DLSHIFT"         # not standard
  reserved_words["DRSHIFT"]     = "DRSHIFT"         # not standard
  reserved_words["DNEGATE"]     = "DNEGATE"
  
  reserved_words["CMOVE>"]      = "CMOVEGT"
  reserved_words["MOVE>"]       = "MOVEGT"

  reserved_words[","]           = "COMMA"

  reserved_words["1+"]          = "_1ADD"
  reserved_words["2+"]          = "_2ADD"
  reserved_words["+"]           = "ADD"
  reserved_words["D+"]          = "DADD"
  reserved_words["1-"]          = "_1SUB"
  reserved_words["2-"]          = "_2SUB"
  reserved_words["-"]           = "SUB"
  reserved_words["D-"]          = "DSUB"
  reserved_words["/"]           = "DIV"
  reserved_words["*"]           = "MUL"
  reserved_words["*/"]          = "MULDIV ;# Warning: Truncated division, not Floor division\n"
  reserved_words["*/MOD"]       = "MULDIVMOD ;# Warning: Truncated division, not Floor division\n"

  reserved_words["2/"]          = "_2DIV"
  reserved_words["2*"]          = "_2MUL"

  reserved_words["/MOD"]        = "DIVMOD"
  reserved_words["U*"]          = "MUL"             # not standard
  reserved_words["U/"]          = "UDIV"            # not standard
  reserved_words["UMOD"]        = "UMOD"            # not standard
  reserved_words["U/MOD"]       = "UDIVMOD"         # not standard

  reserved_words["M+"]          = "MADD"
  reserved_words["M*"]          = "MMUL"
  reserved_words["UM*"]         = "UMMUL"
  reserved_words["FM/MOD"]      = "FMDIVMOD"
  reserved_words["SM/REM"]      = "SMDIVREM"
  reserved_words["UM/MOD"]      = "UMDIVMOD"

  reserved_words["256/"]        = "_256DIV"         # not standard
  reserved_words["256*"]        = "_256MUL"         # not standard
  reserved_words[":"]           = "COLON"
  reserved_words["LEAVE"]       = "LEAVE"
  reserved_words["RECURSE"]     = "RECURSE"  
  reserved_words[";"]           = "SEMICOLON"
  reserved_words["U."]          = "UDOT SPACE"      # for compatibility with the standard
  reserved_words["D."]          = "DDOT SPACE"      # for compatibility with the standard
  reserved_words["."]           = "DOT SPACE"       # for compatibility with the standard
  reserved_words[".S"]          = "DOTS"

  reserved_words["="]           = "EQ"
  reserved_words["<>"]          = "NE"
  reserved_words["<"]           = "LT"
  reserved_words[">"]           = "GT"
  reserved_words["<="]          = "LE"              # not standard
  reserved_words[">="]          = "GE"              # not standard
  
  reserved_words["U="]          = "EQ"              # not standard
  reserved_words["U<>"]         = "NE"              # not standard
  reserved_words["U<"]          = "ULT"
  reserved_words["U>"]          = "UGT"
  reserved_words["U<="]         = "LE"              # not standard
  reserved_words["U>="]         = "GE"              # not standard
  
  reserved_words["D="]          = "DEQ"
  reserved_words["D<>"]         = "DNE"             # not standard
  reserved_words["D<"]          = "DLT"
  reserved_words["D>"]          = "DGT"             # not standard
  reserved_words["D<="]         = "DLE"             # not standard
  reserved_words["D>="]         = "DGE"             # not standard

  reserved_words["DU="]         = "DUEQ"            # not standard
  reserved_words["DU<>"]        = "DUNE"            # not standard
  reserved_words["DU<"]         = "DULT"
  reserved_words["DU>"]         = "DUGT"            # not standard
  reserved_words["DU<="]        = "DULE"            # not standard
  reserved_words["DU>="]        = "DUGE"            # not standard
  
  reserved_words["0="]          = "_0EQ"
  reserved_words["0<"]          = "_0LT"
  reserved_words["0>"]          = "_0GT"
  reserved_words["0<="]         = "_0LE"            # not standard
  reserved_words["0>="]         = "_0GE"            # not standard
  reserved_words["0<>"]         = "_0NE"            # core ext

  reserved_words["+!"]          = "ADDSTORE"
  reserved_words["+LOOP"]       = "ADDLOOP"
  
  reserved_words["!"]           = "STORE"
  reserved_words["@"]           = "FETCH"
  reserved_words["2!"]          = "_2STORE"
  reserved_words["2@"]          = "_2FETCH"
  reserved_words["C!"]          = "CSTORE"
  reserved_words["C@"]          = "CFETCH"
  
  reserved_words[">R"]          = "TO_R"
  reserved_words["R>"]          = "R_FROM"
  reserved_words["R@"]          = "R_FETCH"
  reserved_words["2>R"]         = "_2TO_R"
  reserved_words["2R>"]         = "_2R_FROM"
  reserved_words["2R@"]         = "_2R_FETCH"
  reserved_words["2RDROP"]      = "_2RDROP"
  
  reserved_words["2SWAP"]       = "_2SWAP"
  reserved_words["2DROP"]       = "_2DROP"
  reserved_words["2NIP"]        = "_2NIP"
  reserved_words["2TUCK"]       = "_2TUCK"
  reserved_words["2OVER"]       = "_2OVER"
  reserved_words["?DUP"]        = "QUESTIONDUP"
  reserved_words["?DO"]         = "QUESTIONDO"
  reserved_words["2DUP"]        = "_2DUP"
  reserved_words["3DUP"]        = "_3DUP"
  reserved_words["4DUP"]        = "_4DUP"
  reserved_words["-ROT"]        = "NROT"
  reserved_words["-2ROT"]       = "N2ROT"
  reserved_words["2ROT"]        = "_2ROT"

  reserved_words["KEY?"]        = "KEYQUESTION"
  reserved_words["KEY"]         = "KEY"

  reserved_words["D>S"]         = "D_TO_S"
  reserved_words["S>D"]         = "S_TO_D"
  
  reserved_words["EXECUTE"]     = "EXECUTE"
  reserved_words["CELL"]        = "CELL"                # not standard
  reserved_words["CELL+"]       = "CELLADD"
  reserved_words["CELLS"]       = "CELLS"
  
  reserved_words["HEX"]         = "HEX"                 # limited support for combination "hex (u)(d)." not as a permanent output setting parameter
  reserved_words["BL"]          = "PUSH(' ')"           # for compatibility with the standard

  reserved_words["T{"]          = "TEST_START"          # not standard
  reserved_words["->"]          = "TEST_EQ"             # not standard
  reserved_words["}T"]          = "TEST_END"            # not standard

# potential change in the recursive word 
  recurse_reserved_words["DO"]          = "DO(R)"
  recurse_reserved_words["QUESTIONDO"]  = "QUESTIONDO(R)"
  recurse_reserved_words["FOR"]         = "FOR(R)"
  recurse_reserved_words["CALL"]        = "RCALL"
  recurse_reserved_words["COLON"]       = "RCOLON"
  recurse_reserved_words["EXIT"]        = "REXIT"
  recurse_reserved_words["SEMICOLON"]   = "RSEMICOLON"

  if ( arg == "-zfloat" ) {

    reserved_words["FDEPTH"]    = "ZDEPTH"

    reserved_words["D>F"]       = "D_TO_Z"
    reserved_words["F>D"]       = "Z_TO_D"
    reserved_words["S>F"]       = "S_TO_Z"
    reserved_words["F>S"]       = "Z_TO_S"
    reserved_words["U>F"]       = "U_TO_Z"          # not standard

    reserved_words["FABS"]      = "ZABS"
    reserved_words["FACOS"]     = "ZACOS"
    reserved_words["F+"]        = "ZADD"
    reserved_words["FASIN"]     = "ZASIN"
    reserved_words["FATAN"]     = "ZATAN"
    reserved_words["FCOS"]      = "ZCOS"
    reserved_words["F/"]        = "ZDIV"
    reserved_words["F."]        = "ZDOT"
    reserved_words["FDROP"]     = "ZDROP"
    reserved_words["F2DROP"]    = "Z2DROP"          # not standard
    reserved_words["FDUP"]      = "ZDUP"
    reserved_words["F2DUP"]     = "Z2DUP"           # not standard
    reserved_words["FNIP"]      = "ZNIP"            # not standard
    reserved_words["FEXP"]      = "ZEXP"
    reserved_words["F@"]        = "ZFETCH"
    reserved_words["FLOOR"]     = "ZFLOOR"    
    reserved_words["FTRUNC"]    = "CALL(__ZTRUNC,( z -- round_towards_zero(z)))"    # floating ext
    
    use_reserved_words["FTRUNC"] = 0
    
    reserved_words["FLN"]       = "ZLN"
    reserved_words["F*"]        = "ZMUL"
    reserved_words["F**"]       = "ZMULMUL"
    reserved_words["FNEGATE"]   = "ZNEGATE"
    reserved_words["FOVER"]     = "ZOVER"
    reserved_words["FPICK"]     = "ZPICK"           # not standard
    reserved_words["FROT"]      = "ZROT"
    reserved_words["F-ROT"]     = "ZNROT"           # not standard

    reserved_words["FSIN"]      = "ZSIN"
    reserved_words["FSQRT"]     = "ZSQRT"
    reserved_words["F!"]        = "ZSTORE"
    reserved_words["F-"]        = "ZSUB"
    reserved_words["FSWAP"]     = "ZSWAP"
    reserved_words["FTAN"]      = "ZTAN"
    reserved_words["FVARIABLE"] = "ZVARIABLE"
    reserved_words["F<="]       = "ZLE"
    reserved_words["F>="]       = "ZGE"
    reserved_words["F<>"]       = "ZNE"
    reserved_words["F>"]        = "ZGT"
    reserved_words["F<"]        = "ZLT"
    reserved_words["F="]        = "ZEQ"
    reserved_words["F0<"]       = "Z0LT"
    reserved_words["F0="]       = "Z0EQ"
    reserved_words["FLOAT+"]    = "ZFLOATADD"
    reserved_words["ZDEPTH"]    = "ZDEPTH"          # not standard
    
#     reserved_words["FFRAC"]     = "FFRAC"           # not standard
        
    reserved_words["FMOD"]      = "CALL(__ZMOD,( za zb  -- zmod(a%b)))"    # not standard
    
    use_reserved_words["FMOD"] = 0

    reserved_words["F2*"]       = "ZPUSH(2E) ZMUL" # not standard
    reserved_words["F2/"]       = "ZPUSH(2E) ZDIV" # not standard
    
    reserved_words["F0<"]       = "Z0LT"            # not standard
    reserved_words["F0="]       = "Z0EQ"            # not standard

    
    
  } else {
      
    reserved_words["FDEPTH"]    = "DEPTH"
      
    reserved_words["D>F"]       = "D_TO_S S2F"      # for compatibility with the standard
    reserved_words["F>D"]       = "F2S S_TO_D"      # for compatibility with the standard
    reserved_words["S>F"]       = "S2F"
    reserved_words["F>S"]       = "F2S"
    reserved_words["U>F"]       = "U2F"             # not standard
    reserved_words["F>U"]       = "F2U"             # not standard
    
    reserved_words["FABS"]      = "FABS"
    reserved_words["FACOS"]     = "CALL(__FACOS,( rad -- ))"    # for compatibility with the standard
    
    use_reserved_words["FACOS"] = 0

    reserved_words["F+"]        = "FADD"    
    reserved_words["FASIN"]     = "CALL(__FASIN,( rad -- ))"    # for compatibility with the standard
    
    use_reserved_words["FASIN"] = 0

#     reserved_words["FATAN"]     = ""    # for compatibility with the standard
    reserved_words["FCOS"]      = "PUSH(0x4092) SWAP FSUB FSIN ;# ( cos  0..π only)\n"   # for compatibility with the standard
    reserved_words["F/"]        = "FDIV"
    reserved_words["F."]        = "FDOT SPACE"
    reserved_words["FDROP"]     = "FDROP"
    reserved_words["F2DROP"]    = "F2DROP"          # not standard
    reserved_words["FDUP"]      = "FDUP"
    reserved_words["F2DUP"]     = "F2DUP"           # not standard
    reserved_words["FNIP"]      = "FNIP"            # not standard
    reserved_words["FEXP"]      = "FEXP"
    reserved_words["F@"]        = "FFETCH"
    
#     reserved_words["FLOOR"]     = "CALL(__FLOOR,( f -- round_towards_negative_infinity(f)))"    
#     use_reserved_words["FLOOR"] = 0
    
    reserved_words["FLOOR"]     = "FLOOR"
    reserved_words["FTRUNC"]    = "FTRUNC"   
    reserved_words["FLN"]       = "FLN"
    reserved_words["F*"]        = "FMUL"
#     reserved_words["F**"]       = ""
    reserved_words["FNEGATE"]   = "FNEGATE"
    reserved_words["FOVER"]     = "FOVER"
    reserved_words["FPICK"]     = "FPICK"           # not standard
    reserved_words["FROT"]      = "FROT"
    reserved_words["F-ROT"]     = "FNROT"           # not standard
    reserved_words["FSIN"]      = "FSIN ;# ( sin -π/2..π/2 only)\n"
    reserved_words["FSQRT"]     = "FSQRT"
    reserved_words["F!"]        = "FSTORE"
    reserved_words["F-"]        = "FSUB"

    reserved_words["FSWAP"]     = "FSWAP"
    reserved_words["FTAN"]      = "DUP FSIN SWAP PUSH(0x4092) SWAP FSUB FSIN FDIV ;# ( tan  0..π/2 only)\n"   # for compatibility with the standard
    reserved_words["FVARIABLE"] = "FVARIABLE"
    reserved_words["F<="]       = "FLE"
    reserved_words["F>="]       = "FGE"   
    reserved_words["F<>"]       = "FNE"
    reserved_words["F>"]        = "FGT"
    reserved_words["F<"]        = "FLT"
    reserved_words["F="]        = "FEQ"    
    reserved_words["F0<"]       = "F0LT"
    reserved_words["F0="]       = "F0EQ"
    reserved_words["FLOAT+"]    = "FLOATADD"

    reserved_words["FFRAC"]     = "FFRAC"           # not standard
    reserved_words["FMOD"]      = "FMOD"            # not standard
    reserved_words["F2*"]       = "F2MUL"           # not standard
    reserved_words["F2/"]       = "F2DIV"           # not standard
  }
  
  reserved_words["ZXFONT_5X8"]  = "ZXFONT_5x8"      # not standard

  inside_word_definition=0
  function_name=""
  
  string_type=""
  string_end=""
  
  fce_count=1  
  main_count=1
  
  word=""
  upword=""
  last_upword=""
  leading_spaces=""
  in_comment=0
  noname_count=0

  parenthesized_strings[".("] = "PRINT"         # .( ...)
                
  double_quoted_strings[".\""] = "PRINT"        # ." ..."
  double_quoted_strings["S\""] = "STRING"       # s" ..."
  double_quoted_strings["Z\""] = "STRING_Z"     # z" ..."   not standard
  double_quoted_strings["ABORT\""] = "ABORT_DQ" # abort" ..."
  
}

{
    for (i=1; i-1<=length($0); i++) {
    
        if ( i > length($0) ) 
            char = RS
        else
            char = substr($0, i, 1);
        
        upchar = toupper(char)

#         printf " i = %i, char = %c, >>%s<<\n", i, char, word;
        
        if ( string_end != "" )
        {
            if ( word != "" ) string_read = 1
        }
        else
            string_read = 0
        
        if ( string_read ) {
            if ( char == RS || char == string_end ) {
                process_word()
            }
            else
            {
                word = word char
                upword = upword upchar
            }
            continue
        }
        
        if (in_comment) {
            if ( in_comment == 1 && char == ")" )
                process_word() # ( ...comment... )
            else if ( in_comment == 2 && char == RS )
                process_word() # \ ...comment...
            else if ( char == RS ) {     
                word = word char ";# "
                upword = upword upchar";# "
            }
            else {
                word = word char
                upword = upword upchar
            }
            continue
        }

        if ( char ~ /[[:space:]]/ ) {
            if ( upword == "(" )
            {
                in_comment=1
                word = ""
                upword = "" 
            }
            else if ( upword == "\\" )
            {
                in_comment=2
                word = ""
                upword = ""
            }
            else if ( upword in parenthesized_strings )
            {
                # .( ...)
                string_type = parenthesized_strings[upword]
                word = ""
                upword = ""
                string_end = ")"
                string_read = 1
            }
            else if ( upword in double_quoted_strings )
            {
                # ." ..."
                # s" ..."
                # z" ..."
                # ABORT" ..."
                string_type = double_quoted_strings[upword]
                word = ""
                upword = ""
                string_end = "\""
                string_read = 1
            }
            else if ( substr(upword,length(upword)) == "(" )
            {
                # ???( ... )
                string_type = upword
                word = ""
                upword = ""
                string_end = ")"
                string_read = 1
            }
            else if ( substr(upword,length(upword)) == "\"" )
            {
                # ???" ..."
                string_type = upword
                word = ""
                upword = ""
                string_end = "\""
                string_read = 1
            }
            else if ( word != "" )
                process_word()
            else if ( string_type == "" )
                leading_spaces= leading_spaces char

            continue
        }

        word = word char
        upword = upword upchar
   
    }

}


function Name2Readable(name,readable_name) 
{
    readable_name=""

    for (j=1; j<=length(name); j++) {
        name_char = substr(name, j, 1);
        if ( j == 1 && name_char ~ /^[a-zA-Z_]$/ )
            readable_name = name_char
        else if ( j > 1 && name_char ~ /^[0-9a-zA-Z_]$/ )
            readable_name = readable_name name_char
        else if ( name_char == "\000" ) readable_name = readable_name "_NUL"    #00 Null character
        else if ( name_char == "\001" ) readable_name = readable_name "_SOH"    #01 Start of Heading
        else if ( name_char == "\002" ) readable_name = readable_name "_STX"    #02 Start of Text
        else if ( name_char == "\003" ) readable_name = readable_name "_ETX"    #03 End of Text
        else if ( name_char == "\004" ) readable_name = readable_name "_EOT"    #04 End of Transmission
        else if ( name_char == "\005" ) readable_name = readable_name "_ENQ"    #05 Enquiry
        else if ( name_char == "\006" ) readable_name = readable_name "_ACK"    #06 Acknowledge
        else if ( name_char == "\007" ) readable_name = readable_name "_BEL"    #07 Bell, Alert
        else if ( name_char == "\010" ) readable_name = readable_name "_BS"     #08 Backspace
        else if ( name_char == "\011" ) readable_name = readable_name "_HT"     #09 Horizontal Tab
        else if ( name_char == "\012" ) readable_name = readable_name "_LF"     #0A Line Feed
        else if ( name_char == "\013" ) readable_name = readable_name "_VT"     #0B Vertical Tabulation
        else if ( name_char == "\014" ) readable_name = readable_name "_FF"     #0C Form Feed
        else if ( name_char == "\015" ) readable_name = readable_name "_CR"     #0D Carriage Return
        else if ( name_char == "\016" ) readable_name = readable_name "_SO"     #0E Shift Out
        else if ( name_char == "\017" ) readable_name = readable_name "_SI"     #0F Shift In
        else if ( name_char == "\020" ) readable_name = readable_name "_DLE"    #10 Data Link Escape
        else if ( name_char == "\021" ) readable_name = readable_name "_DC1"    #11 Device Control One (XON)
        else if ( name_char == "\022" ) readable_name = readable_name "_DC2"    #12 Device Control Two
        else if ( name_char == "\023" ) readable_name = readable_name "_DC3"    #13 Device Control Three (XOFF)
        else if ( name_char == "\024" ) readable_name = readable_name "_DC4"    #14 Device Control Four
        else if ( name_char == "\025" ) readable_name = readable_name "_NAK"    #15 Negative Acknowledge
        else if ( name_char == "\026" ) readable_name = readable_name "_SYN"    #16 Synchronous Idle
        else if ( name_char == "\027" ) readable_name = readable_name "_ETB"    #17 End of Transmission Block
        else if ( name_char == "\030" ) readable_name = readable_name "_CAN"    #18 Cancel
        else if ( name_char == "\031" ) readable_name = readable_name "_EM"     #19 End of medium
        else if ( name_char == "\032" ) readable_name = readable_name "_SUB"    #1A Substitute
        else if ( name_char == "\033" ) readable_name = readable_name "_ESC"    #1B Escape
        else if ( name_char == "\034" ) readable_name = readable_name "_FS"     #1C File Separator
        else if ( name_char == "\035" ) readable_name = readable_name "_GS"     #1D Group Separator
        else if ( name_char == "\036" ) readable_name = readable_name "_RS"     #1E Record Separator
        else if ( name_char == "\037" ) readable_name = readable_name "_US"     #1F Unit Separator
        else if ( name_char == " "    ) readable_name = readable_name "_SP"     #20 Space
        else if ( name_char == "!"    ) readable_name = readable_name "_EM"     #21 Exclamation mark
        else if ( name_char == "\042" ) readable_name = readable_name "_DQ"     #22 Double quotes (or speech marks)
        else if ( name_char == "#"    ) readable_name = readable_name "_HASH"   #23 Number sign
        else if ( name_char == "$"    ) readable_name = readable_name "_DOL"    #24 Dollar
        else if ( name_char == "%"    ) readable_name = readable_name "_PER"    #25 Per cent sign
        else if ( name_char == "&"    ) readable_name = readable_name "_AMP"    #26 Ampersand
        else if ( name_char == "\047" ) readable_name = readable_name "_SQ"     #27 Single quote
        else if ( name_char == "("    ) readable_name = readable_name "_LP"     #28 Open parenthesis (or open bracket)
        else if ( name_char == ")"    ) readable_name = readable_name "_RP"     #29 Close parenthesis (or close bracket)
        else if ( name_char == "*"    ) readable_name = readable_name "_AST"    #2A Asterisk
        else if ( name_char == "+"    ) readable_name = readable_name "_PLS"    #2B Plus
        else if ( name_char == ","    ) readable_name = readable_name "_CM"     #2C Comma
        else if ( name_char == "-"    ) readable_name = readable_name "_MNS"    #2D Hyphen-minus
        else if ( name_char == "."    ) readable_name = readable_name "_DOT"    #2E Period, dot or full stop
        else if ( name_char == "/"    ) readable_name = readable_name "_DIV"    #2F Slash or divide            
        else if ( name_char == "0"    ) readable_name = readable_name "_0"      #30 Zero
        else if ( name_char == "1"    ) readable_name = readable_name "_1"      #31 One
        else if ( name_char == "2"    ) readable_name = readable_name "_2"      #32 Two
        else if ( name_char == "3"    ) readable_name = readable_name "_3"      #33 Three
        else if ( name_char == "4"    ) readable_name = readable_name "_4"      #34 Four
        else if ( name_char == "5"    ) readable_name = readable_name "_5"      #35 Five
        else if ( name_char == "6"    ) readable_name = readable_name "_6"      #36 Six
        else if ( name_char == "7"    ) readable_name = readable_name "_7"      #37 Seven
        else if ( name_char == "8"    ) readable_name = readable_name "_8"      #38 Eight
        else if ( name_char == "9"    ) readable_name = readable_name "_9"      #39 Nine
        # A..Z 
        else if ( name_char == ":"    ) readable_name = readable_name "_CLN"    #3A Colon
        else if ( name_char == ";"    ) readable_name = readable_name "_SCLN"   #3B Semicolon
        else if ( name_char == "<"    ) readable_name = readable_name "_LT"     #3C Less than (or open angled bracket)
        else if ( name_char == "="    ) readable_name = readable_name "_EQ"     #3D Equals
        else if ( name_char == ">"    ) readable_name = readable_name "_GT"     #3E Greater than (or close angled bracket)
        else if ( name_char == "?"    ) readable_name = readable_name "_QM"     #3F Question mark
        else if ( name_char == "@"    ) readable_name = readable_name "_AT"     #40 At sign
        # a..z 
        else if ( name_char == "["    ) readable_name = readable_name "_LS"     #5B Opening bracket
        else if ( name_char == "\\"   ) readable_name = readable_name "_BSL"    #5C Backslash
        else if ( name_char == "]"    ) readable_name = readable_name "_RS"     #5D Closing bracket
        else if ( name_char == "^"    ) readable_name = readable_name "_HAT"    #5E Caret - circumflex
        # _             
        else if ( name_char == "`"    ) readable_name = readable_name "_GRV"    #60 Grave accent
        else if ( name_char == "{"    ) readable_name = readable_name "_LC"     #7B Opening brace
        else if ( name_char == "|"    ) readable_name = readable_name "_VBAR"   #7C Vertical bar
        else if ( name_char == "}"    ) readable_name = readable_name "_RC"     #7D Closing () brace
        else if ( name_char == "~"    ) readable_name = readable_name "_TIL"    #7E Equivalency sign - tilde
        else if ( name_char == "\177" ) readable_name = readable_name "_DEL"    #7F Delete
        else {
            cmd = "printf \"%d\" \"'" name_char "\""
            cmd | getline name_char
            close(cmd)    
            readable_name = readable_name "_X" name_char
        }
    }
    return readable_name
}


function process_word()
{
    new_word=""

    if ( in_comment == 0 && string_type == "" ) {
        readable_name = Name2Readable(word)
    }
    # Asi by to chtelo jeste vyresit kolizi jmen jako napr. n* a n+, oboje bude n_x_.   

# printf "\n(" string_type ")>%s<\n", upword

    if (in_comment == 0 && inside_word_definition && fce_count > 2 && fce_words[fce_count-2] == "COLON" ) {
        fce_leading_spaces[fce_count] = ""
        fce_words[fce_count] = ")"
        fce_count++;
    }

    if (in_comment) {
        if (in_comment==1 && inside_word_definition && fce_count > 2 && fce_words[fce_count-2] == "COLON" ) {
            if ( in_comment == 1 ) {
                new_word = ",({{{{" word "}}}})"
                leading_spaces = "" # no use leading_spaces
            }
            else {
                fce_leading_spaces[fce_count] = ""
                fce_words[fce_count] = ")"
                fce_count++;
                new_word = ";# " word
                char = "\n"
            }
        }
        else {
            new_word = ";# " word
            char = "\n"
        }
        in_comment=0
    }
    else if ( string_type != "" ) {
    
        if ( string_type == "STRING" || string_type == "STRING_Z" || string_type == "PRINT" || string_type == "WORD" )
            new_word = string_type "({\"" word "\"})"
        else if ( string_type == "CHAR" ) {
            if ( substr(word,1,1) == "\"" )
                new_word = "PUSH(\47\"\47)"
            else
                new_word = "PUSH(\47" substr(word,1,1) "\47)"
        }
        else if ( string_type == "ABORT_DQ" ) {
            new_word = "IF PRINT({\"" word "\"}) BYE THEN ;# Originally ABORTq"
            char = "\n"
        }
        else
        {
            print "\nError in " FILENAME " at line " NR ": Unknown word with string: " string_type " " word char > "/dev/stderr"
        }
        if ( char != RS ) char = ""
        string_end = ""
        string_type = ""
        
    }
    else if (last_upword == ":" ) {
        if ( readable_name in collision_check )
            print "\nError in " FILENAME " at line " NR ": Duplicate definition or accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        
        else
            collision_check[readable_name] = word       # add new word to collision_check

        reserved_functions[readable_name] = "CALL("
        function_name = readable_name
        new_word = readable_name
        leading_spaces = "" # no use leading_spaces
    }
    else if ( last_upword == "VALUE" || last_upword == "DVALUE" || last_upword == "2VALUE" ) {
        if ( readable_name in collision_check )
            print "\nError in " FILENAME " at line " NR ": Duplicate definition or accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        
        else
            collision_check[readable_name] = word       # add new word to collision_check   

        if ( last_upword == "VALUE" )
            reserved_value[readable_name] = "PUSH(("
        else 
            reserved_value[readable_name] = "PUSHDOT(("
            
        # 30000 value name = 30000 create name ,
        #             name = name @
        # 1000000. 2value dname = 1000000. create dname , ,   ( or maybe "swap , , "?)
        #                 dname = dname 2@         
        new_word = "(" readable_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if ( last_upword == "VARIABLE" || last_upword == "DVARIABLE" || last_upword == "2VARIABLE" || last_upword == "CREATE" ) {
        if ( readable_name in collision_check )
            print "\nError in " FILENAME " at line " NR ": Duplicate definition or accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        
        else
            collision_check[readable_name] = word       # add new word to collision_check   

        #  variable name = create name 2 allot
        # 2variable name = create name 4 allot
        # name ( -- addr_name )         
        reserved_value[readable_name] = "PUSH("
        new_word = "(" readable_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if ( last_upword == "TO" ) { 
        if ( ! (readable_name in reserved_value) ) 
            print "\n\nError in " FILENAME " at line " NR ": You are trying to change the value of a non-existent variable: \"" word "\"!" > "/dev/stderr"
        else if ( collision_check[readable_name] != word )
            print "\n\nError in " FILENAME " at line " NR ": Accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        

        new_word = "(" readable_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if ( last_upword == "CONSTANT" ) { 
        if ( readable_name in reserved_value ) {
            print "\n\nError in " FILENAME " at line " NR ": Constant A constant with this name already exists.: \"" word "\"!" > "/dev/stderr"
            if ( collision_check[readable_name] != word )
                print "\n\nError in " FILENAME " at line " NR ": Accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        
        }
        else
            collision_check[readable_name] = word       # add new word to collision_check
            
        reserved_value[readable_name] = "PUSH("


        if ( main_count > 2 && ( main_words[main_count-2] ~ /^PUSH\(/ ) ) {
            
            # main_words[main_count-2] = PUSH(10)
            # main_words[main_count-1] = CONSTANT
            # readable_name = Ten

            main_words[main_count-1] = substr(main_words[main_count-2],6)
            main_words[main_count-2] = "CONSTANT"
            
            new_word = "(" readable_name "," main_words[main_count-1]
            leading_spaces = "" # no use leading_spaces

            main_count--
            
            # main_words[main_count-1] = CONSTANT
            # new_word = "(Ten,10)
        }
        else
        {
            new_word = "(" readable_name ")"
            leading_spaces = "" # no use leading_spaces
        }
    }
    else if ( readable_name in reserved_value ) {
        if ( collision_check[readable_name] != word )
            print "\n\nError in " FILENAME " at line " NR ": Accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"   

        if ( substr(reserved_value[readable_name], length(reserved_value[readable_name])-1) == "((" )
            new_word = reserved_value[readable_name] readable_name "))"     # PUSHDOT((addr_name)) or PUSH((addr_name))
        else
            new_word = reserved_value[readable_name] readable_name ")"      # PUSH(create_label)
    }
    else if ( readable_name in reserved_functions ) {
        if ( collision_check[readable_name] != word )
            print "\n\nError in " FILENAME " at line " NR ": Accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        

            new_word = reserved_functions[readable_name] readable_name ")"
    }
    else if (word == ":" ) { 
        inside_word_definition++                    # define new word
        new_word = reserved_words[word]
        leading_spaces = "\n\n"
    }
    else if ( upword == ":NONAME" ) {
        inside_word_definition++                    # define new word
        fce_leading_spaces[fce_count] = "\n\n"
        fce_words[fce_count] = "COLON"
        fce_count++;
        
        noname_count+=1
        word = "__noname" noname_count
        readable_name = Name2Readable(word)
        
        if ( readable_name in collision_check )
            print "\nError in " FILENAME " at line " NR ": Duplicate definition or accidental match in the transliteration of the word: \"" word "\" -> \"" readable_name "\"" > "/dev/stderr"        
        else
            collision_check[readable_name] = word       # add new word to collision_check

        reserved_functions[readable_name] = "PUSH("
        function_name = readable_name
        new_word = readable_name
        leading_spaces = "" # no use leading_spaces
    }
    else if ( upword == "[CHAR]" || upword == "CHAR" ) {
        string_type = "CHAR"
        string_end = " "
        word = ""
        upword = ""
        return
    }
    else if ( upword == "WORD" || upword == "PARSE" ) {

        string_end = ""
        if ( inside_word_definition ) {
            if ( fce_count > 1 ) string_end = fce_words[fce_count-1]
        }
        else if ( main_count > 1 )
            string_end = main_words[main_count-1]

        if ( string_end == "BL" )
            string_end = " "
        else if ( string_end ~ /^PUSH\('.'\)$/ ) 
            string_end = substr(string_end,7,1)
        
        if ( string_end == "" )
            print "\nError in " FILENAME " at line " NR ": Unknown terminating character for the word " upword "." > "/dev/stderr"        
        else if (inside_word_definition)
        {
            fce_count--
            leading_spaces = fce_leading_spaces[fce_count]
        }
        else
        {
            main_count--
            leading_spaces = main_leading_spaces[main_count]            
        }
   
   
        if ( upword == "PARSE" ) 
        {
            string_type = "STRING"
            string_read = 1
        }
        else
            string_type = upword

        word = ""
        upword = ""
            
        return
    }
    else if ( upword in reserved_words ) {          # standard forh word
        new_word = reserved_words[upword]
        if ( upword in use_reserved_words ) use_reserved_words[upword] = 1
    }
    else if (word ~ /^-?[0-9]+$/) {
        if ( last_upword == "ALIGN" ) {
            new_word = "(" word ")"                 # integer
            leading_spaces = ""                     # no use leading_spaces
        }
        else
            new_word = "PUSH(" word ")"             # integer
    } 
    else if (word ~ /^-?[0-9]+\.$/) {
        new_word = substr(word,1,length(word)-1)    # delete last dot
        new_word = "PUSHDOT(" new_word ")"          # double integer
    } 
    else if ((word ~ /^[+-]?[0-9][0-9]*[.]?[0-9]*[Ee][+-]?[0-9]*$/) || upword == "INF" || upword == "-INF" || upword == "NAN" ) {
        if ( arg == "-zfloat" )
            new_word = "ZPUSH(" word ")"            # floating point "string"
        else {
            new_word = "FPUSH(" word ")"            # floating point "string"           
#             new_word = "PUSH(" floatToHex(word) ") ;# = " word      # hexadecimal number representing the value of a floating-point number in Danagy 16-bit format
#             char = "\n"
        }
    }
    else {
        print "\nError in " FILENAME " at line " NR ": Undefined word \"" word "\" found." > "/dev/stderr"        
        new_word = word
    }

    if (inside_word_definition) {
        if ( word == ";") {
            if ( reserved_functions[function_name] == "PUSH(" )
            {
                main_leading_spaces[main_count] = "\n"
                main_words[main_count] = "PUSH(" function_name ")"
                main_count++;
            }            
            inside_word_definition--
            function_name = ""
            char = "\n"
        }

        if ( upword == "RECURSE" ) {
            reserved_functions[function_name] = "RCALL("
        }

        fce_leading_spaces[fce_count] = leading_spaces
        fce_words[fce_count] = new_word
        fce_count++;
    }
    else {
        main_leading_spaces[main_count] = leading_spaces
        main_words[main_count] = new_word
        main_count++;
    }
        
    last_upword = upword
    leading_spaces = char
    word = ""
    upword = ""
}


# Funkce pro zjištění relativní cesty
function find_relative_path(file) {
    # Prohledávání v aktuálním adresáři
    if (file_exists("./" file)) return "./" file

    # Prohledávání v podadresáři M4
    if (file_exists("./M4/" file)) return "./M4/" file

    # Prohledávání v nadřazeném adresáři
    if (file_exists("../M4/" file)) return "../M4/" file

    # Soubor nenalezen, vrátíme prázdný řetězec
    return "./error:relative_path_not_found!!!/" file
}

# Funkce pro ověření existence souboru
function file_exists(file) {
    return (system("[ -f \"" file "\" ]") == 0)
}


function floatToHex(value) {
    # Získání znaménka
    sign = 0
    
    if ( substr(value,1,1) == "-" ) {
        sign = 0x8000
        hexreal = sprintf( "%a", substr(value,2) )
    }
    else if ( substr(value,1,1) == "+" )
        hexreal = sprintf( "%a", substr(value,2) )
    else
        hexreal = sprintf( "%a", value )

    if ( hexreal == "0x0p+0" && sign ) {
        print "\nWarning: You are trying to convert \"negative zero\" to Danagy 16 bit floating point format, so it will be changed to a negative value closest to zero." > "/dev/stderr"                
        return "FMMIN"
    }

    if ( hexreal == "0x0p+0" ) {
        print "\nWarning: You are trying to convert \"positive zero\" to Danagy 16 bit floating point format, so it will be changed to a positive value closest to zero." > "/dev/stderr"        
        return "FPMIN"
    }

    if ( hexreal == "0xinf" && sign ) {
        print "\nWarning: You are trying to convert \"-inf\" to Danagy 16 bit floating point format. It will be converted as a smallest possible value." > "/dev/stderr"
        return "FMMAX"
    }
    
    if ( hexreal == "0xinf" ) {
        print "\nWarning: You are trying to convert \"+inf\" to Danagy 16 bit floating point format. It will be converted as a largest possible value." > "/dev/stderr"
        return "FPMAX"
    }

    if ( hexreal == "NaN" ) {
        print "\nWarning: You are trying to convert \"Not a Number\" to Danagy 16 bit floating point format. It will be converted as a positive value closest to zero." > "/dev/stderr"
        return "FPMIN"              # lol
    }

    # Výpočet exponentu
    exponent = substr(hexreal, index(hexreal, "p") + 1) + 0x40
    # Výpočet mantisy
    mantissa = substr(hexreal, index(hexreal, "x") + 1, index(hexreal, "p") - index(hexreal, "x") - 1)
    if ( mantissa ~ /^1\./ )
        mantissa = "1" substr(mantissa,3)

    mantissa = mantissa "000"
    round_nibble=substr(mantissa,4,1)
    mantissa = "0x" substr(mantissa,1,3)
    mantissa = strtonum(mantissa)

    if ( round_nibble ~ /[^0-7]/ )
        mantissa = mantissa + 1
    
    if ( mantissa == 0x200 ) {
        exponent++
        mantissa=0x00
    }
    else
        mantissa = mantissa - 0x100
        
    if ( exponent < 0 && sign ) {
        print "\nWarning: The value " value " is too close to zero, so it will be changed to a negative value closest to zero." > "/dev/stderr"        
        hexValue = "FMMIN"
    }
    else if ( exponent < 0 )
    {
        print "\nWarning: The value " value " is too close to zero, so it will be changed to a positive value closest to zero." > "/dev/stderr"        
        hexValue = "FPMIN"
    }
    else if ( exponent > 0x7F && sign )
    {
        print "\nWarning: The value " value " is less than the smallest possible value, so it will be changed to the smallest possible value." > "/dev/stderr"
        hexValue = "FMMAX"
    }   
    else if ( exponent > 0x7F)
    {
        print "\nWarning: The value " value " is greater than the largest possible value, so it will be changed to the largest possible value." > "/dev/stderr"
        hexValue = "FPMAX"
    }   
    else {
        # Sestavení hexadecimální hodnoty
        hexValue = sprintf("0x%04X", sign + exponent * 0x100 + mantissa)
    }
    return hexValue
}


END {
    if ( word != "" ) process_word()

    printf "include(`" find_relative_path("FIRST.M4") "\47)dnl\n"
    printf "  ORG 0x8000\n"
    printf "  INIT(60000)\n"
        
    # vypsani main slov
    for (i=1; i<main_count; i++) {
        printf main_leading_spaces[i] main_words[i]
    }

    printf "\n  STOP"
    
    recurse=0
    function_name = ""

    # vypsani funkci na konci s tim ze se resi zmena nekterych slov pokud je funkce rekurzivni     
    for (i=1; i<fce_count; i++) {
    
        leading_spaces = fce_leading_spaces[i]
        word = fce_words[i]

        if ( word == "COLON" ) {
            function_name = fce_words[i+1]
            recurse = 0
            if ( reserved_functions[function_name] == "RCALL(" ) recurse = 1
        }

        if ( recurse ) {
        
            if ( word == "DO" || word == "QUESTIONDO" ){
                # kontrola zda je uvnitr volano RECURSE, protoze pokud ne, tak staci obycejne smycky...
                k = 1
                no_recurse_inside = 1
                for (j=i+1; no_recurse_inside && k && j<fce_count; j++)
                {
                    new_word = fce_words[j]

                    if ( new_word == "LOOP" || new_word == "ADDLOOP" ) k--
                    if ( new_word == "DO" || new_word == "QUESTIONDO" ) k++        
                    if ( new_word == "RECURSE" ) no_recurse_inside=0                        
                }
                if ( no_recurse_inside == 0)
                    word = recurse_reserved_words[word]               
            }
            else if ( word == "FOR" ) {
                # kontrola zda je uvnitr volano RECURSE, protoze pokud ne, tak staci obycejne smycky...
                k = 1
                no_recurse_inside = 1
                for (j=i+1; no_recurse_inside && k && j<fce_count; j++)
                {
                    new_word = fce_words[j]

                    if ( new_word == "NEXT" ) k--
                    if ( new_word == "FOR" ) k++        
                    if ( new_word == "RECURSE" ) no_recurse_inside=0                        
                }
                if ( no_recurse_inside == 0)
                    word = recurse_reserved_words[word]               
            }
            else if ( word in recurse_reserved_words )
                word = recurse_reserved_words[word]
                
            if ( word == "RECURSE" ) {
                word = "RCALL(" function_name ")"
            }
        }
        
        if ( word == "COLON" || word == "RCOLON" )
            word = word "("

        printf leading_spaces word

        if ( word == "SEMICOLON" || word == "RSEMICOLON" ) {
            function_name = ""
            recurse = 0
        }

    }

    if ( use_reserved_words["SPACES"] ) {
        printf "\n\nCOLON(__SPACES,( n -- ))\n"
#         printf "    PUSH(0) MAX PUSH(0) QUESTIONDO SPACE LOOP\n"
#         printf "    DUP _0GT IF PUSH(0) DO SPACE LOOP ELSE DROP THEN\n"
#         printf "    DUP _0GT IF _1SUB FOR SPACE NEXT ELSE DROP THEN\n"
        printf "    BEGIN DUP _0GT WHILE _1SUB SPACE AGAIN DROP\n"
        printf "SEMICOLON"
    }
    
    if ( "FASIN" in use_reserved_words && use_reserved_words["FASIN"] ) {
        printf "\n\nCOLON(__FASIN,( rad -- ))\n"
        printf ";# pi/2 =  1.5707963 = 0x4092\n"
        printf ";# a0   =  1.5707288 = 0x4092\n"
        printf ";# a1   = -0.2121144 = 0xBDB2\n"
        printf ";# a2   =  0.0742610 = 0x3C30\n"
        printf ";# a3   = -0.0187293 = 0xBA33\n"
        printf ";# asin(x) = pi/2 - sqrt(1-x)*(a0 + a1*x + a2*x*x + a3*x*x*x)\n"
        printf ";# asin(x) = pi/2 - sqrt(1-x)*(a0 + x*(a1 + x*(a2 + a3*x)))\n"
        printf ";# asin(x) = pi/2 - sqrt(1-x)*(((a3*x + a2)*x + a1)*x + a0)\n"
        printf "\n"
        printf "    DUP PUSH(0x8000) AND SWAP\n"
        printf "    FABS\n"
        printf "    DUP PUSH(0x4000) SWAP FSUB FSQRT\n" 
        printf "    SWAP DUP DUP PUSH(0xBA33) FMUL\n"
        printf "    PUSH(0x3C30) FADD FMUL\n"
        printf "    PUSH(0xBDB2) FADD FMUL\n" 
        printf "    PUSH(0x4092) FADD FMUL\n"
        printf "    PUSH(0x4092) SWAP FSUB\n"
        printf "    XOR\n"
        printf "SEMICOLON"
    }

    if ( "FACOS" in use_reserved_words && use_reserved_words["FACOS"] ) {
        printf "\n\nCOLON(__FACOS,( rad -- ))\n"
        printf "  ;# x\n"
        printf "  DUP FABS DUP\n"   
        printf "  ;# x u u\n"
        printf "  PUSH(0x4000) SWAP FSUB FSQRT SWAP\n"
        printf "  ;# x sqrt(1.0-u) u\n"
        printf "  DUP DUP\n"
        printf "  PUSH(0xBA33) FMUL\n"
        printf "  PUSH(0x3C30) FADD FMUL\n"
        printf "  PUSH(0xBDB2) FADD FMUL\n"
        printf "  PUSH(0x4092) FADD\n"
        printf "  FMUL SWAP\n"
        printf "  _0LT IF PUSH(0x4192) SWAP FSUB THEN\n"
        printf "SEMICOLON"
    }

    if ( "FTRUNC" in use_reserved_words && use_reserved_words["FTRUNC"] ) {
        printf "\n\nCOLON(__ZTRUNC,( z -- round_towards_zero(z)))\n"
        printf "ZDUP      ;# ( z -- z z )\n"
        printf "Z0LT      ;# ( z z -- flag(z<0) )\n"
        printf "IF        ;# ( z flag -- z )\n"
        printf "  ZNEGATE ;# ( z -- abs(z) )\n"
        printf "  ZFLOOR  ;# ( z -- floor(fabs(z)) )\n"
        printf "  ZNEGATE ;# ftrunc(z)\n"
        printf "ELSE\n"
        printf "  ZFLOOR  ;# ftrunc(z)\n"
        printf "THEN\n"
        printf "SEMICOLON"
    }
    
#     if ( "FLOOR" in use_reserved_words && use_reserved_words["FLOOR"] ) {
#         printf "\n\nCOLON(__FLOOR,( f -- round_towards_negative_infinity(f)))\n"    
#         printf "  DUP _0LT IF\n"
#         printf "    FNEGATE DUP FTRUNC_ABS TUCK NE IF PUSH(0x4000) ;# = 1e\n"
#         printf "FADD THEN FNEGATE\n"
#         printf "  ELSE\n"
#         printf "    FTRUNC_ABS\n"
#         printf "  THEN\n"
#         printf "SEMICOLON"
#     
# #         printf "COLON(floor,({{{{f -- n }}}}))
# #         printf "  DUP _0LT IF\n"
# #         printf "    FNEGATE PUSH(0x3FFF) ;# = 0.999E\n"
# #         printf "FADD FTRUNC_ABS FNEGATE\n"
# #         printf "  ELSE\n"
# #         printf "    FTRUNC_ABS\n"
# #         printf "  THEN\n"
# #         printf "SEMICOLON"
#     }
    
    if ( "FMOD" in use_reserved_words && use_reserved_words["FMOD"] ) {
        printf "\n\nCOLON(__ZMOD,( za zb  -- zmod(a%b)))\n"
        printf "ZSWAP     ;# ( a b -- b a )\n"
        printf "ZOVER     ;# ( b a -- b a b )\n"
        printf "ZDIV      ;# ( b a b -- b (a/b) )\n"
        printf "ZDUP      ;# ( b (a/b) -- b (a/b) (a/b) )\n"
        printf "ZDUP      ;# ( b (a/b) (a/b) -- b (a/b) (a/b) (a/b) )\n"
        printf "Z0LT      ;# ( b (a/b) (a/b) (a/b) -- b (a/b) (a/b) flag )\n"
        printf "IF        ;# ( b (a/b) (a/b) flag -- b (a/b) (a/b) )\n"
        printf "  ZNEGATE ;#    ( b (a/b) (a/b) -- b (a/b) fabs(a/b) )\n"
        printf "  ZFLOOR  ;#    ( b (a/b) (-a/b) -- b (a/b) floor(fabs(a/b)) )\n"
        printf "  ZNEGATE ;#    ( b (a/b) ftrunc(-a/b) -- b (a/b) ftrunc(a/b)) )\n"
        printf "ELSE      ;# ( b (a/b) (a/b) flag -- b (a/b) (a/b) )\n"
        printf "  ZFLOOR  ;# ( b (a/b) (a/b) -- b (a/b) ftrunc(a/b) )\n"
        printf "THEN      ;# ( b (a/b) (a/b) -- b (a/b) ftrunc(a/b) )\n"
        printf "ZSUB      ;# ( b ftrunc(a/b) -- b (a/b)-ftrunc(a/b) )\n"
        printf "ZMUL      ;# ( b (a/b)-ftrunc(a/b) -- fmod(a/b) )\n"
        printf "SEMICOLON"
    }
        

    printf "\n"
}
