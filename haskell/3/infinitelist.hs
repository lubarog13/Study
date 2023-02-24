module Demo where
import Prelude hiding (repeat, foldr)

nats n = n : nats (n + 1)
main = take 10 $ nats 5
fibStream :: [Integer]
fibStream = 0 : zipWith (+) (1:fibStream) fibStream
repeatHelper = id
repeat = iterate repeatHelper
data Odd = Odd Integer deriving (Eq,Show)
-- не убирайте комментарий с предыдущей строки
-- определение Odd уже присутствует в вызывающей программе
instance Enum Odd where
     succ (Odd x) = Odd (x + 2)
     pred (Odd x) = Odd (x - 2)
     toEnum x = Odd $ toInteger x * 2 + 1
     fromEnum (Odd x) = quot (fromInteger x - 1) 2
     enumFrom = iterate succ
     enumFromThen (Odd x) (Odd y) = map Odd [x, y ..]
     enumFromTo (Odd x) (Odd y) = map Odd [x, x + 2 .. y]
     enumFromThenTo (Odd x) (Odd y) (Odd z) = map Odd [x , y .. z]

coins = [2, 3, 7]
change :: (Ord a, Num a) => a -> [[a]]
change n | n < minimum coins = []
         | otherwise = [ s : y | s <- coins, y <- [] : (change $ n - s), (sum $ s:y) == n] where
          coins = [2, 3, 7]
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f ini [] = ini
foldr f ini (x:xs) = x `f` foldr f ini xs