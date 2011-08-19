require 'spec_helper'

describe "surveys/new.html.haml" do
  before(:each) do
    assign(:survey, stub_model(Survey,
      :user_id => 1,
      :title => "MyString",
      :private => false
    ).as_new_record)
  end

  it "renders new survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path, :method => "post" do
      assert_select "input#survey_user_id", :name => "survey[user_id]"
      assert_select "input#survey_title", :name => "survey[title]"
      assert_select "input#survey_private", :name => "survey[private]"
    end
  end
end
