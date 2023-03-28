module Chapter3.Section3.Example where
import Prelude hiding (product, all)

data Client = GovOrg { clientName :: String }
               | Company { clientName :: String, person :: Person, duty :: String }
               |   Individual { person :: Person }
                deriving (Show, Eq, Ord)

data Person = Person { firstName :: String, lastName :: String }
                deriving (Show, Eq, Ord)

product [] = 0
product (x:[]) = x
product (x:xs) = x * product xs

companyName :: Client -> String
companyName x = case x of
                    (GovOrg clientName) -> clientName
                    (Company clientName _ _) -> clientName
                    (Individual (Person firstName lastName)) -> firstName ++ " " ++ lastName

mayBeToClient :: Maybe Client -> Client
mayBeToClient Nothing = GovOrg ""
mapMaybeToClient (Just a) = a

minimumClient :: [Client] -> Maybe Client
minimumClient [] = Nothing
minimumClient (x:[]) = Just $ x
minimumClient (x:xs) = do
    let lst = minimumClient xs
    if lst == Nothing then Just x
    else
        do
        if (length $ companyName $ mapMaybeToClient lst) < (length $ companyName x)
            then lst
            else Just $ x

all :: [Bool] -> Bool
all [] = False
all (x:[]) = x
all (x:xs) = x && all xs

product' :: [Integer] -> Integer
product' = foldr (\x -> (*) x) 1


all' :: [Bool] -> Bool
all' = foldr (\x -> (&&) x) True