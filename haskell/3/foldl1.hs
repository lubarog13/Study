module Demo where
import Prelude hiding (iterate)
import Data.Char

lastElem :: [a] -> a
lastElem = foldl1 (\ a b -> b)

facs :: (Num a, Enum a) => [a]
facs = scanl (*) 1 [1..]

partialSums :: Num a => [a] -> [a]
partialSums = scanl (+) 0

unfold :: (b -> (a,b)) -> b -> [a]
unfold f ini = let (x,ini') = f ini in
    x : unfold f ini'


iterate f = unfold (\x -> (x,f x))

unfoldr :: (b -> Maybe (a,b)) -> b -> [a]
unfoldr f ini = helper (f ini) where
    helper (Just (x,ini')) = x : unfoldr f ini'
    helper Nothing = []

revRange :: (Char,Char) -> [Char]
revRange (a,b)= unfoldr g b
  where g x= if x<a then Nothing else Just(x, chr (ord x - 1))
