module Demo where

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