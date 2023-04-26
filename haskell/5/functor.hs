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