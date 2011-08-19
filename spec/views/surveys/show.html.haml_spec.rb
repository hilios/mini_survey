require 'spec_helper'

describe "surveys/show.html.haml" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :user_id => 1,
      :title => "Title",
      :private => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
