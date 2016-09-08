module Docgen.Types where
import Data.Text.Lazy
import Data.Dates

-- | Data to be scraped from a listing
data Listing = Listing
  { listingAddress         :: Text
  , listingPricePerWeek    :: Int
  , listingAvailableMoveIn :: DateTime
  , listingSellingPoints   :: [Text]
  , listingDescription     :: Text
  
  -- , listingPhotos          :: String
  -- , listingFloorPlan       :: String
  -- , listingMap             :: String
  } deriving (Show, Eq)