# Flowsnake

Some code for calculating, and drawing the [Gosper Curve](https://en.wikipedia.org/wiki/Gosper_curve) (or “Flowsnake”) in Haskell. This code was developed as a [Haskell for Mac](http://haskellformac.com) playground, though almost all the code is in Haskell source files which could be used in standalone code. Hopefully it's reasonably comprehensible (if probably not optimally elegant).

In this code, the Gosper curve is internally represented as a 3-dimensional object, which is collapsed to 2D using an isometric projection. This produces the same image as the traditional L-system implementation, involving 60º rotations in a 2D plane, but has the advantage of an intermediate format that is more usable for pattern-generating applications (my motivation to look into space-filling curves came from [Herman Haverkort's research into their musical applications](http://www.win.tue.nl/~hermanh/doku.php?id=sound_of_space-filling_curves)).

This code depends on the `Graphics.Rasterific` and `Codec.Picture` raster-image rendering libraries to make its images. These ship with Haskell for Mac, but otherwise may be added using Cabal/Stack. Making this application build as a standalone command-line app is left as an exercise for the reader.
