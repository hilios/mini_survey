require 'spec_helper'

describe "surveys/edit.html.haml" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :user_id => 1,
      :title => "MyString",
      :private => false
    ))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path(@survey), :method => "post" do
      assert_select "input#survey_user_id", :name => "survey[user_id]"
      assert_select "input#survey_title", :name => "survey[title]"
      assert_select "input#survey_private", :name => "survey[private]"
    end
  end
end
