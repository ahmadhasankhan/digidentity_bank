require 'rails_helper'

RSpec.describe "businesses/index", type: :view do
  before(:each) do
    assign(:businesses, [
      Business.create!(
        name: "Name",
        registration_number: "Registration Number",
        business_type: 2,
        owner_name: "Owner Name",
        father_name: "Father Name",
        mobile: "Mobile",
        address: "Address"
      ),
      Business.create!(
        name: "Name",
        registration_number: "Registration Number",
        business_type: 2,
        owner_name: "Owner Name",
        father_name: "Father Name",
        mobile: "Mobile",
        address: "Address"
      )
    ])
  end

  it "renders a list of businesses" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Registration Number".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Owner Name".to_s, count: 2
    assert_select "tr>td", text: "Father Name".to_s, count: 2
    assert_select "tr>td", text: "Mobile".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
  end
end
