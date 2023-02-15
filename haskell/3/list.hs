module Demo where

import Prelude hiding (length, (++), null)

import Data.List (transpose)

lst = []

lst1 = 5 : 3 : lst -- добавление элемента в начало списка


lst2 = [5,3]  == lst1

cons42 = (42 :)

addTwoElements :: a -> a -> [a] -> [a]
addTwoElements a b c = a : b : c

nTimes:: a -> Int -> [a]
nTimes a b = take b (repeat a)

hd = head [1, 2, 3] -- первый элемент - tail - все, кроме 1

second :: [a] -> a
second = head . tail

fst' ((,) x y) = x
head' ((:) x xs) = x
tail' ( x : xs) = xs
tail'' (_ : xs) = xs
second' (_ : xs) = head xs

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x : xs ++ ys

null :: [a] -> Bool
null [] = True
null _ = False

oddsOnly :: Integral a => [a] -> [a]
oddsOnly xs = [x | x <- xs, odd x]

-- last - последний элемент списка
-- init - все, кроме последнего

isPalindrome xs = xs == reverse xs

--zip - Объединение списков по парам
--zip3 - тройка
--unzip - наоборот

sum3 :: Num a => [a] -> [a] -> [a] -> [a]
sum3 x1 x2 x3 = [sum x | x <- transpose [x1, x2, x3]]


comp x xs = x == head xs

-- ToDo 
groupElems :: Eq a => [a] -> [[a]]
groupElems [] = []
groupElems xs = span (`comp` xs) xs
