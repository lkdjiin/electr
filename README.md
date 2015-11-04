# Electr [![Gem Version](https://badge.fury.io/rb/electr.png)](http://badge.fury.io/rb/electr) [![Build Status](https://travis-ci.org/lkdjiin/electr.png)](https://travis-ci.org/lkdjiin/electr)

Interactive language for electronic formulas.

What's new? Take a look at [CHANGELOG.md](CHANGELOG.md).

## Rationale

- I have not found an open source language or calculator at the command line,
specialized in electronic formulas
- I'm always confused with milli, micro, pico, nano, etc
- I prefer to type 100k rather than 100000, or 100M rather than 100000000
- If, for any reason, I want to write 100000000, then I should be able to write
100_000_000 or 100,000,000

I don't want a big monster but a tiny specialized language.

## What do you think?

I started to write this tiny language. First, a quick prototype in Ruby, as a
proof of concept. And then, maybe, a more portable version in C.

Tell me what you think on [twitter](https://twitter.com/lkdjiin) or better,
open an issue here on Github. In any cases feel free to start a discussion.

The current version is an early one:

1. Don't expect too much
2. Expect a lot of bugs
3. Please be kind enough to report any bugs here in Github

## Installation

Install it with:

    $ gem install electr

## Examples of what Electr can do right now

### Start Electr

Just type `electr`:

    $ electr

And you'll see the prompt waiting for you:

    E>

To compute an expression without entering the interactive mode, use the `-e`
switch:

    $ electr -e "3V / 25mA"
    120

To display the AST instead of doing the computation, use the `--ast` switch
(*this is intended only for the developers*):

    $ electr --ast -e "3V / 25mA"
    ast
      root
        operator (/)
          value ::= 3V
          value ::= 25mA

### Resistors in serie

Start simple to illustrate the addition. We have a 10,000 Ohm resistor (10k) and
a 200 Ohm resistor (200R):

    E> 10k + 200R
    10200

*Should it be `K`, `k`, `kΩ` or the three is still open to debate.*

### Ohm's law

Divide Volts (V) by milliamps (mA) to get some Ohms:

    E> 3V / 25mA
    120

There is no symbol for the multiplication. Simply put values side by side:

    E> 1mA 3k
    3

### Frequency of an oscillator

A little bit more complex is the computation of a frequency for an oscillator.
We've got two constants (`2` and `pi`), a value in micro Farad (`0.5uF`) and
a square root (`sqrt`) of the product of two resistors (`11k 22k`). The result
is in Hertz.

    E> 1 / (2 pi 0.5uF sqrt(11k 22k))
    20.4617344581

### Variables

A variable name must be an uppercase letter followed by a digit or more:

    R1 = 22k

The same formula as above can be written using variables:

    E> C1 = 0.5uF
    E> R1 = 11k
    E> R2 = 22k
    E> 1 / (2 pi C1 sqrt(R1 R2))
    20.4617344581

### Units, Prefixes and Abbreviations

Electr knows the following units:

Symbol  | Name
:-----: | -----
A       | ampere
Ω R     | ohm
V       | volt
W       | watt
F       | farad
Hz      | hertz
C       | coulomb
S ℧     | siemens
H       | henry

Units can be combined with the following prefixes:

Symbol  | Name
:-----: | -----
k       | kilo
M       | mega
G       | giga
T       | tera
m       | milli
μ u     | micro
n       | nano
p       | pico

There is also the following abbreviations:

Symbol  | Name
:-----: | -----
u μ     | micro farad
n       | nano farad
p       | pico farad
k K     | kilo ohm

### What is missing?

Electr is at a very early stage and it miss a lot of (basic) things!
You can expect that the following features will be implemented in the
next couple of days/weeks:

- [x] Negative numbers
- [x] Floating point number without a leading zero (ie `.678`)
- [x] 10_000 or 10,000 will be the same as 10000
- [x] More builtin functions (sin, cos, tan)
- [x] Exponent
- [x] Readline lib in the REPL for a better user experience
- [x] All units and prefix used in electronic
- [x] `*` for the multiplication if one want to
- [x] √ for an alternative to square root
- [ ] Shortcuts for function's names (ie sq and sqr for sqrt)

## What's next?

Maybe Electr could infer the resulting unit:

    E> 10k + 200R
    10.2kΩ
    E> 3V / 25mA
    120Ω
    E> 3V / 1mA
    3kΩ

One are less prone to typing errors (less parenthesis) if one enter a complex
expression on two lines:

    E> 1 /
    E> 2 pi 0.5uF sq(11K 22K)
    20.46Hz

### Beyond the calculator

Electr could be more **interactive**. In the following session we've got a
resistor R1 and two capacitors C1 and C2. Once the formula is entered, Electr
ask us for the components values, then gives us the result.

    E> 1/
    E> 2 pi R1 sq(C1 C2)
    R1=?> 33K
    C1=?> 1000pF
    C2=?> 470pF
    7.04kHz

Why not having custom functions?

    E> func = { 1 / (2 pi R1 sq(C1 C2)) }
    E> func(R1=33k, C1=1000pF, C2=470pF)
    7.04kHz

*The above syntax is just one possibility amongst a lot of others.*

## Contributing

1. Fork it ( https://github.com/lkdjiin/electr/fork )
2. **PLEASE Create your feature branch** (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Alternatives

Some people point me to two existing softwares:

- [Frink](https://futureboy.us/frinkdocs/)
- [GNU Units](https://en.wikipedia.org/wiki/GNU_Units)

Frink is closed source, so it doesn't meet my requirements. GNU Units is
awesome and close to what I want but it's so huge and not at all specialized!
I want to deal with ohms, farads, volts, etc and not with kilograms nor with
furlongs ;)

## License

[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0)
