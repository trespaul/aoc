import Data.List
import Data.List.Split

main = do
  txt <- readFile("7.txt")
  let input = sort . map (\x -> read x :: Int) 
                   . (splitOn ",") $ txt

  -- PART 1
  let median = input !! (length input `div` 2)
      steps = map (abs . (median -)) input
  print $ sum steps

  -- PART 2 (not efficient but works)
  let euler n = n * (n + 1) `div` 2
      max = maximum input
      cost n m = euler (abs (m - n))
      costs = map (\n -> map (\m -> cost m n) [0..max])

  print $ minimum . map sum . transpose . costs $ input
