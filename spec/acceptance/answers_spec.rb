require 'spec_helper'

feature "Answers" do
  background do
    @user = FactoryGirl.create(:user)
    @survey = FactoryGirl.create(:survey, :user => @user)
    FactoryGirl.create_list(:question, 5, :survey => @survey).each do |question|
      FactoryGirl.create_list(:choice, 5, :question => question)
    end
    @survey.questions.each do |question|
      random_choice = question.choices[rand(question.choices.size)]
      @user.update_attributes :answers_attributes => [{:choice => random_choice}]
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
  
  scenario "An anonymous user shouldn't access any survey answers" do
    visit survey_answers_path(@survey)
    current_path.should == root_path
    
    visit data_survey_answers_path(@survey)
    current_path.should == root_path
  end
  
  scenario "If user not owns the survey he can't view it's data" do
    other_user = FactoryGirl.create(:user)
    sign_in other_user
    visit data_survey_answers_path(@survey)
    current_path.should == user_path(other_user)
    page.should have_css('p.flash')
    page.should have_css('p.warning')
  end
  
  scenario "The owner of a survey can view his data" do
    sign_in
    visit data_survey_answers_path(@survey)
    current_path.should == data_survey_answers_path(@survey)
    page.should have_content(@survey.title)
    @survey.questions.each do |question|
      page.should have_content(question.title)
      question.choices.each do |choice|
        page.should have_content(choice.title)
      end
    end
  end
  
  scenario "Any user could view his answers for a survey" do
    sign_in
    visit survey_answers_path(@survey)
    current_path.should == survey_answers_path(@survey)
    page.should have_content(@survey.title)
    @user.answers.each do |aswers|
      page.should have_content(aswers.choice.title)
      page.should have_xpath("//input[@name='choice_#{aswers.choice.id}']")
    end
  end
end