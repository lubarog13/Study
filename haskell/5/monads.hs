module Demo where
import Control.Applicative -- Otherwise you can't do the Applicative instance.
import Control.Monad (liftM, ap)

data Log a = Log [String] a deriving Show

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f msg = \x -> Log [msg] (f x)

execLoggers :: a -> (a -> Log b) -> (b -> Log c) -> Log c
execLoggers x f1 f2 = case logc of
                        Log msg1 c -> Log (logb_msg:msg1) c
                        where
                        logb = f1 x
                        logb_msg = case logb of
                                    Log [msg] _ -> msg
                                    _ -> ""
                        logc = case logb of
                                Log [_] y -> (f2 y) 
                                _ -> Log [""] undefined

toKleisli :: Monad m => (a -> b) -> (a -> m b)
toKleisli f =  \x -> return (f x)

returnLog :: a -> Log a
returnLog = Log []

bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log msg x) f = case (f x) of
                            Log [msg1] y -> Log (msg ++ [msg1]) y
                            _ -> Log [] undefined

instance Monad Log where
    return = returnLog
    (>>=) = bindLog



instance Functor Log where
  fmap = liftM

instance Applicative Log where
  pure  = return
  (<*>) = ap


execLoggersList :: a -> [a -> Log a] -> Log a
execLoggersList a = foldl (>>=) (Log [] a) 
