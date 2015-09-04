# Grammar of Electr in EBNF

    expression = [`(`], number {[op] expression}, [`)`];

    number     = numeric | value | constant | fcall;

    numeric    = ? integer or floating point ?;

    value      = ? integer or floating point directly followed by a unit ?;

    constant   = `pi`;

    (* function call *)
    fcall      = fname, `(`, expression, `)`;

    (* function name *)
    fname      = ? regexp: [a-z]{1,} ?;

    (* operators *)
    op         = `-` | `+` |  `/`;
