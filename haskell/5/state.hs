module Demo where
import Control.Monad (replicateM, liftM, ap)

newtype State s a = State { runState :: s -> (a, s) }

instance Monad (State s) where
    return a = State $ \st -> (a, st)
    m >>= k = State $ \st -> 
        let (a, st') = runState m st
            m' = k a
        in runState m' st'


instance Functor (State s) where
  fmap = liftM

instance Applicative (State s) where
  pure  = return
  (<*>) = ap

execState :: State s a -> s -> s
execState m s = snd (runState m s)

evalState :: State s a -> s -> a
evalState m s = fst (runState m s)

get :: State s s
get = State $ \st -> (st, st)

put :: s -> State s ()
put st = State $ \_ -> ((), st)


tick :: State Int Int
tick = do
    n <- get
    put (n + 1)
    return n

modify :: (s -> s) -> State s ()
modify f = do-- State $ \s -> ((), f s)
    s <- get
    put (f s)


newtype Reader r a = Reader { runReader :: (r -> a) }
instance Monad (Reader r) where
    return x = Reader $ \e -> x
    m >>= k = Reader $ \e ->
        let v = runReader m e
        in runReader (k v) e

instance Functor (Reader r) where
  fmap = liftM

instance Applicative (Reader r) where
  pure  = return
  (<*>) = ap


readerToState :: Reader r a -> State r a
readerToState m = State $ \st -> (runReader m st, st)


newtype Writer w a = Writer { runWriter :: (a, w) } deriving (Show, Eq)

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd (runWriter m)

instance (Monoid w) => Monad (Writer w) where
    return x = Writer (x, mempty)
    m >>= k =
        let (x, u) = runWriter m
            (y, v) = runWriter $ k x
        in Writer (y, u `mappend` v)


instance (Monoid w) => Applicative (Writer w) where
  pure = return
  (<*>) = ap

instance (Monoid w) => Functor (Writer w) where
  fmap = liftM

writerToState :: Monoid w => Writer w a -> State w a
writerToState m = State $ \s -> let (a, w) = runWriter m in (a, s `mappend` w)


succ' :: Int -> Int
succ' n = execState tick n

plus :: Int -> Int -> Int
plus n x = execState (sequence $ replicate n tick) x

plus' :: Int -> Int -> Int
plus' n x = execState (replicateM n tick) x