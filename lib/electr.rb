require "optparse"

require "electr/version"
require "electr/exceptions"
require "electr/parser"
require "electr/compiler"
require "electr/ast"
require "electr/rules"
require "electr/evaluator"
require "electr/nil_evaluator"
require "electr/repl"
require "electr/option"
require "electr/base_reader"
require "electr/reader"
require "electr/ast_reader"
require "electr/printer"
require "electr/ast_printer"

module Electr

  # f - function
  SYMBOL_TABLE = {
    'sqrt' => 'f',
  }

end
