# Grammar of Electr in EBNF

(* Sadly it's not at all up to date… *)

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
    op         = `-` | `+` |  `/` | `*`;

## Precisions

### Negative numbers

`-123` is a negative number.<br/>
`- 123` is not.

This is because the multiplication is implicit, ie `2 - 3` equals `-1` and
`2 -3` equals `-6`.
