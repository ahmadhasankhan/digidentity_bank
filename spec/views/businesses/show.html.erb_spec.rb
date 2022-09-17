require 'rails_helper'

RSpec.describe "businesses/show", type: :view do
  before(:each) do
    @business = assign(:business, Business.create!(
      name: "Name",
      registration_number: "Registration Number",
      business_type: 2,
      owner_name: "Owner Name",
      father_name: "Father Name",
      mobile: "Mobile",
      address: "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Registration Number/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Owner Name/)
    expect(rendered).to match(/Father Name/)
    expect(rendered).to match(/Mobile/)
    expect(rendered).to match(/Address/)
  end
end
