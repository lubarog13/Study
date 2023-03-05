module Demo where

data B = T | F deriving (Eq, Show, Read, Enum)

not' :: B -> B
not' T = F
not' F = T

data Color = Red | Green | Blue

instance Show Color where
    show Red = "Red"
    show Green = "Green"
    show Blue = "Blue"

{-
instance Show Color where
    show x = case x of Red   -> "Red"
                       Green -> "Green"
                       Blue  -> "Blue"

-}

charToInt :: Char -> Int
charToInt n = case n of
                '0' -> 0
                '1' -> 1
                '2' -> 2
                '3' -> 3
                '4' -> 4
                '5' -> 5
                '6' -> 6
                '7' -> 7
                '8' -> 8
                '9' -> 9

stringToColor :: String -> Color
stringToColor n = case n of
                    "Red" -> Red
                    "Green" -> Green
                    "Blue" -> Blue

data LogLevel = Error | Warning | Info
cmp :: LogLevel -> LogLevel -> Ordering
cmp ll1 ll2 = compare (helper ll1) (helper ll2) where
    helper ll = case ll of
        Error -> 2
        Warning -> 1
        Info -> 0

data Result = Fail | Success
doSomeWork :: SomeData -> (Result,Int)
processData :: SomeData -> String
processData dat = case doSomeWork dat of
                    (Fail,err) -> "Fail: " ++ show err
                    (Success, _) -> "Success"