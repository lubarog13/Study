module Demo where

import Text.Printf (printf)

-- This function should return a list [area, volume].
solve :: Int -> Int -> [Int] -> [Int] -> [Double]
solve l r a b = [area, volume]
    where results = map (func a b) [(fromIntegral l),(fromIntegral l+0.001)..(fromIntegral r)]
          area = sum $ map (areaRectangle 0.001) results
          volume = sum $ map (volumeCilinder 0.001) results

func :: [Int] -> [Int] -> Double -> Double
func coefficients degrees x = sum $ map (\(c,d) -> c * x**d) (zip coef degr)
    where coef = map fromIntegral coefficients
          degr = map fromIntegral degrees

areaRectangle :: Double -> Double -> Double
areaRectangle width height = width * height

volumeCilinder :: Double -> Double -> Double
volumeCilinder height radius = (pi * radius**2) * height

{-
--Input/Output.
main :: IO ()
main = getContents >>= mapM_ (printf "%.1f\n"). (\[a, b, [l, r]] -> solve l r a b). map (map read. words). lines
-}