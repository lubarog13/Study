module Demo where

import Data.Monoid
import Control.Monad

newtype Writer w a = Writer { runWriter :: (a, w) } deriving (Show, Eq)

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd (runWriter m)

instance (Monoid w) => Monad (Writer w) where
    return x = Writer (x, mempty)
    m >>= k =
        let (x, u) = runWriter m
            (y, v) = runWriter $ k x
        in Writer (y, u `mappend` v)


instance (Monoid w) => Applicative (Writer w) where
  pure = return
  (<*>) = ap

instance (Monoid w) => Functor (Writer w) where
  fmap = liftM

evalWriter :: Writer w a -> a
evalWriter m = fst (runWriter m)

tell :: Monoid w => w -> Writer w ()
tell w = writer ((), w)

calc :: (Int -> Int -> Int) -> Int -> Int -> Writer String Int
calc op arg1 arg2 = do
  let res = arg1 `op` arg2
  tell "ok"
  if abs res < 128 then
    return res
  else do
    tell "overflow"
    return res
    

type Shopping = Writer (Sum Integer, [String]) ()

shopping1 :: Shopping
shopping1 = do
  purchase "Jeans"   19200
  purchase "Water"     180
  purchase "Lettuce"   328

purchase :: String -> Integer -> Shopping
purchase item cost = writer((), (Sum cost, [item]))

total :: Shopping -> Integer
total = getSum . fst . execWriter

items :: Shopping -> [String]
items = snd . execWriter

{-
purchase :: String -> Integer -> Shopping
purchase _ = tell . Sum

total :: Shopping -> Integer
total = getSum . execWriter
-}