module Demo where

import Data.Functor

data Point3D a = Point3D a a a deriving Show

instance Functor Point3D where
    fmap f (Point3D a b c) = Point3D (f a) (f b) (f c)

data GeomPrimitive a = Point (Point3D a) | LineSegment (Point3D a) (Point3D a)

instance Functor GeomPrimitive where
    fmap f (Point a) = Point (fmap f a)
    fmap f (LineSegment a b) = LineSegment (fmap f a) (fmap f b)

data Tree a = Leaf a | Branch (Tree a) a (Tree a) deriving Show

instance Functor Tree where
    fmap g (Leaf x) = Leaf (g x)
    fmap g (Branch l x r) = Branch (fmap g l) (g x) (fmap g r)

data Tree' a = Leaf' (Maybe a) | Branch' (Tree' a) (Maybe a) (Tree' a) deriving Show

instance Functor Tree' where
    fmap _ (Leaf' Nothing) = Leaf' Nothing
    fmap g (Leaf' (Just x)) = Leaf' (Just(g x))
    fmap g (Branch' l Nothing r) = Branch' (fmap g l) (Nothing) (fmap g r)
    fmap g (Branch' l (Just x) r) = Branch' (fmap g l) (Just(g x)) (fmap g r)

data Entry k1 k2 v = Entry (k1, k2) v  deriving Show
data Map k1 k2 v = Map [Entry k1 k2 v]  deriving Show

instance Functor (Entry k1 k2) where
    fmap g (Entry (k1, k2) v) = Entry (k1, k2) (g v)

instance Functor (Map k1 k2) where
    fmap _ (Map [])= Map []
    fmap g (Map xs) =  Map (map (fmap g) xs)