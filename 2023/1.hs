import Data.List (find)
import Data.Char (isDigit)
import Data.Maybe (mapMaybe)

part1 :: [[Char]] -> Int
part1 = sum . map ( (read :: String -> Int)
                  . mapMaybe (find isDigit)
                  . ( (\x y -> [x, y]) <*> reverse )
                  )

main :: IO ()
main = interact $ show . solve . parse
    where parse = lines
          solve = part1
