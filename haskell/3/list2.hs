module Demo where


import Data.Char
readDigits :: String -> (String, String)
readDigits str = (,) (takeWhile isDigit str) (dropWhile isDigit str)

filterDisj :: (a -> Bool) -> (a -> Bool) -> [a] -> [a]
filterDisj pr1 pr2 arr = [x | x <- arr, pr1 x || pr2 x]

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:arr) = (qsort $ filter (<x) (arr)) ++ x : (qsort $ filter (>=x) (arr))
