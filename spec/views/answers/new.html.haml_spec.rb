require 'spec_helper'

describe "answers/new.html.haml" do
  before(:each) do
    assign(:answer, stub_model(Answer,
      :question_id => 1,
      :title => ""
    ).as_new_record)
  end

  it "renders new answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path, :method => "post" do
      assert_select "input#answer_question_id", :name => "answer[question_id]"
      assert_select "input#answer_title", :name => "answer[title]"
    end
  end
end
