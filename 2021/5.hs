import Data.List.Split (splitOn)
import Data.List

-- adapted from so q/31753677
range x y
  | x == y = [x]
  | x > y = x : (range (x - 1) y)
  | x < y = x : (range (x + 1) y)

range2 [[a, b], [c, d]]
  | a == c = zip (repeat a) (range b d)
  | b == d = zip (range a c) (repeat b)
  | otherwise = []

range3 [[a, b], [c, d]]
  | a == c = zip (repeat a) (range b d)
  | b == d = zip (range a c) (repeat b)
  | otherwise = zip (range a c) (range b d)

count x y = length $ filter x y
counts = map length . group . sort


main = do
  txt <- readFile("5.txt")
  let input = map (map (map (\x -> read x :: Int))) 
              $ map (map (splitOn ",")) 
              . map (splitOn " -> ") 
              . lines $ txt

  let process f = count (>=2) . counts . concat . map f
      partOne = process range2 $ input
      partTwo = process range3 $ input

  print partOne
  print partTwo
