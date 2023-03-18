score1 s
  | s == "A X" = 4 | s == "B X" = 1 | s == "C X" = 7
  | s == "A Y" = 8 | s == "B Y" = 5 | s == "C Y" = 2
  | s == "A Z" = 3 | s == "B Z" = 9 | s == "C Z" = 6
  | otherwise = 0

score2 s
  | s == "A X" = 3 | s == "B X" = 1 | s == "C X" = 2
  | s == "A Y" = 4 | s == "B Y" = 5 | s == "C Y" = 6
  | s == "A Z" = 8 | s == "B Z" = 9 | s == "C Z" = 7
  | otherwise = 0

main = do
  txt <- readFile "2.txt"
  print . sum . map score1 . lines $ txt
  print . sum . map score2 . lines $ txt
