-- stack script --resolver lts-21.22 --optimize

import Data.List
import Data.List.Split

data Game = Game {gameId :: Int, gameBags :: [Bag]}

data Bag = Bag Int Int Int deriving (Show)

parse :: String -> [Game]
parse = map parseLine . lines
  where
    parseLine l =
      let [idString, bagString] = splitOn ":" (drop 5 l)
          bagsStrings = map (chunksOf 2 . filter (not . null) . splitOneOf ", ") $ splitOneOf ";" bagString
          bags = map (foldr addToBag (Bag 0 0 0)) bagsStrings
       in Game (read idString) bags
    addToBag [n, c] (Bag r g b)
      | c == "red" = Bag (r + read n) g b
      | c == "green" = Bag r (g + read n) b
      | c == "blue" = Bag r g (b + read n)

isValid (Bag r g b) = r <= 12 && g <= 13 && b <= 14

part1 = sum . map gameId . filter (all isValid . gameBags)

maxCubes :: Bag -> [Int] -> [Int]
maxCubes (Bag r g b) [rmax, gmax, bmax] = [max r rmax, max g gmax, max b bmax]

part2 = sum . map (product . foldr maxCubes [0, 0, 0] . gameBags)

main :: IO ()
main = do
  rawInput <- getContents
  let input = parse rawInput
  print (part1 input)
  print (part2 input)
