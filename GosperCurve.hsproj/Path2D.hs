module Path2D
where
  
import GosperCurve
import Graphics.Rasterific

--- Utilities for processing Rasterific paths of V2 Float, and converting 3D paths to them

isometricFlatten :: [Pos] -> [V2 Float]
isometricFlatten path = map fn path
  where 
    sin60 = sin $ pi / 3
    cos60 = cos $ pi / 3
    fn (Pos a b c) = V2 x y
      where
        x = fromIntegral (a - c) * sin60
        y = fromIntegral (a + c) * cos60 + fromIntegral b
---

-- Utility methods for manipulating Rasterific vectors/polylines

-- v2zip :: (Int -> Int -> Int) -> Pos -> Pos -> Pos
v2zip f (V2 a b) (V2 c d) = V2 (f a c) (f b d) 

-- scale a polyline to fit in a (0,0)-(w,h) rectangle

scalePolyline :: Float -> Float -> [V2 Float] -> [V2 Float]
scalePolyline w h poly@(x:xs) = map scaler poly
  where 
    vmin = foldl1 (v2zip min) poly
    vmax = foldl1 (v2zip max) poly
    vext = v2zip (-) vmax vmin
    sc = foldr1 min $ v2zip (/) (V2 w h) vext
    scaler v = fmap (* sc) (v2zip (-) v vmin) 
    

