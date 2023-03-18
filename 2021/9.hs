main = do
  txt <- readFile("9-test.txt")
  let input =  lines $ txt
  print $ map (\x -> map (\y -> (read y :: Int)) x) $ input
