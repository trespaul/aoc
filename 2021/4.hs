import Data.List.Split (splitOn)

main = do
  txt <- readFile("4-test.txt")
  let input = splitOn "\n\n" txt
      numbers = splitOn "," $ head input
      boards = map (map words) . map lines $ tail input

  -- boards of form: boards[ board[ line[ item""] ] ]

  let parse n b = do
    if boardWon board
      then do
        print (sumBoard b) * n
        return True
    if foldl1 (&&) $ map (elem n) line
      then do
        -- remove line
        return 

  print boards
  print (map parse numbers)

  -- procedurally:
  --   for every number in numbers:
  --     if number in line (for line in board for board in boards)
  --       remove number from board (set number to "")
  --     if a board won (if has a row or column of just "")
  --       return (sum board elements) * (last number)

  -- functionally:
  --   we want the last number and the sum of remaining board elements
  --   after filtering out number from board for number in numbers
  --   number by number...
  --   


