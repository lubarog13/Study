module Demo where

data Coord a = Coord a a

distance :: Coord Double -> Coord Double -> Double
distance (Coord a b) (Coord c d) = sqrt $ (c - a) ** (2::Double) + (d - b) ** (2::Double)

manhDistance :: Coord Int -> Coord Int -> Int
manhDistance (Coord a b) (Coord c d) = abs (c - a) + abs (d - b)