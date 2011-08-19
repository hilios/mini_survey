require 'spec_helper'

describe "question_options/edit.html.haml" do
  before(:each) do
    @question_option = assign(:question_option, stub_model(QuestionOption,
      :question_id => 1,
      :title => ""
    ))
  end

  it "renders the edit question_option form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => question_options_path(@question_option), :method => "post" do
      assert_select "input#question_option_question_id", :name => "question_option[question_id]"
      assert_select "input#question_option_title", :name => "question_option[title]"
    end
  end
end
