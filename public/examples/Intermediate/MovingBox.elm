areaSize = 400
squareSize = 40

desired = 50
timestep = fps desired

delta = let bothZero (x,y) = x == 0 && y == 0
            scale s {x,y} = (x*s/10, 0-y*s/10)
            scaledDir = lift2 scale timestep Keyboard.arrows
        in  dropIf bothZero (0,0) $ sampleOn timestep scaledDir

position = let add (a,b) (c,d) = (a+c, b+d)
           in  foldp add (0,0) delta


-- Display moving square and FPS on screen.
screen pos actual =
  flow down [ collage areaSize areaSize
                [ outlined grey (rect areaSize areaSize (areaSize/2,areaSize/2))
                , outlined black (rect squareSize squareSize pos) ]
            , plainText "Move the square around with the arrow keys."
            , plainText $ "Actual frames per second: " ++ show actual
            , plainText $ "Desired frames per second: " ++ show desired
            ]

averageFPS = lift (truncate . (/) second) (average 40 timestep)

main = lift2 screen position averageFPS
