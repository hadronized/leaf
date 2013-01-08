module HTMLElements where

type Title = String
type HRef = String
type Src = String
type Alt = String

-- HTML tag
data Tag
  = HTML String              -- <html ...>...</html>
  | Head [Tag]              -- <head>...</head>
  | Meta String String       -- <meta ... ... />
  | Link HRef String String  -- <link href=... style=... rel=... />
  | HeadTitle String         -- <title>...</title>
  | Body [Tag]               -- <body>...</body>
  | Paragraph String         -- <p>...</p>
  | Header Int Title         -- <hN>...</hN>
  | Anchor HRef String       -- <a href=...>...</a>
  | Image Src Alt            -- <img src=... alt=... />
  | ListItem Tag             -- <li>...</li>
  | UnorderedList [Tag] -- <ul>...</ul>
  | Div [Tag]                -- <div>...</div>

instance Show Tag where
  show t = case t of
    HTML s          -> "<html>" ++ s ++ "</html>"
    Head tags       -> "<head>" ++ show tags ++ "</head>"
    Meta he content -> "<meta http-equiv=\"" ++ he ++ "\" content=\"" ++ content ++ "\"/>"
    Link h s r      -> "<link href=\"" ++ h ++ "\" style=\"" ++ s ++ "\" rel=\"" ++ r ++ "\"/>"
    HeadTitle title -> "<title>" ++ title ++ "</title>"
    Body body       -> "<body>" ++ show body ++ "</body>"
    Paragraph p     -> "<p>" ++ p ++ "</p>"
    Header lvl h    -> let hn = "h" ++ show lvl ++ ">" in "<" ++ hn ++ h ++ "</" ++ hn
    Anchor href l   -> "<a href=\"" ++ href ++ "\">" ++ l ++ "</a>"
    Image src alt   -> "<img src=\"" ++ src ++ "\" alt=\"" ++ alt ++ "\"/>"
    ListItem t      -> "<li>" ++ show t ++ "</li>"
    UnorderedList i -> "<ul>" ++ concat (map show i) ++ "</ul>"
    Div tags        -> "<div>" ++ concat (map show tags) ++ "</div>"

-- create a headerN
header1,header2,header3,header4 :: String -> Tag
header1 = Header 1
header2 = Header 2
header3 = Header 3
header4 = Header 4

-- append a tag in a div
appendToDiv :: Tag -> Tag -> Tag
appendToDiv (Div [])   t = Div [t]
appendToDiv (Div bloc) t = Div (t:bloc)
appendToDiv _          _ = error "the left parameter must be constructed by Div"
