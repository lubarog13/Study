module Demo where
import Prelude hiding (lookup)

class MapLike m where
    empty :: m k v
    lookup :: Ord k => k -> m k v -> Maybe v
    insert :: Ord k => k -> v -> m k v -> m k v
    delete :: Ord k => k -> m k v -> m k v
    fromList :: Ord k => [(k,v)] -> m k v
    fromList [] = empty
    fromList ((k,v):xs) = Demo.insert k v (fromList xs)

newtype ArrowMap k v = ArrowMap { getArrowMap :: k -> Maybe v }

instance MapLike ArrowMap where
    empty = ArrowMap(\_ -> Nothing)
    lookup key mp = (getArrowMap mp) key
    insert key val mp = ArrowMap (\k -> if(k == key) then Just val else (getArrowMap mp) k)
    delete key mp = ArrowMap (\k -> if(k == key) then Nothing else (getArrowMap mp) k)
    