require 'spec_helper'

describe "questions/show.html.haml" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :survey_id => 1,
      :title => "Title",
      :type => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
