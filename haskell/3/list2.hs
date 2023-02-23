module Demo where


import Data.Char
readDigits :: String -> (String, String)
readDigits str = (,) (takeWhile isDigit str) (dropWhile isDigit str)

filterDisj :: (a -> Bool) -> (a -> Bool) -> [a] -> [a]
filterDisj pr1 pr2 arr = [x | x <- arr, pr1 x || pr2 x]

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:arr) = (qsort $ filter (<x) (arr)) ++ x : (qsort $ filter (>=x) (arr))

squares'n'cubes :: Num a => [a] -> [a]
squares'n'cubes = concatMap (\x -> [x^2, x^3]) 

perms :: [a] -> [[a]]
perms a = helper a []
  where
    helper [] _ = [[]]
    helper [y] ys = map (\x -> y:x) (helper ys [])
    helper (y : ys) zs = helper [y] (ys ++ zs) ++ helper ys (y : zs)

delAllUpper :: String -> String
delAllUpper str = unwords ([x | x <- words str, x /= map toUpper x] )
-- delAllUpper = unwords . filter (any isLower) . words
max3 :: Ord a => [a] -> [a] -> [a] -> [a]
max3 a b c =  zipWith max (zipWith max a b) c
