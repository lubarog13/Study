module Demo where

main = do
    putStrLn "What is your name?"
    name <- getLine
    putStrLn $ "Nice to meet you, " ++ name ++ "!"

main' :: IO ()
main' = do
    putStrLn "What is your name?"
    putStr "Name: "
    name <- getLine
    if (name == "") then
        main'
    else
        putStrLn $ "Hi, " ++ name ++ "!"