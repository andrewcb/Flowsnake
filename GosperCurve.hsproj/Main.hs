
import GosperCurve
import Path2D

import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Codec.Picture

makeImage :: [Pos] -> Int -> Int -> Image PixelRGBA8
makeImage path width height =  renderDrawing width height white $ 
  withTexture (uniformTexture black) $ do 
    stroke 1 JoinRound (CapRound, CapRound) $ polyline $ scalePolyline (fromIntegral width) (fromIntegral height) poly
  where
    poly = isometricFlatten path
    white = PixelRGBA8 255 255 255 255
    black = PixelRGBA8 0 0 0 255


main :: IO ()
main = do
  writePng "/tmp/gospercurve.png" $ makeImage (makePath $ lsystem 4 [A]) 700 700