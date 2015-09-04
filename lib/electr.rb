require "optparse"

require "electr/version"
require "electr/exceptions"
require "electr/parser"
require "electr/compiler"
require "electr/ast"
require "electr/rules"
require "electr/evaluator"
require "electr/repl"
require "electr/option"
require "electr/reader"
require "electr/printer"

module Electr

  # f - function
  SYMBOL_TABLE = {
    'sqrt' => 'f',
  }

end
