import Data.List

isVisible :: [[Int]] -> (Int, Int) -> Bool
isVisible m (x, y) = t > maximum treesWest
                  || t > maximum treesEast
                  || t > maximum treesNorth
                  || t > maximum treesSouth
  where t = (m !! x) !! y
        treesWest = take y (m !! x)
        treesEast = drop (y + 1) (m !! x)
        treesNorth = take x (transpose m !! y)
        treesSouth = drop (x + 1) (transpose m !! y)

scenicScore m (x, y) = length (takeWhile (<= t) (reverse treesWest))
                     * length (takeWhile (<= t) treesEast)
                     * length (takeWhile (<= t) (reverse treesNorth))
                     * length (takeWhile (<= t) treesSouth)
  where t = (m !! x) !! y
        treesWest = take y (m !! x)
        treesEast = drop (y + 1) (m !! x)
        treesNorth = take x (transpose m !! y)
        treesSouth = drop (x + 1) (transpose m !! y)

main :: IO ()
main = do
  txt <- readFile "8.txt"

  let parsed = map (map (\x -> read [x] :: Int)) . lines $ txt

      insideIndexes = [(x, y) | x <- [1..(length parsed - 2)],
                          y <- [1..(length (head parsed) - 2)]]

      indexes = [(x, y) | x <- [0..(length parsed - 1)],
                          y <- [0..(length (head parsed) - 1)]]

      insideVisible = length . filter id
                      . map (isVisible parsed)
                      $ insideIndexes

--  print $ insideVisible
--          + length parsed * 2 -- side elements
--          + (length (head parsed) - 2) * 2 -- top and bottom - corners

  print . maximum . map (scenicScore parsed) $ indexes
