# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).


## [Unreleased] - unreleased
### Added
- All units and prefix used in electronic (sort of)
- √ as an alias of sqrt
- The version now has a codename. The current one is «Units»

### Fixed
- A bug where some illegal tokens produced an infinite loop

## [0.0.4] - 2015-09-09
### Added
- Exponent operator: ^
- New functions: sin, cos and tan
- Using the [readline library][readline]
- There's now a branch «development» on Github
[readline]: https://cnswww.cns.cwru.edu/php/chet/readline/rltop.html

### Modified
- In order to use the readline library the license of Electr switch from
  MIT to [Apache 2.0][apache2]
[apache2]: http://www.apache.org/licenses/LICENSE-2.0

### Fixed
- Temporarily limits function's arity to one. This fixes some minor bugs in
  the AST.


## [0.0.3] - 2015-09-07
### Added
- Quit gracefuly with Ctrl-C
- 10,000 and 10_000 are the same as 10000
- Electr supports negative numbers
- Coco, a code coverage tool as a developer dependency
- Enable Travis Continuous Integration tool

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
