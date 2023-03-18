import Data.List (sort)
import Data.List.Split (splitOn)

main = do
  txt <- readFile "1.txt"

  let elves = map (foldl (\x y -> x + (read y :: Int)) 0 . lines)
              . splitOn "\n\n" $ txt

  print . maximum $ elves
  print . sum . take 3 . reverse . sort $ elves
