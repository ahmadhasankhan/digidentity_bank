class Business < ApplicationRecord
  has_many :transactions, dependent: :destroy

  enum business_type:{
    small_shop: 0,
    mill: 1,
    bhatta: 2,
    small_scale_factory: 3,
    mobile_tower: 4,
    bank_or_offices_or_nursing_home: 5,
    school_or_training_centre: 6,
    coaching_centre: 7,
    advertisement_hoardings: 8,
    marriage_registration: 9,
    land_map_approval: 10,
    pandit_qaazi: 11,
  }

  TAXES = {
    small_shop: 300,
    mill: 500,
    bhatta: 1200,
    small_scale_factory: 1200,
    mobile_tower: 800,
    bank_offices_nursing_home: 800,
    school_or_training_centre: 1200,
    coaching_centre: 500,
    advertisement_hoardings: 10000
  }

  REGISTRATION = {
    small_shops: 50,
    mills: 50,
    bhatta: 50,
    small_scale_factories: 100,
    mobile_tower: 100,
    bank_offices_nursing_home: 100,
    school_training_centre: 100,
    coaching_centre: 50,
    advertisement_hoardings: 100,
    marriage_registration: 100,
    land_map_approval: 1000,
    pandit_qaazi: 50
  }
  # Payment should be non editable
  before_create :assign_registration_no

  validates_presence_of :name, :owner_name, :father_name, :mobile, :address, :business_type

  private

  def assign_registration_no
    acc_no = generate_number

    while Business.where(registration_number: acc_no).any?
      acc_no = generate_number
    end

    self.registration_number = acc_no
  end

  def generate_number
    "CHP-#{rand.to_s[2..11]}"
  end
end
