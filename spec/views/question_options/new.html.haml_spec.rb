require 'spec_helper'

describe "question_options/new.html.haml" do
  before(:each) do
    assign(:question_option, stub_model(QuestionOption,
      :question_id => 1,
      :title => ""
    ).as_new_record)
  end

  it "renders new question_option form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => question_options_path, :method => "post" do
      assert_select "input#question_option_question_id", :name => "question_option[question_id]"
      assert_select "input#question_option_title", :name => "question_option[title]"
    end
  end
end
