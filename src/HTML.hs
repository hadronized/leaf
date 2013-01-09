module HTML where

import Data.List (intersperse)

type Title = String
type HRef = String
type Src = String
type Alt = String

-- HTML tag
data Tag
  = HTML                     -- <html>...</html>
  | Head                     -- <head>...</head>
  | Meta String String       -- <meta http-equiv=... content=... />
  | Link HRef String String  -- <link href=... style=... rel=... />
  | HeadTitle String         -- <title>...</title>
  | Body                     -- <body>...</body>
  | Paragraph String         -- <p>...</p>
  | Header Int Title         -- <hN>...</hN>
  | Anchor HRef String       -- <a href=...>...</a>
  | Image Src Alt            -- <img src=... alt=... />
  | ListItem                 -- <li>...</li>
  | UnorderedList            -- <ul>...</ul>
  | Div                      -- <div>...</div>

-- deferred show of tags, needs 2 strings to actually show it; the first string
-- is inserted in the open tag, just after the name, for instance:
--   <p insertedHere>
-- the second one is inserted between the open and closed version of the tag, if
-- the tag takes no argument, and is used to show DOM tree:
--   <li class=.red>insertedHere</li>
defShow :: Tag -> String -> String -> String
defShow t inner content =
  case t of
    HTML            -> easy "html"
    Head            -> easy "head"
    Meta mhe mc     -> "<meta http-equiv=\"" ++ mhe ++ "\" content=\"" ++ mc ++ "\" " ++ inner ++ "/>"
    Link href s rel -> "<link href=\"" ++ href ++ "\" style=\"" ++ s ++ "\" rel=\"" ++ rel ++ "\" " ++ inner ++ "/>"
    HeadTitle title -> "<title " ++ inner ++ ">" ++ title ++ "</title>"
    Body            -> easy "body"
    Paragraph p     -> "<p " ++ inner ++ ">" ++ p ++ "</p>"
    Header n h      -> let showN = show n in "<h" ++ showN ++ " " ++ inner ++ ">" ++ h ++ "</h" ++ showN ++ ">"
    Anchor href l   -> "<a href=\"" ++ href ++ "\" " ++ inner ++ ">" ++ l ++ "</a>"
    Image src alt   -> "<img src=\"" ++ src ++ "\" alt=\"" ++ alt ++ "\" " ++ inner ++ "/>"
    ListItem        -> easy "li"
    UnorderedList   -> easy "ul"
    Div             -> easy "div"
  where easy tag = "<" ++ tag ++ " " ++ inner ++ ">" ++ content ++ "</" ++ tag ++ ">"

-- CSS selector
data Selector
  = ID String
  | Class String

instance Show Selector where
  show (ID s)    = "id=\"#" ++ s ++ "\""
  show (Class s) = "class=\"." ++ s ++ "\""

-- Document element
data Element = Element { getTag :: Tag, getSelectors :: [Selector], getChildren :: [Element] }

instance Show Element where
  show (Element t s ch) = defShow t sels content
    where sels = concat $ intersperse " " (map show s)
          content = concat (map show ch)

-- inject a tag in a brand new element
fromTag :: Tag -> Element
fromTag t = Element t [] []

-- add a style to an element
addStyle :: Element -> Selector -> Element
addStyle (Element t sels ch) s = Element t (sels++[s]) ch

-- add a child to an element
addChild :: Element -> Element -> Element
addChild (Element t s ch) e = Element t s (ch++[e])

type Page = Element