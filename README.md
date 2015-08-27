Electr
======

Interactive language for electronic formulas (on the command line).

## Rationale

- I have not found an open source language or calculator at the command line,
specialized in electronic formulas
- I'm always confused with milli, micro, pico, nano, etc
- I prefer to type 100K than 100000, or 100M than 100000000
- If, for any reason, I want to write 100000000, then I should be able to write
100_000_000 or 100,000,000

## Vote

If enough people are interested in this project, I'll write this langage. First,
a quick prototype in Ruby, as a proof of concept. And then, maybe, a more portable
version in C.

So, if you are interested, **say it out loud**. Tell me what you think on
[twitter](https://twitter.com/lkdjiin) or open an
issue here on Github. In any cases feel free to start a discussion.

## Examples

Following are quick examples of what I have in my mind (`E> ` is the prompt of Electr).

### Resistors in serie

Start simple to illustrate the addition. We have a 10,000 Ohm resistor (10K) and
a 200 Ohm resistor (200R):

    E> 10K + 200R
    10.2K

If you omit the unit for the second resistor, it's OK but Electr cannot guess
anymore the result's unit. Note that 10,200 is 10200 with a visual separator:

    E> 10K + 200
    10,200

### Ohm's law

Divide Volts (V) by milliamps (mA) to get some Ohms (R):

    E> 3V / 25mA
    120R

Or to get kilo Ohms (K):

    E> 3V / 1mA
    3K

There is no symbol for the multiplication. Simply put values side by side:

    E> 1mA 3K
    3V


### Frequency of an oscillator

A little bit more complex is the computation of a frequency for an oscillator.
We've got two constants (`2` and `pi`), a value in micro Farad (`0.5uF`) and
a square root (`v~`) of the product of two resistors (`11K 22K`). The result
is in Hertz.

    E> 1 / (2 pi 0.5uF v~(11K 22K))
    205Hz

One are less prone to typing errors if one enter this expression spaned on two
lines:

    E> 1 /
    E> 2 pi 0.5uF v~(11K 22K)
    205Hz

### Interactive?

Electr could be more *interactive*. In the following session we've got a
resistor R1 and two capacitors C1 and C2. Once the formula is entered, Electr
ask us for the components values, then gives us the result:

    E> 1/
    E> 2 pi R1 v~(C1 C2)
    R1=?> 33K
    C1=?> 1000pF
    C2=?> 470pF
    7.04KHz

## Fun

I like the name Electr but I thinked of some other possibilities:

1. elec
2. elect
3. reform
4. electra
5. formula
6. reformul

What do you think?
