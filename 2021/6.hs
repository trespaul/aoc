import Data.List
import Data.List.Split (splitOn)

count x y = length $ filter x y
counts input = map (\x -> count (==x) input) [0..8]

main = do
  txt <- readFile("6.txt")
  let input = map (\x -> read x :: Int) . (splitOn ",") $ txt

  -- PART 1 (brute force / semantic)
  let iterF a = (map (\x -> x - 1) . filter (/=0) $ a)
                ++ (concat . replicate (count (==0) a) $ [6,8])
  print $ length $ iterate iterF input !! 80

  -- PART 2
  let iterF' x = take 6 (drop 1 x) ++ [x!!7 + head x, x!!8, head x]
  print $ sum $ iterate iterF' (counts input) !! 256
  
