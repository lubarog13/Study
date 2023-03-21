module Chapter2.Section2.Example where
import Data.List

data Gender = Male | Female | Unknown
              deriving Show

instance Eq Gender where
    a == b = case a of
            Female -> case b of
                        Female -> True
                        _ -> False
            Male   -> case b of
                        Male -> True
                        _ -> False
            Unknown -> case b of
                        Unknown -> True
                        _ -> False

data Client = GovOrg String
              | Company String Integer Person String
              | Individual Person Bool
              deriving Show

data Person = Person String String Gender
              deriving Show

{-
Individual (Person "Jack" "Smith" Male) True
-}

data Travel = Past | Future
              deriving Show

data TimeMachine = TimeMachine String Integer Travel Double
                    deriving Show

myLength        ::(Num b) =>  [a] -> b
myLength []     =  0
myLength (_:as) =  1 + myLength as

clientGenderCount :: [Client] -> (Integer,Integer)
clientGenderCount clients = (,) (myLength $ filter (helper Female) clients) (myLength $ filter (helper Male) clients) where 
    helper g (GovOrg _) = False
    helper g client = case client of
                        Company _ _ (Person _ _ gn) _ -> gn == g
                        Individual (Person _ _ gn) _ -> gn == g

salesMachines :: [TimeMachine] -> Double -> [TimeMachine]
salesMachines mashines sale = map (\(TimeMachine manufacture model t price) -> TimeMachine manufacture model t (price - price * sale / 100)) mashines

ackermann (m,n) | m == 0 = n + 1
                | (m > 0) && (n == 0) = ackermann (m - 1, 1)
                | (m > 0) && (n > 0) = ackermann (m-1, ackermann(m, n-1))
                | otherwise = error "must be >= 0"

ack:: (Integer, Integer) -> Integer
ack(0, n) = n + 1
ack(m, 0) = ack(m - 1, 1)
ack(m, n) = ack(m - 1, ack(m, n - 1))

unzip' a = (,) [fst x | x <- a] [snd x | x <- a]

data TimeMachine' = TimeMachine' {manufacture :: String, model :: String, travel :: Travel, price :: Integer} deriving Show