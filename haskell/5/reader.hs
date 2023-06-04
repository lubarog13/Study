module Demo where
import Control.Applicative -- Otherwise you can't do the Applicative instance.
import Control.Monad (liftM, ap)


safeHead = do
    b <- null
    if b
    then return Nothing
    else do
        h <- head
        return $ Just h

safeHead' = do
    e <- id
    if null e
    then return Nothing
    else return $ Just (head e)


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


ask :: Reader r r
ask = Reader id

type User = String
type Password = String
type UsersTable = [(User, Password)]

pwds :: UsersTable
pwds = [("Bill", "123"), ("Ann", "qwerty"), ("John", "2sRq8P")]

firstUser :: Reader UsersTable User
firstUser = do
    e <- ask
    return $ fst (head e)

asks :: (r -> a) -> Reader r a
asks = Reader

firstUserPwd :: Reader UsersTable Password
firstUserPwd = do
    pwd <- asks (snd . head)
    return pwd

firstUserPwd' :: Reader UsersTable Password
firstUserPwd' = asks (snd . head)

usersCount :: Reader UsersTable Int
usersCount = asks length

local :: (r -> r) -> Reader r a -> Reader r a
local f m = Reader $ \e -> runReader m (f e)

localTest :: Reader UsersTable (Int, Int)
localTest = do
    count1 <- usersCount
    count2 <- local (("Mike", "1"):) usersCount
    return (count1, count2)

reader :: (r -> a) -> Reader r a
reader f = do
    r <- ask
    return (f r)

local' :: (r -> r') -> Reader r' a -> Reader r a
local' f m = Reader $ \e -> runReader m (f e)

usersWithBadPasswords :: Reader UsersTable [User]
usersWithBadPasswords = asks (map(fst) . filter (\x -> (snd x) == "123456"))