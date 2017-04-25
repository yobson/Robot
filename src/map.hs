module Mapping 
(

)
where

mapWidth = 3
mapHeight = 3

data Vector = Cost Int Coord | Uncalculated | Impossible deriving (Show, Eq)
data Obsticle = Blocked | Clear deriving (Show, Eq)

instance Ord Vector where
    Cost n _ `compare` Cost g _ = n `compare` g
    Cost _ _ `compare` Impossible = 0 `compare` 1

type Coord = (Int, Int)

coordToIndex :: Coord -> Int
coordToIndex (x,y) = y * mapWidth + x

indexToCoord :: Int -> Coord
indexToCoord i = (x, y)
    where x = i `mod` mapWidth
          y = (i - x) `div` mapWidth

costV :: Vector -> Int
costV (Cost c _) = c

fromV :: Vector -> Coord
fromV (Cost _ f) = f

initVectorMap' :: Int -> Int -> Vector
initVectorMap' i start
    | i == start = Cost 0 (indexToCoord i)
    | otherwise = Uncalculated

initVectorMap :: Coord -> [Vector]
initVectorMap p = [initVectorMap' n i | n <- [0..(mapWidth * mapHeight)]]
    where i = coordToIndex p

applyObsticleMap :: [Obsticle] -> [Vector] -> [Vector]
applyObsticleMap _ [] = []
applyObsticleMap [] _ = []
applyObsticleMap (o:os) (v:vs)
    | o == Blocked = Impossible : applyObsticleMap os vs
    | otherwise = v : applyObsticleMap os vs

fullMapInit :: [Obsticle] -> Coord -> [Vector]
fullMapInit o = (applyObsticleMap o) . initVectorMap

costCalc :: [Vector] -> Coord -> [Vector]
costCalc v n = ([calc c n | c <- v])
    where calc (Impossible) _ = Impossible
          calc (Cost a b) _ = Cost a b
          calc Uncalculated (x,y) 
            | x >= mapWidth = Impossible
            | y >= mapHeight = Impossible
            | otherwise = min right down
            where right = costCalc v n !! (coordToIndex (x+1,y))
                  down  = costCalc v n !! (coordToIndex (x,y+1))