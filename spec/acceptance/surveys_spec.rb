require 'spec_helper'

feature "Surveys", %q{

} do
  background do
    @user = FactoryGirl.create(:user)
    @survey = FactoryGirl.create(:survey, :user => @user)
    FactoryGirl.create_list(:question, 5, :survey => @survey).each do |question|
      FactoryGirl.create_list(:choice, 5, :question => question)
    end
  end
  
  def sign_in(user = @user)
    Capybara.reset_sessions!
    visit root_path
    fill_in 'user[email]',     :with => user.email
    fill_in 'user[password]',  :with => user.password
    find(:xpath, "//form[@id='new_session']//input[@type='submit']").click
    user
  end
  
  def submit_button
    find(:xpath, "//form//input[@type='submit']")
  end
  
  scenario "An anonymous user shouldn't access any survey" do
    visit new_survey_path
    current_path.should == root_path
  end
  
  scenario "An user can create a survey" do
    sign_in
    visit new_survey_path
    current_path.should == new_survey_path
    fill_in 'survey[title]', :with => "Foo my bar"
    2.times do |i|
      fill_in "survey[questions_attributes][#{i}][title]", :with => "Foo #{i}"
      2.times do |j|
        fill_in "survey[questions_attributes][#{i}][choices_attributes][#{j}][title]", :with => "Bar #{j}"
      end
    end
    submit_button.click
    current_path.should == survey_path(Survey.order('id DESC').first)
    page.should have_content("Foo my bar")
    2.times do |i|
      page.should have_content("Foo #{i}")
      2.times do |j|
        page.should have_content("Bar #{j}")
      end
    end
  end
  
  scenario "An user can edit his own survey" do
    sign_in
    visit edit_survey_path(@survey)
    current_path.should == edit_survey_path(@survey)
    fill_in 'survey[title]', :with => "Foo my bar"
    submit_button.click
    current_path.should == survey_path(@survey)
    page.should have_content("Foo my bar")
  end
  
  scenario "An user can't edit otherelses survey" do
    other_user = FactoryGirl.create(:user)
    sign_in other_user
    visit edit_survey_path(@survey)
    current_path.should == user_path(other_user)
    page.should have_css('p.flash')
    page.should have_css('p.warning')
  end
  
  scenario "An user can't see a private survey if not his own" do
    other_user = FactoryGirl.create(:user)
    private_survey = FactoryGirl.create(:private_survey, :user => other_user)
    sign_in
    visit survey_path(private_survey)
    current_path.should == user_path(@user)
    page.should have_css('p.flash')
    page.should have_css('p.warning')
    # Access his own private survey
    sign_in other_user
    visit survey_path(private_survey)
    current_path.should == survey_path(private_survey)
  end
  
  scenario "Any user can see and answer a public survey" do
    sign_in FactoryGirl.create(:user)
    visit survey_path(@survey)
    current_path.should == survey_path(@survey)
    # Check the content of the page
    page.should have_content(@survey.title)
    @survey.questions.each do |question|
      page.should have_content(question.title)
      question.choices.each do |choice|
        page.should have_content(choice.title)
      end
    end
  end
  
  scenario "After answers a survey user should see his answers" do
    sign_in
    visit survey_path(@survey)
    # Check the content of the page
    page.should have_content(@survey.title)
    @survey.questions.each do |question|
      random_choice = question.choices[rand(question.choices.size)]
      choose("answers_question_#{question.id}_#{random_choice.id}")
    end
    submit_button.click
    current_path.should == survey_answers_path(@survey)
  end
end