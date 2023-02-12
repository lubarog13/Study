module Demo where

a = 127.2
b = 24.1
c = 20.1
d = 2

ip = show a ++ show b ++ show c ++ show d

class (Enum a, Bounded a, Eq a) => SafeEnum a where
  ssucc :: a -> a
  ssucc a | maxBound == a = minBound
          | otherwise = succ a

  spred :: a -> a
  spred a | minBound == a = maxBound
            | otherwise = pred a

avg :: Int -> Int -> Int -> Double
avg a b c = (fromIntegral a + fromIntegral b + fromIntegral c ) / 3.0
