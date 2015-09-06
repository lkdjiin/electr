# Grammar of Electr in EBNF

    expression = [`(`], number {[op] expression}, [`)`];

    number     = numeric | value | constant | f-call;

    numeric    = integer | float;

    integer    = ? integer ?;

    float      = ? floating point number ?;

    value      = ? integer or floating point directly followed by a unit ?;

    constant   = `pi`;

    (* function call *)
    f-call     = f-name, `(`, expression, `)`;

    (* function name *)
    f-name     = ? regexp: [a-z]{1,} ?;

    (* operators *)
    op         = `-` | `+` |  `/`;
