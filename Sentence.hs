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

-- Define Sentence data type
data Sentence
   = NVN Noun Verb Noun		--Noun, Verb, Noun
   | NV Noun Verb			--Noun, Verb
   | And Sentence Sentence	--Sentence conjunction
   | End					--End of Sentence
  deriving (Eq,Show)

-- Define Adjective data type
data Adj = Sad | Small | Big | Happy
  deriving (Eq,Show)

-- Define Noun data type
data Noun
    = Cats
    | Dogs
    | Bears
    | Goats
    | NP Adj Noun		--Noun phrase with an adjective
    | NAnd Noun Noun	--Noun conjunction
  deriving (Eq, Show)

-- Define Verb data type
data Verb = Chase | Cuddle | Hug | Scare
  deriving (Eq, Show)

-- | Build a sentence from a noun verb noun.
-- | buildS2 Cats Hug Cats
-- | NVN Cats Hug Cats
buildS2 :: Noun -> Verb ->Noun-> Sentence
buildS2 s v o = NVN s v o

-- | Build a sentence from a noun verb
-- | buildS1 Cats Hug
-- | NV Cats Hug
buildS1 :: Noun -> Verb ->Sentence
buildS1 s v = NV s v

-- | Build a noun phrase from an adjective and noun
-- | buildNP Happy Dogs
-- | NP Happy Dogs
buildNP :: Adj -> Noun -> Noun
buildNP a n = NP a n

-- | Build a noun conjunction from two nouns
-- | buildNAnd Dogs Cats
-- | NAnd Dogs Cats
buildNAnd :: Noun -> Noun -> Noun
buildNAnd n1 n2 = NAnd n1 n2

-- | Build a sentence that is a conjunction of a list of other sentences.
-- | conjunction [ex1, ex2]
-- | And (NVN Cats Hug Dogs) (NVN (NP Small Cats) Hug Dogs)
-- | The End is used if no sentences are given
conjunction :: [Sentence] -> Sentence
conjunction [] = End -- If the list is empty, return the End constructor
conjunction [x] = x -- If the list has only one element, return that element
conjunction (x:xs) = And x (conjunction xs) -- Recursively join head/tail conj

-- | Pretty print a sentence.
pretty :: Sentence -> String
pretty (NVN s v o) = prettyNoun s ++ " " ++ prettyVerb v ++ " " ++ prettyNoun o
pretty (And l r)   = pretty l ++ " and " ++ pretty r
pretty (NV s v)     = prettyNoun s ++ " " ++ prettyVerb v
pretty (End) = "." -- If it's the End constructor, return a period

-- | Pretty print a noun.
prettyNoun :: Noun -> String
prettyNoun Cats  = "cats"
prettyNoun Dogs = "dogs"
prettyNoun Bears = "bears"
prettyNoun Goats = "goats"
prettyNoun (NP a n) = prettyAdj a ++ " " ++ prettyNoun n
prettyNoun (NAnd m n) = prettyNoun m ++ " and " ++prettyNoun n

-- | Pretty print a verb.
prettyVerb :: Verb -> String
prettyVerb Chase  = "chase"
prettyVerb Cuddle = "cuddle"
prettyVerb Hug = "hug"
prettyVerb Scare = "scare"

-- | Pretty print an adjective.
prettyAdj :: Adj -> String
prettyAdj Sad  = "sad"
prettyAdj Small = "small"
prettyAdj Big = "big"
prettyAdj Happy = "happy"


-- | Determine if a sentence only contains the verbs chase and scare
-- | isMean ex2 => False
-- | isMean ex3 => True
isMean :: Sentence -> Bool
isMean (NVN _ Chase _) = True			--If verb is Chase, True
isMean (NVN _ Scare _) = True			--If verb is Scare, True
isMean (NVN _ _ _) = False				--If verb is not Chase or Scare, False
isMean (And l r) = isMean l && isMean r	--Recurse on left & right, return conj
isMean (NV _ Chase) = True				--If verb is Chase, True
isMean (NV _ Scare) = True				--If verb is Scare, True
isMean (NV _ _) = False					--If verb is not Chase or Scare, False
isMean End = True						--If it's the End constructor, True

-- | Counts the number of words in a sentence
-- | wordCount ex4
-- | 6
wordCount :: Sentence -> Int
wordCount (NVN s _ o) = nounWordCount s + 1 + nounWordCount o	--Add 1 for verb
wordCount (NV s _) = nounWordCount s + 1						--Add 1 for verb
wordCount (And l r) = wordCount l + 1 + wordCount r				--Add 1 for conj
wordCount End = 0								--If End constructor, return 0

nounWordCount :: Noun -> Int
nounWordCount (NP _ n) = 1 + nounWordCount n --Count words in adj-noun phrase
nounWordCount (NAnd m n) = nounWordCount m + 1 + nounWordCount n --Add 1 for con
nounWordCount _ = 1 						--If it's a simple noun, return 1
