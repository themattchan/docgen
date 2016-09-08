module Docgen.Types where

-- | Data to be scraped from a listing
data Listing = Listing
  { listingAddress         :: String
  , listingPricePerWeek    :: Int
  , listingAvailableMoveIn :: Int
  , listingSellingPoints   :: [String]
  , listingDescription     :: String
  
  , listingPhotos          :: String
  , listingFloorPlan       :: String
  , listingMap             :: String
  } deriving (Show, Eq)