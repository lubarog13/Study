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



main :: IO()
main = do
    n <- readLn :: IO Int
    helper (n-1) where helper n | n == 0 = putStrLn "Hello World"
                            | otherwise = do 
                                        putStrLn "Hello World"
                                        helper (n-1) 
    -- Print "Hello World" on a new line 'n' times.