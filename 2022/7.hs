import Data.List
import Data.List.Split (splitOn)
import qualified Data.Map as Map
import Data.Maybe (isJust, mapMaybe, fromMaybe)
import Text.Read (readMaybe)

getSize :: Map.Map String [String] -> String -> Int
getSize m x = sum (maybe [] (map (\y -> if isInt y
                                        then (read y :: Int)
                                        else getSize m y
                                 )
                            ) (Map.lookup x m)
                  )
  where isInt i = isJust (readMaybe i :: Maybe Int)

main = do
  txt <- readFile "7-regexed.txt"

  let parsed = Map.fromList
              . mapMaybe (uncons . lines)
              . drop 1 . splitOn "ls "
              $ txt

  print . sum . filter (<= 100000)
        . map (getSize parsed) . Map.keys
        $ parsed



-- instead of cd then ls, just ls dirname:
--      %s/\$ cd \(.\+\)\n\$ ls/ls \1/g
-- 
-- remove filenames, leave just size:
--      %s/\(\d\+\).\+$/\1/g
--
-- remove all cd ..:
--      %s/\$ cd ..\n//g
--
-- remove "dir" in front of dirnames:
--      %s/dir //g
-- 
-- run with: nvim --headless -c '%s/\$ cd \(.\+\)\n\$ ls/ls \1/g' -c '%s/\(\d\+\).\+$/\1/g' -c '%s/\$ cd ..\n//g' -c '%s/dir //g' -c 'w 7tmp.txt' -c 'q!' 7-regexed.txt
