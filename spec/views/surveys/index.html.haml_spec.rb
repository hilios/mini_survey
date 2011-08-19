require 'spec_helper'

describe "surveys/index.html.haml" do
  before(:each) do
    assign(:surveys, [
      stub_model(Survey,
        :user_id => 1,
        :title => "Title",
        :private => false
      ),
      stub_model(Survey,
        :user_id => 1,
        :title => "Title",
        :private => false
      )
    ])
  end

  it "renders a list of surveys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
