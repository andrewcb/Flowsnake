module GosperCurve
where
  
data Step = A | B | L | R deriving (Eq, Show)

-- (x,y,z) coordinates mapped to an isometric hex grid, with x = /, y = |, z = \
-- We use this rather than Cartesian coordinates because the result is more useful as a list for generating patterns, as well as for drawing
data Pos = Pos Int Int Int deriving (Eq, Show)

pzip :: (Int -> Int -> Int) -> Pos -> Pos -> Pos
pzip f (Pos a b c) (Pos d e g) = Pos (f a d) (f b e) (f c g)

padd = pzip (+)

data Heading = N | NE | SE | S | SW | NW deriving ( Show, Eq, Enum )

data State = State Pos Heading deriving (Eq, Show)

position (State pos _) = pos


posIncr :: Heading -> Pos
posIncr N = Pos 0 1 0
posIncr NE = Pos 1 0 0
posIncr SE = Pos 0 0 (-1)
posIncr S = Pos 0 (-1) 0
posIncr SW = Pos (-1) 0 0
posIncr NW = Pos 0 0 1

-- rotations in position
turnLeft :: Heading -> Heading
turnLeft N = NW
turnLeft x = pred x

turnRight :: Heading -> Heading
turnRight NW = N
turnRight x = succ x

-- move the drawing state
move :: Step -> State -> (State, Maybe Pos)
move A (State pos hdg) = (State pos' hdg, Just pos') where pos' = (padd pos $ posIncr hdg)
move B (State pos hdg) = (State pos' hdg, Just pos') where pos' = (padd pos $ posIncr hdg)
move L (State pos hdg) = (State pos $ turnLeft hdg, Nothing)
move R (State pos hdg) = (State pos $ turnRight hdg, Nothing)

--------
-- The actual Gosper curve L-system rules

production :: Step -> [Step]
production A = [ A, R, B, R, R, B, L, A, L, L, A, A, L, B, R]
production B = [ L, A, R, B, B, R, R, B, R, A, L, L, A, L, B]
production x = [x]

-- run one iteration on the L-system

lsystem :: Int -> [Step] -> [Step]
lsystem 0 seq = seq
lsystem n seq = lsystem (n - 1) $ seq >>= production

--------
    
makePath :: [Step] -> [Pos]
makePath steps = reverse $ snd $ foldl pathNext ((State (Pos 0 0 0) N), [Pos 0 0 0]) steps
  where
    pathNext (state, path) step = let (state', mv) = move step state 
      in (state', case mv of
        Just pos' -> pos' : path
        Nothing -> path
      )
