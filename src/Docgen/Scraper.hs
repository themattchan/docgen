{-# LANGUAGE OverloadedStrings #-}

module Docgen.Scraper where

import Control.Applicative
import Control.Monad
import Control.Monad.Morph

import Control.Monad.Trans.Resource (runResourceT)
import Data.Conduit (($$+-))
import Network.HTTP.Conduit
import Network.HTTP.Conduit.Browser
import Text.HTML.DOM (sinkDoc)
import Text.XML (Document)
import Text.XML.Cursor
import qualified Data.Text.Lazy.IO as TLIO
import qualified Data.Text.Lazy.Encoding as TLE

import Docgen.Types

testUrl = "http://www.rightmove.co.uk/property-to-rent/property-56012182.html"

-- TODO: choose random user agent from a list
userAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"


-- step 1: grab the nodes we want
   -- GUI phase 1: select tags from site source
   -- GUI phase 2: select tags by clicking on rendered html page

-- step 2: turn html nodes -> [Pandoc] nodes
   -- avoid using readHtml to re-parse.

-- step 3: layout pandoc nodes according to some stylesheet
   -- GUI: drag 'n drop thing to compose the nodes

-- step 4: generate pdf

-- BATCH MODE: for each site to mine define a set of nodes to extract (see step 1)
       -- map this over a set of pages for each site
   -- GUI: list extractable sites, allow for selecting pages, then run in batch
   -- and make a zip file with everything

-- TODO: use conduit all the way through?
getPage :: String -> Manager -> IO Document
getPage url manager = do
  runResourceT $ browse manager $ do
    setDefaultHeader "User-Agent" (Just userAgent)
    request <- lift $ parseRequest url
    body <- responseBody <$> makeRequest request
    (hoist lift body) $$+- sinkDoc

runTest = newManager tlsManagerSettings >>= getPage testUrl


