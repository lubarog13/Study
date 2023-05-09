module Demo where
import Control.Applicative -- Otherwise you can't do the Applicative instance.
import Control.Monad (liftM, ap)

newtype Identity a = Identity { runIdentity :: a }
    deriving (Eq, Show)

instance Monad Identity where 
    return x = Identity x
    Identity x >>= k = k x 

instance Functor Identity where
  fmap = liftM

instance Applicative Identity where
  pure  = return
  (<*>) = ap

wrap'n'succ :: Integer -> Identity Integer
wrap'n'succ x = Identity (succ x)

goWrap0 = 
    wrap'n'succ 3 >>=
    wrap'n'succ >>=
    return

goWrap1 =
    wrap'n'succ 3 >>= (\x ->
    wrap'n'succ x >>= (\y ->
    wrap'n'succ y >>= (\z ->
    return z)))

goWrap2 =
    wrap'n'succ 3 >>= (\x ->
    wrap'n'succ x >>= (\y ->
    wrap'n'succ y >>= (\z ->
    return (x,y,z))))

goWrap3 = do 
    let i = 3 
    x <- wrap'n'succ i
    y <- wrap'n'succ x
    wrap'n'succ y
    return (i, x+y)