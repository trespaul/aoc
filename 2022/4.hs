import qualified Data.List.Split as Split
import Text.Read (readMaybe)
import Data.Maybe (mapMaybe)

doesContain :: Ord a => [a] -> Bool
doesContain [a, b, c, d]
  | a <= c && b >= d = True
  | c <= a && d >= b = True
  | otherwise = False

doesOverlap :: (Eq a, Enum a) => [a] -> Bool
doesOverlap [a, b, c, d]
  | a `elem` [c..d] = True | b `elem` [c..d] = True
  | c `elem` [a..b] = True | d `elem` [a..b] = True
  | otherwise = False

main = do
  txt <- readFile "4.txt"
  let input = Split.chunksOf 4
              . mapMaybe (\x -> readMaybe x :: Maybe Int)
              . Split.splitOneOf "-,\n" $ txt

  print . length . filter doesContain $ input
  print . length . filter doesOverlap $ input
