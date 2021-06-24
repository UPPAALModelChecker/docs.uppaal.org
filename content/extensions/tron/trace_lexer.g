options {
    mangleLiteralPrefix = "T_";
    language="Cpp";
}

class TraceLexer extends Lexer;

tokens {
    "input" ;
    "output" ;
    "delay" ;
    "timeout" ;
    "precision" ;
}

{
    public:
    bool done;
    void uponEOF() { done = true; }
}

WS_     :       (' '
        |       '\t'
        |       '\n' { newline(); }
        |       '\r')
                { _ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; }
        ;

SL_COMMENT :
        "//" (~'\n')* '\n' 
        { _ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; newline();}
        ;

LPAR   options { paraphrase="'('"; } : '(' ;
RPAR   options { paraphrase="')'"; } : ')' ;

LBRAC  options { paraphrase="'['"; } : '[' ;
RBRAC  options { paraphrase="']'"; } : ']' ;

SEMI   options { paraphrase="';'"; } : ';' ;
DOT    options { paraphrase="'.'"; } : '.' ;
COMMA  options { paraphrase="','"; } : ',' ;
AT     options { paraphrase="'@'"; } : '@' ;
STAR   options { paraphrase="'*'"; } : '*' ;

ID     options { paraphrase="an identifier"; } : LETTER (LETTER | DIGIT)* ;

protected
INT    : (DIGIT)+ ;

protected
FLOAT   : INT DOT INT ;

FLOAT_OR_INT options { paraphrase="a number"; }
    : (INT DOT) => FLOAT { $setType(FLOAT); }
    | INT { $setType(INT); }
    ;

protected
DIGIT   : '0'..'9' ;

protected
LETTER  : 'A'..'Z' | 'a'..'z' | '_' ;

