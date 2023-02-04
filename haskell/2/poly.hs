module Demo where
import Data.Function

getSecondFrom :: p1 -> p2 -> p3 -> p2
getSecondFrom x y z = y

mono :: Char -> Char
mono x = x

semiMono :: Char -> a -> Char
semiMono x y = x

apply2 f x = f (f x)

-- flip f y x -> f x y

multSecond = g `on` h

g x y= x * y

h a = snd a

-- \x -> 2 * x + 7
-- let lenVec x y = sqrt $ x ^ 2 + y ^ 2
-- let lenVec = \x -> \y -> sqrt $ x ^ 2 + y ^ 2
-- let lenVec = \x y -> sqrt $ x ^ 2 + y ^ 2

sumFstFst = (+) `on` helper
    where helper pp = fst $ fst pp

sumFstFst' = (+) `on` (\pp -> fst $ fst pp)

on3 :: (b -> b -> b -> c) -> (a -> b) -> a -> a -> a -> c
on3 op f x y z = op (f x) (f y) (f z)

sumFstFst'' = (+) `on` (fst . fst)