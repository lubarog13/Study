module Demo where
import Debug.Trace

factorial n = if n == 0 then 1 else n * factorial  (n - 1)

factorial' 0 = 1
factorial' n = n * factorial' (n-1)
factorial'' 0 = 1
factorial'' n = if n<0 then error "arg must be >=0" else n * factorial''  (n - 1)

doubleFact :: Integer -> Integer
doubleFact n = if n <= 0
                  then 1
                  else ("n value is: " ++ show n) `trace` n * doubleFact(n - 2)


factorial''' 0 = 1
factorial''' n | n < 0 = error "arg must be >=0"
               | n > 0 = n * factorial''' (n-1)

factorial4 :: Integer -> Integer
factorial4 n | n==0 = 1
             | n> 0 = n *factorial4(n-1)
             | otherwise = error "arg must be >=0"

fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n | n > 1 = fibonacci (n - 1) + fibonacci (n - 2)
            | n < 0 = fibonacci (n + 2) - fibonacci (n + 1)

factorial5 n | n>=0 = helper 1 n
             | otherwise = error "arg must be >=0"

helper acc 0 = acc
helper acc n = helper (acc * n) (n - 1)

fibonacci' n = helper' n 0 1

helper' n curr prev | n == 0 = curr
             | n > 0  = helper' (n - 1) (curr + prev) curr
             | n < 0  = helper' (n + 1) prev (curr - prev)

factorial6 n
    | n >= 0 =let
        helper acc 0 = acc
        helper acc n = helper (acc * n) (n - 1)
      in helper 1 n
    | otherwise = error "arg must be >=0"

factorial7 :: Integer -> Integer
factorial7 n | n>=0 = helper 1 n
             | otherwise = error "arg must be >=0"
    where
        helper acc 0 = acc
        helper acc n = helper (acc * n) (n - 1)