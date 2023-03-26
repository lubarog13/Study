module Demo where

import Data.Char(isDigit)
import Data.Text  as Txt (splitOn, pack, unpack, empty)
import Prelude hiding (null)

data Coord a = Coord a a

distance :: Coord Double -> Coord Double -> Double
distance (Coord a b) (Coord c d) = sqrt $ (c - a) ** (2::Double) + (d - b) ** (2::Double)

manhDistance :: Coord Int -> Coord Int -> Int
manhDistance (Coord a b) (Coord c d) = abs (c - a) + abs (d - b)

getCenter :: Double -> Coord Int -> Coord Double
getCenter size (Coord i j) = Coord (size * (realToFrac i + 0.5)) (size * (realToFrac j + 0.5))

getCell :: Double -> Coord Double -> Coord Int
getCell size (Coord x y) = Coord (floor $ x / size) (floor $ y / size)


twice :: a -> [] a
twice x = [x, x]

thrice :: a -> (,,) a a a
thrice x = (,,) x x x

id' :: (->) a a
id' x = x

findDigit :: [Char] -> Maybe Char
findDigit [] = Nothing
findDigit (x:[]) | isDigit x = Just x
                 | otherwise = Nothing
findDigit (x:xs) | isDigit x = Just x
                 | otherwise = findDigit xs

findDigitOrX :: [Char] -> Char
findDigitOrX x =  case findDigit x of
                    Just x' -> x'
                    Nothing -> 'X'

maybeToList :: Maybe a -> [a]
maybeToList x = case x of
                    Just x' -> [x']
                    Nothing -> []

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_)= Just x

data Error = ParsingError | IncompleteDataError | IncorrectDataError String deriving (Eq, Show)

data Person = Person { firstName :: String, lastName :: String, age :: Int } deriving (Show, Eq)

parsePerson :: String -> Either Error Person
parsePerson str = do
    let h1 = (splitOn (Txt.pack "\n") (Txt.pack str))
    if length h1 < 3
        then Left IncompleteDataError
        else do
            let h' = filter (\x -> x==Txt.empty) h1
            if length h' /= 0
                then Left ParsingError
                else
                    do
                    let h2 = map (\x -> Txt.splitOn (pack " = ") x) h1
                    let p = Person {lastName = "", firstName = "", age = 0}
                    if ((head $ head h2) /= (Txt.pack "firstName")) || (head $ head $ tail h2) /= (Txt.pack "lastName") || (head $ head $ tail $ tail h2) /= (Txt.pack "age") then Left ParsingError
                    else 
                        do
                            let p1 = p {firstName = unpack (head $ tail $ head h2), lastName =  unpack (head $ tail $ head $ tail h2)}
                            let ag =  unpack (head $ tail $ head $ tail $ tail h2)
                            if not $ all isDigit ag then Left $ IncorrectDataError ag
                            else
                                Right p1 {age = read ag::Int}



eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left a) = Just a
eitherToMaybe (Right _) = Nothing



helper str = map (\x -> splitOn (pack " = ") x) (splitOn (pack "\n") (pack str))