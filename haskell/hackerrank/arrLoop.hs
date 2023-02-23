module Main where

import System.Environment
import System.IO
import System.IO.Unsafe


f :: Int -> [Int] -> [Int]
f n arr   | arr == [] = []
          | otherwise = (helper n (head arr)) ++ (f n (tail arr)) where
            helper n a | n == 0 = []
                       |otherwise = a : helper (n-1) a

-- This part handles the Input and Output and can be used as it is. Do not modify this part.
main :: IO ()
main = getContents >>=
       mapM_ print. (\(n:arr) -> f n arr). map read. words