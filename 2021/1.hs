import Data.List.HT

main = do
  txt <- readFile("1.txt")
  let d = map read (lines txt) :: [Int]

  -- PART 1
  let count x y = length $ filter (==x) y
  let solution = count True . mapAdjacent (<)
  print $ solution d

  {-
     or just
       length $ filter (==True) $ mapAdjacent (<) d
     or (via Conner Hoekstra [@code_report])
       length . filter (==True) . mapAdjacent (<) $ d
  -}


  -- PART 2
  let sum3 x y z = sum [x, y, z]
  let mapAdjacent3 f xs = zipWith3 f (drop 1 xs) (drop 2 xs) (drop 3 xs)
  print $ solution $ mapAdjacent3 sum3 d

  {-
     there has to be a better way than repeated drops
     or generic mapAdjacentN, i.e., n-wise fold.
     the source of mapAdjacent is
       mapAdjacent f xs = zipWith f xs (tail xs)
  -}
