require 'rails_helper'

RSpec.describe "properties/new", type: :view do
  before(:each) do
    assign(:property, Property.new(
      title: "MyString",
      price: 1.5,
      address: "MyText",
      total_area: 1.5,
      status: 1,
      lat: 1.5,
      long: 1.5
    ))
  end

  it "renders new property form" do
    render

    assert_select "form[action=?][method=?]", properties_path, "post" do

      assert_select "input[name=?]", "property[title]"

      assert_select "input[name=?]", "property[price]"

      assert_select "textarea[name=?]", "property[address]"

      assert_select "input[name=?]", "property[total_area]"

      assert_select "input[name=?]", "property[status]"

      assert_select "input[name=?]", "property[lat]"

      assert_select "input[name=?]", "property[long]"
    end
  end
end
