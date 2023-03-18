import Data.List (nub, inits, find)
import Data.List.HT (takeRev)
import Data.Maybe (maybe)

allDifferent :: Eq a => [a] -> Bool
allDifferent x = length x == length (nub x)

findNDistinct :: Eq a => Int -> [a] -> Int
findNDistinct n = maybe 0 length
                  . find (allDifferent . takeRev n)
                  . drop n . inits

main = do
  txt <- readFile "6.txt"
  print $ findNDistinct 4 txt
  print $ findNDistinct 14 txt
