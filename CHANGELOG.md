# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased] - unreleased
### Added
- Quit gracefuly with Ctrl-C
- 10,000 and 10_000 are the same as 10000
- Electr supports negative numbers
- Coco, a code coverage tool as a developer dependency
### Modified
- One can write floating point number without a leading zero (ie `.678`).

## [0.0.2] - 2015-09-04
### Added
- Basic Read-Eval-Print-Loop as a proof of concept. It recognizes some
  units but not all
- Options -v (version), -h (help), --ast (display the AST instead of the
  result) and -e (compute this expression and quit, do not run
  interactively)
- Grammar of Electr (in `grammar.md`)
- Beginning of documentation for developers
- Precedence table
- This change log
