-- Homework 3 template
module Sentence where

-- Grammar for the animal sentence language:
--
--   <sentence> ->  <noun> <verb> [<noun>]  
--               	|  <sentence> `and` <sentence>
--				 	
--   <noun> 	-> <adj> <noun> | <noun> `and` <noun>
--					| `cats` | `dogs` | `bears` | `goats`

--   <verb>		->  `chase` | `cuddle` | `hug` | `scare`
--   <adj>		->	`sad` | `small` | `big` | `happy`

data Sentence
   = NVN -- finish noun verb noun sentence
   | NV -- finish noun verb sentence
   | And -- finish sentence and sentence
   | End
  deriving (Eq,Show)

data Adj = -- finish adjectives
  deriving (Eq,Show)

data Noun = -- finish
    | NP Adj Noun  -- Noun phrase
    | NAnd Noun Noun  -- Finish noun and noun
	| Bears			  -- list of nouns
  deriving (Eq,Show)

data Verb = Chase |  -- finish

  deriving (Eq,Show)



ex1 :: Sentence
ex1 = NVN Cats Hug Dogs

ex2 :: Sentence
ex2 = NVN (NP Small Cats) Hug Dogs

ex3 :: Sentence
ex3 = NVN (NAnd Dogs Cats) Chase Goats

ex4 :: Sentence
ex4 = NVN (NAnd (NP Happy Dogs) Cats) Chase Goats


-- | Build a sentence from a noun verb noun.
-- | buildS2 Cats Hug Cats
-- | NVN Cats Hug Cats

buildS2 :: Noun -> Verb ->Noun-> Sentence
-- finish

-- | Build a sentence from a noun verb 
-- | buildS1 Cats Hug 
-- | NV Cats Hug 

buildS1 :: Noun -> Verb ->Sentence
-- finish


-- | Build a noun phrase from an adjective and noun
-- | buildNP Happy Dogs
-- | NP Happy Dogs

buildNP :: Adj -> Noun -> Noun
-- finish

-- | Build a noun conjunction from two nouns
-- | buildNAnd Dogs Cats
-- | NAnd Dogs Cats

buildNAnd :: Noun -> Noun -> Noun
-- finish

-- | Build a sentence that is a conjunction of a list of other sentences.
-- | conjunction [ex1, ex2]
-- | And (NVN Cats Hug Dogs) (NVN (NP Small Cats) Hug Dogs)
-- | The End is used if no sentences are given
 
conjunction :: [Sentence] -> Sentence
conjunction []    = End
-- finish

-- | Pretty print a sentence.
pretty :: Sentence -> String
pretty (NVN s v o) = prettyNoun s ++ " " ++ prettyVerb v ++ " " ++ prettyNoun o
pretty (And l r)   = pretty l ++ " and " ++ pretty r
pretty (NV s v)     = prettyNoun s ++ " " ++ prettyVerb v
pretty (End) = "."

-- | Pretty print a noun.
prettyNoun :: Noun -> String
prettyNoun Cats  = "cats"
-- finish


prettyNoun (NP a n) = prettyAdj a ++ " " ++ prettyNoun n
prettyNoun (NAnd m n) = prettyNoun m ++ " and " ++prettyNoun n

-- | Pretty print a verb.
prettyVerb :: Verb -> String
prettyVerb Chase  = "chase"
-- finish

-- | Pretty print an adjective.
prettyAdj :: Adj -> String
prettyAdj Sad  = "sad"
-- finish


-- | Does the sentence contain only chase and scare?
-- | isMean ex2 => False
-- | isMean ex3 => True
isMean :: Sentence -> Bool
isMean (NVN _ Chase _)  = True
isMean (NVN _ Cuddle _) = False
-- finish

-- |Count the number of words in a sentence
-- | wordCount ex4
--    6

wordCount :: Sentence -> Int
wordCount ( And l r ) = wordCount l + wordCount r
-- finish