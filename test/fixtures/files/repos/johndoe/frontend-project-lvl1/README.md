### Hexlet tests and linter status:
[![Actions Status](https://github.com/antonsmolko/frontend-project-lvl1/workflows/hexlet-check/badge.svg)](https://github.com/antonsmolko/frontend-project-lvl1/actions?query=workflow%3Ahexlet-check)
[![Actions Status](https://github.com/antonsmolko/frontend-project-lvl1/workflows/CI/badge.svg)](https://github.com/antonsmolko/frontend-project-lvl1/actions?query=workflow%3ACI)
<a href="https://codeclimate.com/github/codeclimate/codeclimate/maintainability"><img src="https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/maintainability" /></a>

# Brain Games

> The essence of the game is to answer the question correctly. The game will be completed after three correct answers.

The package including the following games:

- [Brains Even](#brains-even)
- [Brains Calc](#brains-calc)
- [Brains GCD](#brains-gcd)
- [Brains Progression](#brains-progression)
- [Brains Prime](#brains-prime)

## Getting started

```sh
$ make install

$ make publish

$ sudo npm link
```

To start in the terminal enter the name of the game

For example:

```sh
$ brain-even # brains-even brains-calc brains-gcd brains-progression brains-prime
```

At the start of each game you will be asked to enter you name:

```
$ May i have your name?
```
You will need to enter your name

For example:

```sh
$ brain-even

$ May i have your name?
```
```sh
# Anton
```
```
$ Hello, Anton!
```

Unsuccessful scenario:

```
$ Answer "yes" if the number is even, otherwise answer "no"
$ Question: 55
```

```sh
# yes
```
```
$ "yes" is wrong answer ;(. Correct answer was "no".
$ Let's try again, Anton!
```

Succefull scenario:
```
$ Answer "yes" if the number is even, otherwise answer "no"
$ Question: 55
```
```sh
# no
```
```
$ Correct!
$ Question: 30
```
```sh
# yes
```
```
$ Correct!
$ Question: 7
```
```sh
# no
```
```
$ Correct!
$ Congratulations, Anton!
```

It's as simple as that!

Learn more at:

## Brain Even

```sh
$ brain-even
```
Game rule:
```
..

$ Answer "yes" if the number is even, otherwise answer "no"
```

[![asciicast](https://asciinema.org/a/C9DEDkPjjdc4QIjAGNvOMPFo2.svg)](https://asciinema.org/a/C9DEDkPjjdc4QIjAGNvOMPFo2)

## Brain Calc

```sh
$ brain-calc
```
Game rule:
```
..

$ What is the result of the expression?
```



[![asciicast](https://asciinema.org/a/TzTqoP1Jn65cR1pHsNIAG5C4O.svg)](https://asciinema.org/a/TzTqoP1Jn65cR1pHsNIAG5C4O)

## Brain GCD

```sh
$ brain-gcd
```
Game rule:
```
..

$ What is the result of the expression?
```

[![asciicast](https://asciinema.org/a/lSRboCe7RtdruemOa8q5tBjfC.svg)](https://asciinema.org/a/lSRboCe7RtdruemOa8q5tBjfC)

## Brain Progression

```sh
$ brain-progression
```
Game rule:
```
..

$ What number is missing in the progression?
```

[![asciicast](https://asciinema.org/a/F1uXNyj5dI9CgbsBwbp8Y2U0L.svg)](https://asciinema.org/a/F1uXNyj5dI9CgbsBwbp8Y2U0L)

## Brain Prime

```sh
$ brain-prime
```
Game rule:
```
..

$ Answer "yes" if the number is even, otherwise answer "no"
```

[![asciicast](https://asciinema.org/a/bDZ756RSIO1w7RADxZjexsmAi.svg)](https://asciinema.org/a/bDZ756RSIO1w7RADxZjexsmAi)

## Good Luck!