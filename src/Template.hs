-- stack script --resolver lts-21.22 --optimize

import Data.List

parse :: String -> [Int]
parse = map read . lines

part1 = id

main :: IO ()
main = do
  rawInput <- getContents
  let input = parse rawInput
  print (part1 input)
