module Demo where
import Data.Function

doItYourself = f . g . h

f = logBase 2

g =  (^ 3)

h = max 42

-- (,) True 3 - конструктор кортежей (True, 3)
avg :: (Double, Double) -> Double
avg p = (fst p + snd p) / 2

swap = a (b c)

a = uncurry
b = flip
c = (,)