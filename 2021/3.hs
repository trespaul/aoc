import Data.List
import Data.Char (digitToInt)

-- from https://codegolf.stackexchange.com/a/43062
-- could not find builtin, simplest I could find
mode = head . snd . maximum . map ((,)=<<length) . group . sort

-- from https://stackoverflow.com/a/44217484
-- could not find a builtin again, + this wants lsb first
-- i just want to int(str, 2) like in python pls
binStrToInt :: String -> Int
binStrToInt = foldr step 0
    where step x y = (+) (digitToInt x) ( (*) y 2 )


main = do
  txt <- readFile("3-test.txt")
  let input = lines txt

  -- PART 1
  let t = transpose input

  let γString = map mode t
  let εString = map (\x -> if x=='1' then '0' else '1') γString 

  let [γ, ε] = map (binStrToInt . reverse) [γString, εString]
  print (γ * ε)

  -- Ideas via @code_report:
  -- - column-wise reduce instead of transpose?
  -- - instead of mode: fold with (+) then 1 if > 6 else 0

  -- PART 2
