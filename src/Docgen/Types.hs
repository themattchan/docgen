module Docgen.Types where
import Data.Text.Lazy
import Data.Dates
import Data.Monoid

-- | Data to be scraped from a listing
data Listing = Listing
  { listingAddress         :: First Text
  , listingPricePerWeek    :: First Int
  , listingAvailableMoveIn :: First DateTime
  , listingSellingPoints   :: First [Text]
  , listingDescription     :: First Text

  -- , listingPhotos          :: String
  -- , listingFloorPlan       :: String
  -- , listingMap             :: String
  } deriving (Show, Eq)

instance Monoid Listing where
  mempty = Listing mempty mempty mempty mempty mempty
  l1 `mappend` l2 = Listing
    { listingAddress          = listingAddress          l1 <> listingAddress          l2
    , listingPricePerWeek     = listingPricePerWeek     l1 <> listingPricePerWeek     l2
    , listingAvailableMoveIn  = listingAvailableMoveIn  l1 <> listingAvailableMoveIn  l2
    , listingSellingPoints    = listingSellingPoints    l1 <> listingSellingPoints    l2
    , listingDescription      = listingDescription      l1 <> listingDescription      l2
    }
