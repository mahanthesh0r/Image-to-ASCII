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

-- | Converts a pixel in the RGB color space to a single ASCII character
-- based on its luminance value.
replacePixel :: Pixel RGB Double -> String
replacePixel (PixelRGB r g b) = character
    where
        red =  r * 255 :: Double
        green =  g * 255 :: Double
        blue =  b * 255 :: Double
        i = floor $ (0.2126 * red + 0.7152 * green + 0.0722 * blue) * brightnessWeight :: Int
        character = [asciiCharactersMap !! i]

-- This takes an image and a configuration, converting the image to ASCII art.
-- It operates by first converting the image to a list of pixels, replacing each pixel with its corresponding ASCII character, and inserting line breaks according to the image width specified in the configuration.
-- Finally, it returns the ASCII representation of the image as a string.
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
