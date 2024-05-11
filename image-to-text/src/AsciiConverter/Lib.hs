module AsciiConverter.Lib
    (
        Config (..),
        resizeImage,
        convertToAscii,
    ) where
-- Importing necessary modules
import  AsciiConverter.Const     ( asciiCharactersMap, brightnessWeight )

import  Data.List                ( map )
import  Data.Vector.Storable     ( toList )

import  Graphics.Image           as I
import  Graphics.Image.Interface ( Array (toVector) )

import  Prelude

-- Data type for configuration settings
data Config = Config
  { imageWidth :: Int
  , imageColor :: Bool
  }


-- Resizes an image to a specified width while maintaining aspect ratio
resizeImage :: Array arr cs e => Int -> Image arr cs e -> Image arr cs e
resizeImage width img = scale Bilinear Edge (scaleFactor, scaleFactor) img
    where
        currentWidth = I.cols img
        scaleFactor = fromIntegral width / fromIntegral currentWidth :: Double

-- Converts a pixel to an ASCII character
replacePixel :: Pixel RGB Double -> String
replacePixel (PixelRGB r g b) = character
    where
        red =  r * 255 :: Double
        green =  g * 255 :: Double
        blue =  b * 255 :: Double
        i = floor $ (0.2126 * red + 0.7152 * green + 0.0722 * blue) * brightnessWeight :: Int
        character = [asciiCharactersMap !! i]

convertToAscii :: Image VS RGB Double -> Config -> IO String
convertToAscii img config = do
    let pixelsVector = toVector img
    let pixelsList = toList pixelsVector :: [Pixel RGB Double]
    let converted = Data.List.map replacePixel pixelsList
    let withLineBreaks = insertAtN (imageWidth config) "\n" converted
    return $ concat withLineBreaks
 
-- Function to insert a character at every Nth position in a list
insertAtN :: Int -> a -> [a] -> [a]
insertAtN 0 _ xs = xs
insertAtN _ _ [] = []
insertAtN n y xs
 | length xs < n = xs
 | otherwise = take n xs ++ [y] ++ insertAtN n y (drop n xs)