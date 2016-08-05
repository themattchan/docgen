module Docgen.Scraper where

import Control.Monad.Trans.Resource (runResourceT)
import Data.Conduit (($$+-))
import Network.HTTP.Conduit (conduitManagerSettings, http, newManager, parseUrl, responseBody)
import Text.HTML.DOM (sinkDoc)
import Text.XML (Document)
