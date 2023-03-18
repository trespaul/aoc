import Data.List (transpose)
import Data.List.Split
import qualified Data.Sequence as Seq
import Data.Foldable (toList)

extractStacks = Seq.fromList . map (Seq.fromList . reverse)
                . words . concat
                . filter (\x -> notElem '[' x && notElem ']' x)
                . transpose

extractInstructions = map (map (\x -> read x :: Int)
                           . split (dropBlanks . dropDelims
                                    $ oneOf (' ' : ['a'..'z'])))

move p ss [n, a, b] = (Seq.adjust' (Seq.take (lengthOfAthStack - n)) (a - 1)
                       . Seq.adjust' (Seq.>< ns) (b - 1)
                      ) ss
  where lengthOfAthStack = Seq.length (Seq.index ss (a - 1))
        ns = (if p == 1 then id else Seq.reverse)
             . Seq.take n . Seq.reverse $ Seq.index ss (a - 1)

main = do
  txt <- readFile "5.txt"
  let (stacks, instructions) = (\xs -> (extractStacks $ take 8 xs,
                                        extractInstructions $ drop 10 xs)
                               ) . lines $ txt

  let applySolution x = map (last . toList) . toList
                        $ foldl (move x) stacks instructions

  print $ applySolution 1
  print $ applySolution 2
