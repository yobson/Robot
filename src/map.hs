module Mapping 
(

)
where

mapWidth = 3
mapHeight = 3

numMap = [0..(mapWidth * mapHeight -1)]

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

getNextCells :: [a] -> Coord -> [Coord]
getNextCells v (x,y) = [n | n <- a++b++c++d]
    where get :: [a] -> Coord -> [Coord]
          get vec (xx,yy)
            | xx >= mapWidth = []
            | yy >= mapWidth = []
            | otherwise = [(xx,yy)]
          a = get v (x-1,y)
          b = get v (x,y-1)
          c = get v (x+1,y)
          d = get v (x,y+1)

replaceNth :: [a] -> Int -> a -> [a]
replaceNth (x:xs) 0 val = val:xs
replaceNth (x:xs) n val = x : replaceNth xs (n-1) val

trans :: [Int] -> [Int] -> [Int]
trans acc [] = reverse acc
trans acc (x:xs) = trans (x : acc) (xs ++ (filter (\el -> (el `elem` acc) /= True) $ xs ++ (map coordToIndex (gnc x))))
    where gnc = (getNextCells numMap) . indexToCoord

orderForSort :: [a] -> Coord -> [a]
orderForSort m c = [m !! n | n <- trans [] [(coordToIndex c)]]

--costCalc :: [Vector] -> Coord -> Vector
