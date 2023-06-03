module Demo where
import System.Directory
import Data.List
import System.IO

main' :: IO ()
main' = do
    putStr "Substring: "
    hFlush stdout
    regex <- getLine
    if (regex == "") then
        putStrLn "Canceled"
    else
        do
            files <- getDirectoryContents(".")
            let new_files = reverse (filter (\f -> isInfixOf regex f) files)
            let removingF [] = putStr ""
                removingF (x:xs) = do
                                    succ <- removeFile x
                                    removingF xs
                                    putStrLn ("Removing file: " ++ x)
            removingF new_files