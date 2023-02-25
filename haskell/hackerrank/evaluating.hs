{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.Set
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

f :: Double -> Double -> Double
f 0 x = 1
f n x = (power x n) / factorial n + f (n - 1) x where
    factorial a = if a == 0 then 1 else a * factorial(a-1)
    power a n = if n == 0 then 1 else a * power a (n - 1)

main :: IO()
main = do
    n <- readLn :: IO Int

    forM_ [1..n] $ \n_itr -> do
        x <- readLn :: IO Double
        print (f 9 x)
