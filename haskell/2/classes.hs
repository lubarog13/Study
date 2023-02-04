module Demo where
{- class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x/=y = not(x == y)
    x==y = not(x /= y)
        
instance Eq Bool where
    True  == True = True
    False == False = True
    _     == _     = False

instance (Eq a, Eq b) => Eq (a, b) where
    p1 == p2 = fst p1 == fst p2 && snd p1 == snd p2
instance Eq a =>Eq [a] where
    ==
 -}
class Printable a where
    toString :: a -> String

instance Printable Bool where
    toString True = "true"
    toString False = "false"

instance Printable () where
    toString () = "unit type"

instance (Printable a, Printable b) => Printable(a, b) where
    toString (a, b) = "(" ++ (toString a) ++ "," ++ (toString b) ++ ")"