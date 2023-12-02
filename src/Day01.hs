-- stack script --resolver lts-21.22 --optimize

import Data.Char
import Data.List
import Data.Maybe (catMaybes)
import Data.Vector ((!))
import Data.Vector qualified as V

parse :: String -> [String]
parse = lines

part1 = sum . map (read . parseLine . filter isDigit)
  where
    parseLine l = [head l, last l]

digits =
  V.fromList
    [ "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine"
    ]

digitsReversed = V.map reverse digits

firstDigit lookupTable s
  | null matches = firstDigit lookupTable $ tail s
  | otherwise = head matches
  where
    matches = take 1 . catMaybes $ scanr (\d acc -> if startsWithDigit s d then Just d else acc) Nothing [1 .. 9]
    startsWithDigit s d = show d `isPrefixOf` s || lookupTable ! (d - 1) `isPrefixOf` s

part2 = sum . map parseLine
  where
    parseLine l = firstDigit digits l * 10 + firstDigit digitsReversed (reverse l)

main :: IO ()
main = do
  rawInput <- getContents
  let input = parse rawInput
  print (part1 input)
  print (part2 input)
