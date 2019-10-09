# mkpw - it makes passwords

Have you ever tried to type a password like this?
`"xa)=9qI%Tq3<0Ai2Drd!7JbT<-I^r6M`

It's difficult! Too easy to lose your place, impossible to catch mistypes,
and super hard to verbally relay to anyone.

Luckily there's a better way with passwords composed of random words. Like
this: `Bright5*foRthy`

* Easy to type and easy to say, because words.
* Easy to catch your mistypes, because you know `yield` is spelled with an `l`, not
  a `k`.
* More easily remembered, because it consists of fewer mental "chunks"
* Just as secure as any other similar length password.
* Still meets arcane complexity requirements by separating words with a random
  number and symbol.
* The tool can also make very long passwords:
  `cLubland>5cryptaRch>5cirCumambages>5unOwed>5venoMsome>5Eland`

## Interface

```bash
  -c, --chars= <integer> # exactly this length
  -g, --greater-than= <integer> # longer than <integer> characters; must be < less-than
  -l, --less-than= <integer> # shorter than <integer> characters; must be > greater-than

  -A, --no-alpha[s] # don't use characters from the alphabet (s optional)
  -N, --no-number[s] # don't use numbers
  -S, --no-special[s] # don't use specials
  -W, --no-word[s] # don't use words

  -s, --seperator= <integer> # length of word seperator; defaults to 2; no effect without words enabled; 0 disables seperator
  -q, --quantity= <integer> # quantity of passwords to generate

```

So
