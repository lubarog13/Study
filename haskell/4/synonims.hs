module Demo where

import Data.List as L
import Prelude hiding (Monoid, mappend, mempty, lookup)

type IntegerList = [Integer]

sumSquares :: IntegerList -> Integer
sumSquares = foldr1 (+) . map (^2)

type AssocList k v = [(k, v)]

newtype IntList = IList [Int] deriving Show

example = IList [1,2]

data IntList' = IList' [Int] deriving Show

newtype A = A A


class Monoid a where
    mempty :: a
    mappend :: a -> a -> a

    mconcat :: [a] -> a
    mconcat = foldr mappend mempty

instance Monoid [a] where
    mempty = []
    mappend = (++)


newtype Sum a = Sum {getSum :: a} deriving (Eq, Ord, Show, Read, Bounded)

instance Num a => Monoid (Sum a) where
    mempty = Sum 0
    Sum x `mappend` Sum y = Sum (x + y)

newtype Product a = Product {getProduct :: a} deriving (Eq, Ord, Show, Read, Bounded)

instance Num a => Monoid (Product a) where
    mempty = Product 1
    Product x `mappend` Product y = Product (x * y)

newtype Xor = Xor { getXor :: Bool }
    deriving (Eq,Show)


instance Monoid Xor where
    mempty = Xor False
    Xor a `mappend` Xor b = Xor (a/=b)


instance (Monoid a, Monoid b) => Monoid (a, b) where
    mempty = (mempty, mempty)
    (x1, x2) `mappend` (y1, y2) = (x1 `mappend` y1, x2 `mappend` y2)

instance Monoid a => Monoid (Maybe a) where
    mempty = Nothing
    Nothing `mappend` m = m
    m `mappend` Nothing = m
    Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)

newtype Maybe' a = Maybe' { getMaybe :: Maybe a } deriving (Eq,Show)

instance Monoid a => Monoid (Maybe' a) where
    mempty = Maybe' $ Just mempty
    mappend _ (Maybe' (Nothing)) = Maybe' $ Nothing
    mappend (Maybe' (Nothing)) _ = Maybe' $ Nothing
    mappend (Maybe' x) (Maybe' y) = Maybe' $ mappend x y

class MapLike m where
    empty :: m k v
    lookup :: Ord k => k -> m k v -> Maybe v
    insert :: Ord k => k -> v -> m k v -> m k v
    delete :: Ord k => k -> m k v -> m k v
    fromList :: Ord k => [(k,v)] -> m k v
    fromList [] = empty
    fromList ((k,v):xs) = Demo.insert k v (fromList xs)

newtype ListMap k v = ListMap { getListMap :: [(k,v)] }
    deriving (Eq,Show)


instance MapLike ListMap where
    empty = ListMap []
    lookup _ (ListMap []) = Nothing
    lookup key (ListMap ((k,v):xs)) | key == k = Just v
                          | otherwise = Demo.lookup key (ListMap xs)
    insert key val (ListMap []) = ListMap ((key,val):[])
    insert key val (ListMap ((k,v):xs)) | key == k = ListMap ((k,val):xs)
                                        | otherwise = ListMap((k,v):(getListMap $ Demo.insert key val (ListMap xs)))
    delete _ (ListMap []) = ListMap []
    delete key (ListMap ((k,v):xs)) | key == k = ListMap (xs)
                                    | otherwise = ListMap((k, v):(getListMap $ Demo.delete key (ListMap xs)))