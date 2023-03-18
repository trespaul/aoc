import Data.List.Split (chunksOf)
import Data.List (intersect)
import Data.Maybe (mapMaybe)
import qualified Data.Map as Map

halve :: [a] -> ([a], [a])
halve = splitAt . (`div` 2) =<< length

priorities = Map.fromList $ zip (['a'..'z'] ++ ['A'..'Z']) [1..52]

score :: [Char] -> Integer
score = sum . mapMaybe (`Map.lookup` priorities)

main = do
  txt <- readFile "3.txt"
  let inputLines = lines txt

  print . score . concatMap (uncurry intersect . halve) $ inputLines
  print . score . concatMap (foldl1 intersect) . chunksOf 3 $ inputLines
