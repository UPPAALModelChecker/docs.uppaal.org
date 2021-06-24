options {
    language="Cpp";
    namespaceAntlr="antlr";     // cosmetic option to get rid of long defines
                                // in generated code
}

class TraceParser extends Parser;
options {
        importVocab=TraceLexer; // include literals from lexer
        genHashLines = true;            // include line number information
//        buildAST = true;                        // uses CommonAST by default
}

trace: preamble (line)* ;

preamble: inputs outputs precision timeout ;

inputs   : T_input (siglist)? SEMI ;
outputs  : T_output (siglist)? SEMI ;
precision: T_precision INT SEMI ;
timeout  : T_timeout INT SEMI ;

line:   /* wait for some expected input, discard the other (inputs and/or delays) */
        T_input action (COMMA action)* SEMI
        /* try to report output now, it can be preempted by some input expectation */
        | T_output action (COMMA action)* SEMI
        /* try to delay, which can be preempted by some input at different times */
        | T_delay timestamp (COMMA expectation)* SEMI
        ;

siglist: signature (COMMA signature)* ;
signature: ID LPAR (sigidlist)? RPAR ;

sigidlist  : sigid (COMMA sigid)* ;
sigid   : ID ;

action  : chanid data ;
chanid  : ID ;

data  : LPAR (valuelist)? RPAR ;

valuelist: value (COMMA value)* ;

value: INT ;

expectation: action (timestamp)? ;

// @(x, y) means relative to start, (x, y) means relative to current moment.
// x,y means the timing interval from x till y inclusively.
timestamp: (AT)? LBRAC time COMMA time RBRAC ;

// FLOAT is interpreted in time units, INT interpreted as microseconds
time    : FLOAT | INT ;
