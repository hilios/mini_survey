require 'spec_helper'

describe "questions/new.html.haml" do
  before(:each) do
    assign(:question, stub_model(Question,
      :survey_id => 1,
      :title => "MyString",
      :type => 1
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_survey_id", :name => "question[survey_id]"
      assert_select "input#question_title", :name => "question[title]"
      assert_select "input#question_type", :name => "question[type]"
    end
  end
end
