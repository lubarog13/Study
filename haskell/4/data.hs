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