require 'spec_helper'

describe "question_options/show.html.haml" do
  before(:each) do
    @question_option = assign(:question_option, stub_model(QuestionOption,
      :question_id => 1,
      :title => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
