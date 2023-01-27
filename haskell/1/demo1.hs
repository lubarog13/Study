module Demo where


infixl 6 *+*

a *+* b = a ^ 2 + b ^ 2

-- (*+*) a b = a ^ 2 + b ^ 2

infixl 6 |-|

a |-| b = if ( (a - b ) > 0) then a - b else b - a

-- (2 /) 4 = 0.5
-- (/ 2) 4 = 2.0

-- f $ x = f x
-- sin (pi / 2) = sin $ pi / 2
-- let x = 3 :: Int
-- -- ((&&) False) True     Bool -> Bool -> Bool
-- (2, True) - кортежж
-- fst (2, True)  2
-- snd (2, True)  True
-- [False, True] - список

str = 'H' : "ello" -- : - добавление элемента в голову списка
str ++ " world" -- соединение списков
