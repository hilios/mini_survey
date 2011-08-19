require 'spec_helper'

describe "answers/index.html.haml" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :question_id => 1,
        :title => ""
      ),
      stub_model(Answer,
        :question_id => 1,
        :title => ""
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
