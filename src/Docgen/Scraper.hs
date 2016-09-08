{-# LANGUAGE OverloadedStrings #-}
module Docgen.Scraper where

import Control.Monad.Trans.Resource (runResourceT)
import Data.Conduit (($$+-))
import Network.HTTP.Conduit
import Network.HTTP.Conduit.Browser
import Text.HTML.DOM (sinkDoc)
import Text.XML (Document)
import qualified Data.Text.Lazy.IO as TLIO
import qualified Data.Text.Lazy.Encoding as TLE

testUrl = "http://www.rightmove.co.uk/property-to-rent/property-56012182.html"

-- makeRequest :: String -> IO Document
-- makeRequest url = do
--   request <- parseRequest url
--   manager <- newManager tlsManagerSettings

--   runResourceT $ do
--     response <- http request manager
--     let body = responseBody response
--     body $$+- sinkDoc

main :: IO ()
main = do
  manager <- newManager tlsManagerSettings

  request <- parseRequest testUrl

  out <- runResourceT $ browse manager $ do
    setDefaultHeader "User-Agent" $ Just "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    makeRequestLbs request
  TLIO.putStrLn $ TLE.decodeUtf8 $ responseBody out
