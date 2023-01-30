module Demo where
import Debug.Trace

roots :: Double 
      -> Double
      -> Double
      -> (Double, Double)

roots a b c = 
    (
        (-b - sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
    ,
        (-b + sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
    )

roots' a b c = 
    let d = sqrt ( b ^ 2 - 4 * a * c ) in
    ((-b - d) / (2 * a), (b + d) / (2 * a)) 

roots'' a b c = 
    let {d = sqrt ( b ^ 2 - 4 * a * c ); x1 = (-b - d) / (2 * a); x2 = (-b + d) / (2 * a)}
    in (x1, x2)

roots''' a b c =
    let
        x1 = (-b - d) / aTwice
        x2 = (-b + d) / aTwice
        d = sqrt $ b ^ 2 - 4 * a * c
        aTwice = 2 * a
    in (x1, x2)

rootsDiff a b c = let 
    (x1, x2) = roots a b c
    in x2 - x1

seqA :: Integer -> Integer
seqA n
    | n >= 0 = let 
        helper' n n1 n2 n3  | n == 0 = n3
             | n == 1 = n2
             | n == 2 = n1
             | n >=3  = helper' (n - 1) (n1 + n2 - 2 * n3) n1 n2
      in helper' n 3 2 1
    | otherwise = error "seqA: n must be >= 0"

roots'''' a b c = (x1, x2) where
    x1 = (-b - d) / aTwice
    x2 = (-b + d) / aTwice
    d = sqrt $ b ^ 2 - 2 * a * c
    aTwice = 2 * a

sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x = (x1, x2) where
    abs n | n >= 0    = n
          | otherwise = -n
    helper1 acc x | x < 1 = acc
                  | otherwise = helper1 (acc + mod x 10) (div x 10)
    helper2 acc x | x < 10 = acc
                  | otherwise = helper2 (acc + 1) (div x 10)

    x1 = helper1 0 (abs x)
    x2 = helper2 1 (abs x)

integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b = integ f a b 1000 where
        integ f a b n | n == 0 = 0
	              | otherwise = h * (f (a) + f (a + h)) / 2 + integ f (a + h) b (n - 1) where h = (b - a) / n

