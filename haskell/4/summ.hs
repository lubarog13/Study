module Demo where
import Data.Function
data Point = Pt Double Double deriving Show

origin :: Point
origin = Pt 0.0 0.0

distanceToOrigin :: Point -> Double
distanceToOrigin (Pt x y) = sqrt (x ^ 2 + y ^ 2)

distance :: Point -> Point -> Double
distance (Pt x1 y1) (Pt x2 y2) = sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)


rootsOld :: Double -> Double -> Double -> (Double, Double)
rootsOld a b c = (x1, x2) where
    x1 = helper (-d)
    x2 = helper d
    helper x = (-b + x) / (2 * a)
    d = sqrt discr
    discr = b ^ 2 - 4 * a * c


data Roots = Roots Double Double | None
    deriving Show
roots :: Double -> Double -> Double -> Roots
roots a b c 
    | discr >= 0 = Roots x1 x2
    | otherwise = None
    where
        x1 = helper (-d)
        x2 = helper d
        helper x = (-b + x) / (2 * a)
        d = sqrt discr
        discr = b ^ 2 - 4 * a * c

data Shape = Circle Double | Rectangle Double Double
area :: Shape -> Double
area f = case f of
            Circle r -> (2*pi* r^2)
            Rectangle a b -> a * b
square :: Double -> Shape
square a = Rectangle a a

isSquare :: Shape -> Bool
isSquare s = case s of
                Rectangle a b -> a == b
                _ -> False


data Bit = Zero | One deriving (Eq, Show)
data Sign = Minus | Plus deriving (Eq, Show)
data Z = Z Sign [Bit] deriving (Eq, Show)

add :: Z -> Z -> Z
add a b = integerToZ ((zToInteger a) + (zToInteger b))

mul :: Z -> Z -> Z
mul a b = integerToZ ((zToInteger a) * (zToInteger b))

zToInteger (Z sign bytes) =  
        if sign == Minus then (-1) * (integer bytes) else integer bytes
        where 
            bytesArray bytes' = zip (map (\b -> if b == Zero then 0 else 1) bytes') [0..]
            number = foldr (\(b,i) ini -> ini + b * (2^i)) 0 
            integer = number . bytesArray 


integerToZ number = 
    if number > 0 then
        Z Plus (result number)
    else if number == 0 then
        Z Plus []
    else
        Z Minus (result ((-1) * number))
    where 
        intToBytes 0 = [0]
        intToBytes n = (n `mod` 2) : intToBytes (n `div` 2)
        bytesToZ = map (\x -> if x == 0 then Zero else One) 
        result n = reverse $ bytesToZ $ (dropWhile (\x -> x == 0) (reverse (intToBytes n)))