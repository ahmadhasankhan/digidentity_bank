class Property < ApplicationRecord
  has_many_attached :uploads, dependent: :destroy
  has_many_attached :property_docs, dependent: :destroy
  has_many :bids, dependent: :destroy

  enum status: {
    available: 0,
    bid_accepted: 1,
    sold: 2,
    rejected: 3
  }

  enum property_type: {
    land: 0,
    house: 1,
    villa: 2,
    flat: 3
  }

  enum nature_of_property: {
    agriculture: 0,
    commercial: 1,
    residential: 2,
    other: 3
  }

  def price_in_lakhs
    price / 100000
  end

  def check_highest_bid
    highest_bid = self.bids.order("amount DESC").first.amount rescue 0
    #self.current_bid = highest_bid
    #save
  end
end
