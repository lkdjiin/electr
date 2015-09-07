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

  # f - function
  SYMBOL_TABLE = {
    'sqrt' => 'f',
  }

  PRECEDENCE = {
    '()' => {assoc: 'L', val: 99},
    ')'  => {assoc: 'L', val: 99},
    '('  => {assoc: 'L', val: 99},
    UNARY_MINUS_INTERNAL_SYMBOL => {assoc: 'R', val: 80},
    '*'  => {assoc: 'L', val: 10},
    '/'  => {assoc: 'L', val: 10},
    '-'  => {assoc: 'L', val:  1},
    '+'  => {assoc: 'L', val:  1},
  }

end
