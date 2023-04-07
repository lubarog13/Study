module Demo where

data List a = Nil | Cons a (List a) deriving Show

fromList :: List a -> [a]
fromList a = case a of
                Nil -> []
                Cons b c -> b : fromList c

toList :: [a] -> List a
toList [] = Nil
toList (x:xs) = Cons x (toList xs)

data Nat = Zero | Suc Nat deriving Show

fromNat :: Nat -> Integer
fromNat Zero = 0
fromNat (Suc n) = fromNat n + 1

toNat :: Integer -> Nat
toNat 0 = Zero
toNat n = Suc (toNat (n - 1))

add :: Nat -> Nat -> Nat
add a b = toNat (fromNat a + fromNat b)

mul :: Nat -> Nat -> Nat
mul a b = toNat (fromNat a * fromNat b)

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

fac :: Nat -> Nat
fac = toNat . factorial . fromNat


data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

height :: Tree a -> Int
height (Leaf _) = 0

height (Node (a) (b)) = 1 + max (height a) (height b)

size :: Tree a -> Int
size (Leaf _) = 1
size (Node (a) (b)) = 1 + size a + size b


avg :: Tree Int -> Int
avg t =
    let (c,s) = go t
    in s `div` c
  where
    go :: Tree Int -> (Int,Int)
    go (Leaf a) = (1, a)
    go (Node (a) (b)) = let (c1,s1) = go a
                            (c2, s2) = go b
                            in (c1 + c2, s1 + s2)

infixl 6 :+:
infixl 7 :*:
data Expr = Val Int | Expr :+: Expr | Expr :*: Expr
    deriving (Show, Eq)

expand :: Expr -> Expr
expand ((e1 :+: e2) :*: e) = if ((e1 :+: e2) :*: e) == expand e1 :*: expand e :+: expand e2 :*: expand e then (expand e1 :*: expand e :+: expand e2 :*: expand e) else expand (expand e1 :*: expand e :+: expand e2 :*: expand e)
expand (e :*: (e1 :+: e2)) = if (e :*: (e1 :+: e2)) == (expand e :*: expand e1 :+: expand e :*: expand e2) then (expand e :*: expand e1 :+: expand e :*: expand e2) else expand (expand e :*: expand e1 :+: expand e :*: expand e2)
expand (e1 :+: e2) = if (e1 :+: e2) == (expand e1 :+: expand e2) then (e1 :+: e2) else expand (expand e1 :+: expand e2)
expand (e1 :*: e2) = if (e1 :*: e2) == (expand e1 :*: expand e2) then  (e1 :*: e2) else expand (expand e1 :*: expand e2)
expand e = e