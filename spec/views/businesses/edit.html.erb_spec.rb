require 'rails_helper'

RSpec.describe "businesses/edit", type: :view do
  before(:each) do
    @business = assign(:business, Business.create!(
      name: "MyString",
      registration_number: "MyString",
      business_type: 1,
      owner_name: "MyString",
      father_name: "MyString",
      mobile: "MyString",
      address: "MyString"
    ))
  end

  it "renders the edit business form" do
    render

    assert_select "form[action=?][method=?]", business_path(@business), "post" do

      assert_select "input[name=?]", "business[name]"

      assert_select "input[name=?]", "business[registration_number]"

      assert_select "input[name=?]", "business[business_type]"

      assert_select "input[name=?]", "business[owner_name]"

      assert_select "input[name=?]", "business[father_name]"

      assert_select "input[name=?]", "business[mobile]"

      assert_select "input[name=?]", "business[address]"
    end
  end
end
