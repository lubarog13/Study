module Demo where

concatList :: [[a]] -> [a]
concatList = foldr (++) []

lengthList :: [a] -> Int
lengthList = foldr (\_-> (+) 1) 0

sumOdd :: [Integer] -> Integer
sumOdd = foldr (\x s -> if odd x then s + x else s) 0

meanList :: [Double] -> Double
meanList = (\(s, count) -> s / count) . foldr (\x (s,count) -> (s + x, count+1)) (0, 0)

{-
evenOnly :: [a] -> [a]
evenOnly = (fst) . foldr (\x (res, n) -> if even n then (res ++ [x], n+1) else (res, n + 1)) ([], 1) . reverse

-}

evenOnly :: [a] -> [a]
evenOnly (x : y : t) = y : evenOnly t
evenOnly _ = []