module Leaf.String (
  strip
  ) where

import Data.List (dropWhileEnd)

strip :: String -> String
strip = dropWhile pred . dropWhileEnd pred
  where pred = (==' ')
