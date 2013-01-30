import Control.Monad
import Data.Functor
import Data.List
import Data.List.Split
import System.Console.GetOpt
import System.Directory
import System.Environment
import System.FilePath
import System.IO
import Text.Blaze.Html
import Text.Blaze.Html.Renderer.String
import Text.Pandoc
import Wrapper

data CLIFlag
  = Init String
  | Bootstrap
  | Generate

usage :: IO ()
usage = putStrLn $ usageInfo "usage: leaf [OPTIONS]" cliOptions

cliOptions :: [OptDescr CLIFlag]
cliOptions =
  [ Option ['i'] ["init"]      (ReqArg Init "NAME") "create a new portfolio from scratch"
  , Option ['b'] ["bootstrap"] (NoArg Bootstrap)    "generate the content file you have to fulfil"
  , Option ['g'] ["generate"]  (NoArg Generate)     "generate the HTML version of the portfolio"
  ]

parseArgs :: [String] -> IO (Maybe [CLIFlag])
parseArgs args =
  case getOpt Permute cliOptions args of
    (o,[],[]) -> return $ Just o
    _         -> return Nothing

treatArgs :: CLIFlag -> IO ()
treatArgs flag =
  case flag of
    Init name -> initFromScratch name
    Bootstrap -> bootstrap
    Generate  -> generateHTML

initFromScratch :: String -> IO ()
initFromScratch name = do
  sequence_ $ (createDirectoryIfMissing True) <$> ((name </>) <$> ["leaf","www"])
  writeFile (name </> "leaf/wrapper.leaf") templateWrapperString
  writeFile (name </> "www/default.css") minimalCSSString
  putStrLn $ "initialised in ./" ++ name

-- get the items of the current porfolio
-- TODO: make it safer
getItems :: IO [String]
getItems = do
  content <- readFile "leaf/wrapper.leaf"
  return . map (dropWhile (==' ')) . splitWhen (==',') . join . drop 1 . splitWhen (==':') . join . filter (isPrefixOf "Items:") . lines $ content

bootstrap :: IO ()
bootstrap = do
  items <- getItems
  sequence_ $ flip appendFile "" . (\n -> "leaf" </> n ++ ".leafc") <$> items
  putStrLn "generated files, feel free to fulfil them!"

generateHTML :: IO ()
generateHTML = do
  wrapperContent <- readFile "leaf/wrapper.leaf"
  let helper = fromString wrapperContent
      name = prettyName (_wrapperFN helper,_wrapperLN helper,_wrapperNick helper)
      ownHeader = Wrapper.header name
      ownFooter = Wrapper.footer name (_wrapperYear helper) Nothing
      ownNavbar = navbar $ _wrapperItems helper
      ownWrapper = wrapper ownHeader ownFooter ownNavbar
  forM_ (_wrapperItems helper) $ \item -> do
    --let page = "www" </> item ++ ".html"
    content <- readFile $ "leaf" </> item ++ ".leafc"
    let doc    = readMarkdown def content
        output = writeHtml def doc
    writeFile ("www" </> item ++ ".html") $ renderHtml (ownWrapper item output)
  
main = do
  -- maybe get the options
  cliOpts <- getArgs >>= parseArgs
  case cliOpts of
    Nothing    -> usage
    Just flags -> sequence_ $ treatArgs <$> flags
