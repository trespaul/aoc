import Data.List

main = do
  txt <- readFile("2.txt")
  let d = map words $ lines txt
  -- let pairs = [(i, j) | [i, j] <- d]
  -- (,)?

  let lastToInt x = read (last x) :: Int
  let going pair direction = head pair == direction

  -- PART 1
  let (horiz, vert) = partition (\x -> x `going` "forward") d
  let totalH = sum $ map lastToInt horiz
  let totalV = sum $ map (\x -> if x `going` "down" 
                                then (lastToInt x)
                                else (- lastToInt x)
                         ) vert

  print (totalH * totalV)

  -- PART 2
  -- mapAccumL?
