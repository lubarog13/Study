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
