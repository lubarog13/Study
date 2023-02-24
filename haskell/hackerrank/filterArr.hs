module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe


f :: Int -> [Int] -> [Int]
f n arr = [x | x <- arr, x<n]

f1 :: [Int] -> [Int]
f1 [] = []
f1 (x:[]) = []
f1 (x:y:[]) = [y]
f1 (x:y:lst) = y : (f1 lst)

fn n = [1..n]

rev :: [Int] -> [Int]
rev [] = []
rev [x] = [x]
rev (x:lst) = (rev lst) ++ [x] 

f2 :: [Int] -> Int
f2 arr = sum [x | x <- arr, odd x]

len :: [a] -> Int
len lst = helper 0 lst where
    helper n [] = n
    helper n (x:lst) = helper (n+1) lst


-- The Input/Output section. You do not need to change or modify this part
main = do 
    n <- readLn :: IO Int 
    inputdata <- getContents 
    let 
        numbers = map read (lines inputdata) :: [Int] 
    putStrLn . unlines $ (map show . f n) numbers