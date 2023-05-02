# Homework 3
Submit a pdf for problems 1 – 4 and a Haskell *.hs file for problem 5.

1. Using the grammar below, show a parse tree and a leftmost derivation for the sentence
```
B = (A+C)*B
  <assign>  -> <id> = <expr>
  <expr>    -> <expr> * <term>
            | <term>
  <term>    -> <factor> + <term> | <factor> - <term>
            | <factor>
  <factor>  -> ( <expr> )
            | <id>
  <id>      -> A|B|C```
```

2. Rewrite the following BNF to add the **postfix** ++ and -- unary operators of Java.
```
  <assign>  -> <id> = <expr>
  <expr>    -> <expr> * <term>
            | <term>
  <term>    -> <factor> + <term> | <factor> - <term>
            | <factor>
  <factor>  -> ( <expr> )
            | <id>
  <id>      -> A|B|C
```

3. Show that the following grammar is ambiguous. Note: The terminals symbols are in bold.
```
<compare>   -> <boolexpr> == <boolexpr>
<boolexpr>  -> <boolexpr> && <boolexpr> | <boolexpr> OR <boolexpr>
            | <bool>
            | ! <bool>
<bool>      -> <boolvalue> | <boolvar>
<boolvalue> -> True | False | 0 | 1
<boolvar>   -> x|y|z
```

4. Write a grammar G for the language L consisiting of strings of 0’s and 1’s that are the binary representation of odd integers greater that 4. For example 011 ∉ L, 0101 ∈ L, 101 ∈ L, 0110 ∉ L. Draw parse trees for the strings 1011 and 1101

5. Below is the EBNF grammar for the animal sentence language
```
<sentence>  -> <noun> <verb> [<noun>]
            | <sentence> `and` <sentence>
<noun>      -> <adj> <noun> | <noun> `and` <noun>
            | `cats` | `dogs` | `bears` | `goats`
<verb>      -> `chase` | `cuddle` | `hug` | `scare`
<adj>       -> `sad` | `small` | `big` | `happy`
```

*Note: the nonterminals are in < > and the terminals are in \` \`.

Using the Sentence.hs template provided.
- a) Define the abstract syntax for the animal language as a Haskell data type.
- b) Provide “pretty printing“ functions for the sentences in the language.
- c) Provide functions to build a sentence.
- d) Write a function isMean to determine if a sentence only contains the verbs chase and scare.
- e) Write a function to build a sentence that is a conjunction of other sentences. f) Write a function wordCount that computes the number of words in a sentence
