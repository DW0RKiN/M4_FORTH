BEGIN {
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
  
  reserved_words["NEGATE"]      = "NEGATE"
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
  reserved_words["EMIT"]        = "EMIT"
  reserved_words["TYPE"]        = "TYPE"

  reserved_words["SPACE"]       = "SPACE"
  reserved_words["CR"]          = "CR"
  reserved_words["FOR"]         = "FOR"
  reserved_words["NEXT"]        = "NEXT"
  reserved_words["TRUE"]        = "TRUE"
  reserved_words["FALSE"]       = "FALSE"
  reserved_words["VARIABLE"]    = "VARIABLE"
  reserved_words["2VARIABLE"]   = "DVARIABLE"

  reserved_words["VALUE"]       = "VALUE"
  reserved_words["2VALUE"]      = "DVALUE"
  reserved_words["DVALUE"]      = "DVALUE"          # not standard
  reserved_words["TO"]          = "TO"
  reserved_words["[CHAR]"]      = ""
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
  reserved_words["."]           = "DOT"
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

  reserved_words["?KEY"]         = "QUESTIONKEY"
  reserved_words["KEY"]         = "KEY"

  reserved_words["D>S"]         = "D_TO_S"
  reserved_words["S>D"]         = "S_TO_D"

  recurse_reserved_words["DO"]          = "DO(R)"
  recurse_reserved_words["QUESTIONDO"]  = "QUESTIONDO(R)"
  recurse_reserved_words["FOR"]         = "FOR(R)"
  recurse_reserved_words["CALL"]        = "RCALL"
  recurse_reserved_words["COLON"]       = "RCOLON"
  recurse_reserved_words["EXIT"]        = "REXIT"
  recurse_reserved_words["SEMICOLON"]   = "RSEMICOLON"
  
  if ( arg == "-zfloat" ) {

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
    reserved_words["FDUP"]      = "ZDUP"
    reserved_words["FEXP"]      = "ZEXP"
    reserved_words["F@"]        = "ZFETCH"
    reserved_words["FTRUNC"]    = "ZINT"            # not standard
    reserved_words["FLN"]       = "ZLN"
    reserved_words["F*"]        = "ZMUL"
    reserved_words["F**"]       = "ZMULMUL"
    reserved_words["FNEGATE"]   = "ZNEGATE"
    reserved_words["FOVER"]     = "ZOVER"
    reserved_words["FROT"]      = "ZROT"
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
  } else {
    reserved_words["D>F"]       = "D_TO_S S2F"      # for compatibility with the standard
    reserved_words["F>D"]       = "F2S S_TO_D"      # for compatibility with the standard
    reserved_words["S>F"]       = "S2F"
    reserved_words["F>S"]       = "F2S"
    reserved_words["U>F"]       = "U2F"             # not standard
    reserved_words["F>U"]       = "F2U"             # not standard
    
    reserved_words["FABS"]      = "FABS"
#     reserved_words["FACOS"]     = ""
    reserved_words["F+"]        = "FADD"    
    reserved_words["FASIN"]     = "CALL(__FASIN,( rad --))"   # for compatibility with the standard
#     reserved_words["FATAN"]     = ""    # for compatibility with the standard
    reserved_words["FCOS"]      = "PUSH(0x4092) SWAP FSUB FSIN ;# ( cos  0..π only)\n"   # for compatibility with the standard
    reserved_words["F/"]        = "FDIV"
    reserved_words["F."]        = "FDOT"
    reserved_words["FDROP"]     = "DROP"            # for compatibility with the standard
    reserved_words["FDUP"]      = "DUP"             # for compatibility with the standard
    reserved_words["FEXP"]      = "FEXP"
    reserved_words["F@"]        = "FETCH"           # for compatibility with the standard
    reserved_words["FTRUNC"]    = "FTRUNC"   
    reserved_words["FLN"]       = "FLN"
    reserved_words["F*"]        = "FMUL"
#     reserved_words["F**"]       = ""
    reserved_words["FNEGATE"]   = "FNEGATE"
    reserved_words["FOVER"]     = "OVER"            # for compatibility with the standard
    reserved_words["FROT"]      = "ROT"             # for compatibility with the standard
    reserved_words["FSIN"]      = "FSIN ;# ( sin -π/2..π/2 only)\n"
    reserved_words["FSQRT"]     = "FSQRT"
    reserved_words["F!"]        = "STORE"           # for compatibility with the standard
    reserved_words["F-"]        = "FSUB"

    reserved_words["FSWAP"]     = "SWAP"            # for compatibility with the standard
    reserved_words["FTAN"]      = "DUP FSIN SWAP PUSH(0x4092) SWAP FSUB FSIN FDIV ;# ( tan  0..π/2 only)\n"   # for compatibility with the standard
    reserved_words["FVARIABLE"] = "VARIABLE"        # for compatibility with the standard
#     reserved_words["F<="]       = "LE"
#     reserved_words["F>="]       = "GE"
    reserved_words["F<>"]       = "NE"              # for compatibility with the standard
#     reserved_words["F>"]        = "GT"
#     reserved_words["F<"]        = "LT"
    reserved_words["F="]        = "EQ"              # for compatibility with the standard
    reserved_words["F0<"]       = "_0LT"            # for compatibility with the standard
    reserved_words["F0="]       = "_2MUL _0EQ"      # for compatibility with the standard
    reserved_words["FLOAT+"]    = "_2ADD"           # for compatibility with the standard

    reserved_words["FFRAC"]     = "FFRAC"           # not standard
    reserved_words["FMOD"]      = "FMOD"            # not standard
    reserved_words["F2*"]       = "F2MUL"           # not standard
    reserved_words["F2/"]       = "F2DIV"           # not standard
  }
  
  inside_word_definition=0
  function_name=""
  in_string=0
  
  fce_count=1  
  word=""
  upword=""
  last_upword=""
  leading_spaces=""
  in_comment=0
  use_fasin=0
  
  printf "include(`" find_relative_path("FIRST.M4") "\47)dnl\n"
  printf "  ORG 0x8000\n"
  printf "  INIT(60000)\n"
    
}

{
    if (in_comment) process_word()

    for (i=1; i-1<=length($0); i++) {
    
        if ( i > length($0) ) 
            char = RS
        else
            char = substr($0, i, 1);
        
        upchar = toupper(char)

#         printf " i = %i, char = %c, >>%s<<\n", i, char, word;

        if (in_string) {
        
            if (substr(word,2,1) == "\"" && char == "\"" ) {
                char = ""
                process_word()
            }
            else if (substr(word,2,1) == "(" && char == ")" ) {
                char = ""
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
            if ( in_comment == 2 && i > length($0) ) 
                process_word()
            else {
                word = word char
                upword = upword upchar
                if ( in_comment == 1 && char == ")" ) {
                    char = ""
                    process_word()
                }
            }
            continue
        }

        if ( char ~ /[[:space:]]/ ) {
            if ( upword == "S\"" )
            {
                in_string++
                word = word char
                upword = upword upchar
            }
            else if ( upword == ".(" )
            {
                in_string++
                word = word char
                upword = upword upchar
            }
            else if ( upword == ".\"" )
            {
                in_string++
                word = word char
                upword = upword upchar
            }
            else if ( upword == "(" )
            {
                in_comment=1
                word = word char
                upword = upword upchar
            }
            else if ( upword == "\\" )
            {
                in_comment=2
                word = word char
                upword = upword upchar
            }
            else if ( word != "" )
                process_word()
            else
                leading_spaces= leading_spaces char

            continue
        }

        word = word char
        upword = upword upchar
   
    }

}


function process_word()
{
    new_word=""
    
    new_name=""
    if ( in_comment == 0 && in_string == 0 ) {
        for (j=1; j<=length(word); j++) {
            name_char = substr(word, j, 1);
            if ( j == 1 && name_char ~ /^[a-zA-Z_]$/ )
                new_name = new_name name_char
            else if ( name_char ~ /^[0-9a-zA-Z_]$/ )
                new_name = new_name name_char
            else if ( name_char == "?" ) new_name = new_name "_Q_"
            else if ( name_char == "!" ) new_name = new_name "_E_"
            else if ( name_char == "." ) new_name = new_name "_D_"
            else if ( name_char == "\47" ) new_name = new_name "_A_"
            else if ( name_char == "," ) new_name = new_name "_C_"
            else if ( name_char == "[" ) new_name = new_name "_L_"
            else if ( name_char == "]" ) new_name = new_name "_R_"
            else
                new_name = new_name "_X_"
        }
    }
    # Asi by to chtelo jeste vyresit kolizi jmen jako napr. n* a n+, oboje bude n_x_.   

# printf "\n>%s<\n", upword

    if (in_comment == 0 && inside_word_definition && fce_count > 2 && fce_words[fce_count-2] == "COLON" ) {
        fce_leading_spaces[fce_count] = ""
        fce_words[fce_count] = ")"
        fce_count++;
    }

    if (in_comment) {
        if (in_comment==1 && inside_word_definition && fce_count > 2 && fce_words[fce_count-2] == "COLON" ) {
            if ( in_comment == 1 ) {
                new_word = ",{{{{" word "}}}})"
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
    else if (in_string) {
    
# print ">>" substr(upword,1,1)

        if ( substr(upword, 1, 3) == "S\" " )
            new_word = "STRING({\"" substr(word, 4) "\"})"
        else if ( substr(upword, 1, 1) == "." )
            new_word = "PRINT({\"" substr(word, 4) "\"})"
        else
        {
            print "Error! " word > "/etc/stderr"
        }
        
        in_string--
    }
    else if (last_upword == ":" ) {
        reserved_functions[word] = new_name
        function_name = new_name
        recurse_functions[function_name] = 0
        new_word = new_name
        leading_spaces = "" # no use leading_spaces
    }
    else if (last_upword == "VALUE" ) { 
        reserved_name[word] = new_name
        new_word = "(" new_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if (last_upword == "DVALUE" || last_upword == "2VALUE") { 
        reserved_dname[word] = new_name
        new_word = "(" new_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if ( last_upword == "TO" ) { 
        if ( word in reserved_name ) { 
            new_word = "(" reserved_name[word] ")"
            leading_spaces = "" # no use leading_spaces
        }
        else if ( word in reserved_dname ) {
            new_word = "(" reserved_dname[word] ")"
            leading_spaces = "" # no use leading_spaces
        }
        else
            print "Error " word " is not value name!" >> "/etc/stderr"
    }
    else if ( last_upword == "CREATE" ) { 
        reserved_name[word] = new_name
        new_word = "(" new_name ")"
        leading_spaces = "" # no use leading_spaces
    }
    else if (word in reserved_name) {
        new_word = "PUSH((" reserved_name[word] "))"
    }
    else if (word in reserved_dname) {
        new_word = "PUSHDOT((" reserved_dname[word] "))"
    }
    else if (word in reserved_functions) {
        new_word = reserved_functions[word]
        if ( recurse_functions[new_word] )
            new_word = "RCALL(" new_word ")"
        else
            new_word = "CALL(" new_word ")"
    }
    else if (word == ":" ) { 
        inside_word_definition++
        new_word = reserved_words[word]
        leading_spaces = "\n\n"
    }
    else if (upword in reserved_words) {   
        new_word = reserved_words[upword]
    }
    else if (word ~ /^" [^"].*$"/) {
        new_word = "PRINT({\"" word "\"})"
    }
    else if (word ~ /^-?[0-9]+$/) {
        new_word = "PUSH(" word ")"
    } 
    else if (word ~ /^-?[0-9]+\.$/) {
        new_word = "PUSHDOT(" substr(word,1,length(word)-1) ")"
    } 
    else if (word ~ /^([+-]?[0-9]+([.][0-9]*)?|[+-]?[.][0-9]+)([Ee][+-]?[0-9]+)?$/ ) {
        if ( arg == "-zfloat" )
            new_word = "PUSH_Z(" word ")"
        else
            new_word = "PUSH(" floatToHex(word) ")"
    }
    else if ( last_upword == "[CHAR]" ) {
        new_word = "PUSH(\47" substr(word,1,1) "\47)"
        leading_spaces = "" # no use leading_spaces
    }
    else {
        new_word = "PUSH(" word ")"
    }

    if (inside_word_definition) {
        if ( upword == "RECURSE" ) {
            recurse_functions[function_name] = 1
        }
        if ( word == ";") {
            inside_word_definition--
            function_name = ""
            char = "\n"
        }
        fce_leading_spaces[fce_count] = leading_spaces
        fce_words[fce_count] = new_word
        fce_count++;
    }
    else {
        printf leading_spaces new_word
    }

    if ( new_word ~ /^CALL\(__FASIN,\( rad --\)\)$/ ) 
        use_fasin++

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
    sign = (value < 0) ? 0x8000 : 0

    # Absolutní hodnota
    absValue = (value < 0) ? -value : value

    hexreal = sprintf( "%a", absValue )
    
    if ( hexreal == "0x0p+0" )
        return "FPMIN"

    if ( hexreal == "-0x0p+0" )
        return "FMMIN"

    if ( hexreal == "0xinf" )
        return "FPMAX"

    if ( hexreal == "-0xinf" )
        return "FMMAX"

    if ( hexreal == "NaN" )
        return "FPMIN"              # lol

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
        hexValue = "FMMIN"
    }
    else if ( exponent < 0 )
    {
        hexValue = "FPMIN"
    }   
    else if ( exponent > 0x7F && sign )
    {
        hexValue = "FMMAX"
    }   
    else if ( exponent > 0x7F)
    {
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
    printf "\n  STOP"
    
    recurse=0
    function_name = ""

    for (i=1; i<fce_count; i++) {
    
        leading_spaces = fce_leading_spaces[i]
        word = fce_words[i]

        if ( word == "COLON" ) {
            function_name = fce_words[i+1]
            recurse = recurse_functions[function_name]
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
        
        if ( word == "CALL(__FASIN,( rad --))" ) 
            use_fasin++        
    }
    
    if ( use_fasin ) {
        printf "\n\nCOLON(__FASIN) ;# ( rad -- )\n"
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

    printf "\n"
}
