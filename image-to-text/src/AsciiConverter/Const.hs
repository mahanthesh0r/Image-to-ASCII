module AsciiConverter.Const
    (
        asciiCharactersMap,
        maxBrightness,
        brightnessWeight
    ) where

-- ASCII characters to use for the conversion
asciiCharactersMap :: String
asciiCharactersMap = "`'.,^:;Il!i~+_-?][}{1)(|/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$"

-- Maximum brightness value
maxBrightness :: Int
maxBrightness = 255

-- Weight for brightness calculation
brightnessWeight :: Double
brightnessWeight = fromIntegral (length asciiCharactersMap) / fromIntegral maxBrightness