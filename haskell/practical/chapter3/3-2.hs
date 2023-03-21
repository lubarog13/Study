{-# LANGUAGE LambdaCase #-}
module Chapter3.Section2.Example where

filterOnes :: [Integer] -> [Integer]
filterOnes = filter (==1)

filterANumber :: Integer -> [Integer] -> [Integer]
filterANumber a = filter (==a)

filterNot :: (a -> Bool) -> [a] -> [a]
filterNot f = filter (\x -> not $ f x)

data Client = GovOrg { clientName :: String }
               | Company { clientName :: String, person :: Person, duty :: String }
               |   Individual { person :: Person }
                deriving (Show, Eq, Ord)
data Person = Person { firstName :: String, lastName :: String }
                deriving (Show, Eq, Ord)

isGovOrg :: Client -> Bool
isGovOrg (GovOrg _) = True
isGovOrg _ = False


filterGovOrgs :: [Client] -> [Client]
filterGovOrgs = filter isGovOrg

filterGovOrgs' :: [Client] -> [Client]
filterGovOrgs' = filter (\case (GovOrg _)-> True
                               _ -> False)