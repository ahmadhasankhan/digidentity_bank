require 'rails_helper'

RSpec.describe "properties/index", type: :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        title: "Title",
        price: 2.5,
        address: "MyText",
        total_area: 3.5,
        status: 4,
        lat: 5.5,
        long: 6.5
      ),
      Property.create!(
        title: "Title",
        price: 2.5,
        address: "MyText",
        total_area: 3.5,
        status: 4,
        lat: 5.5,
        long: 6.5
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.5.to_s, count: 2
    assert_select "tr>td", text: 6.5.to_s, count: 2
  end
end
