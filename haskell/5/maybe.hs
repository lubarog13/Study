module Demo where

import Data.Char (isDigit)
{--
instance Monad Maybe where
    return = Just
    (Just x) >>= k = k x
    Nothing >>= _ = Nothing
    (Just _) >> m = m
    Nothing >> _ = Nothing
    fail _ = Nothing
--}


type Name = String
type DataBase = [(Name, Name)]

fathers, mothers :: DataBase
fathers = [("Bill", "John"),
            ("Ann", "John"),
            ("John", "Piter")]
mothers = [("Bill", "Jane"),
            ("Ann", "Jane"),
            ("Jane", "Dorothy"),
            ("Alice", "Mary")]

getM, getF :: Name -> Maybe Name
getM person = lookup person mothers
getF person = lookup person fathers

-- getF "Bill" >>= getM >>= getM

-- Ищем бабушек

grandmas :: Name -> Maybe (Name, Name)
grandmas person = do
    m <- getM person
    gmm <- getM m
    f <- getF person
    gfm <- getM f
    return (gmm, gfm)

data Token = Number Int | Plus | Minus | LeftBrace | RightBrace 
    deriving (Eq, Show)

isNumber :: String -> Bool
isNumber ""  = False
isNumber "." = False
isNumber xs  =
  case dropWhile isDigit xs of
    ""       -> True
    ('.':ys) -> all isDigit ys
    _        -> False


asToken :: String -> Maybe Token
asToken a | isNumber a = Just (Number (read a))
          | a== "(" = Just LeftBrace
          | a==")" = Just RightBrace
          | a=="+" = Just Plus
          | a=="-" = Just Minus
          | otherwise = Nothing

tokenize :: String -> Maybe [Token]
tokenize str = appendToken w where
                w = words str
                appendToken [] = Just []
                appendToken (x:xs) = case (appendToken xs) of
                                        Just arr -> case (asToken x) of
                                                        Just a -> Just (a:arr)
                                                        Nothing -> Nothing
                                        Nothing -> Nothing

data Board = Board Int deriving Show

nextPositions :: Board -> [Board]
nextPositions (Board i) = [Board (i * 10 + 1), Board (i * 10 + 2)]

-- solution code
nextPositionsN :: Board -> Int -> (Board -> Bool) -> [Board]
nextPositionsN b n pred
  | n < 0 = []
  | n == 0 = filter pred [b]
  | otherwise = do
    move      <- nextPositions b
    restMoves <- nextPositionsN move (n - 1) pred
    return restMoves

pythagoreanTriple :: Int -> [(Int, Int, Int)]
pythagoreanTriple a = do
    x <- [1..a]
    y <- [1..a]
    z <- [1..a]
    if (x*x + y*y) == z*z && x<y then "Z" else []
    return (x,y,z)