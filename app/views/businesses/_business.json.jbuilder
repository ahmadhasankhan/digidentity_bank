json.extract! business, :id, :name, :registration_number, :business_type, :owner_name, :father_name, :mobile, :address, :created_at, :updated_at
json.url business_url(business, format: :json)
