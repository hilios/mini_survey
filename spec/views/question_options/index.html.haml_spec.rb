require 'spec_helper'

describe "question_options/index.html.haml" do
  before(:each) do
    assign(:question_options, [
      stub_model(QuestionOption,
        :question_id => 1,
        :title => ""
      ),
      stub_model(QuestionOption,
        :question_id => 1,
        :title => ""
      )
    ])
  end

  it "renders a list of question_options" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
