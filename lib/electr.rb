require "optparse"
require "readline"

require "electr/version"
require "electr/exceptions"
require "electr/parser"
require "electr/compiler"
require "electr/ast"
require "electr/repl"
require "electr/option"

module Electr

  UNARY_MINUS_INTERNAL_SYMBOL = '€'

  ONE_CHAR_OPERATORS = %w( + - / ^ )

  # f - function
  SYMBOL_TABLE = {
    'sqrt' => 'f',
    '√' => 'f',
    'sin' => 'f',
    'cos' => 'f',
    'tan' => 'f',
  }

  PRECEDENCE = {
    '()' => {assoc: 'L', val: 100},
    ')'  => {assoc: 'L', val: 100},
    '('  => {assoc: 'L', val: 100},
    '^'  => {assoc: 'L', val: 90},
    UNARY_MINUS_INTERNAL_SYMBOL => {assoc: 'R', val: 80},
    '*'  => {assoc: 'L', val: 10},
    '/'  => {assoc: 'L', val: 10},
    '-'  => {assoc: 'L', val:  1},
    '+'  => {assoc: 'L', val:  1},
  }

  UNITS = %w( A Hz W C V F R Ω S ℧ H )

  PREFIXES = %w( k M G T m μ u n p )

  # u μ - micro farad
  # n   - nano farad
  # p   - pico farad
  # k K - kilo ohm
  ABBREVIATIONS = %w( u μ n p k K )

end
