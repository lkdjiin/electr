# Grammar of Electr

    expression ::= number [[op] expression]

    number     ::= numeric | value | constant

    numeric    ::= «integer or floating point»

    value      ::= «integer or floating point directly followed by a unit»

    constant   ::= [a-z]{1,}

    op         ::= - | + |  /
