require 'spec_helper'

feature "Users", %q{
  In other to use the app an user can register themselves, and update their profile any time they want.
  They can see others users profiles.
  But they can't edit, update or delete other user profile.
} do
  background do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create_list(:survey, 5, :user => @user)
    FactoryGirl.create_list(:watch, 5, :user => @user)
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
  
  scenario "can register themselves and on complete redirect his profile page" do
    visit new_user_path
    current_path.should == new_user_path
    page.has_xpath?("//form[@action='#{users_path}']")
    fill_in 'user[name]',                   :with => 'Foo Bar'
    fill_in 'user[email]',                  :with => 'foo@bar.com'
    fill_in 'user[password]',               :with => '1234'
    fill_in 'user[password_confirmation]',  :with => '1234'
    attach_file 'user[avatar]', "#{Rails.root}/spec/support/fixtures/horizontal.jpg"
    submit_button.click
    current_path.should == user_path(User.find_by_email 'foo@bar.com')
  end
  
  scenario "non registered should provide a password" do
    visit new_user_path
    fill_in 'user[name]',                   :with => 'Foo Bar'
    fill_in 'user[email]',                  :with => 'foo@bar.com'
    submit_button.click
    current_path.should == users_path
    page.has_css?('p.error_notification')
  end
  
  scenario "non authenticated shouldn't access anybody profile page" do
    visit user_path(@user)
    current_path.should == root_path
  end
  
  scenario "see on his profile an edit link, an include survey link, all his surveys and wathed surveys" do
    sign_in
    visit user_path(@user)
    current_path.should == user_path(@user)
    page.should have_xpath("//a[@href='#{edit_user_path(@user)}']")
    page.should have_xpath("//a[@href='#{new_survey_path}']")
    page.should have_xpath("//a[@data-method='delete']")
    @user.surveys.each do |survey|
      page.should have_content(survey.title)
      page.should have_xpath("//a[@href='#{survey_path(survey)}']")
    end
    @user.surveys_watched.each do |survey|
      page.should have_content(survey.title)
      page.should have_xpath("//a[@href='#{survey_path(survey)}']")
    end
  end
  
  scenario "authenticated could view anybody profile page but can't edit, update or destroy" do
    other_user = FactoryGirl.create(:user)
    sign_in other_user
    visit user_path(@user)
    current_path.should == user_path(@user)
    page.should have_no_xpath("//a[@href='#{edit_user_path(@user)}']")
    page.should have_no_xpath("//a[@href='#{new_survey_path}']")
    page.should have_no_xpath("//a[@data-method='delete']")
    visit edit_user_path(@user)
    current_path.should == user_path(other_user)
    page.should have_css('p.flash')
    page.should have_css('p.warning')
  end
  
  scenario "authenticated user could update their profiles" do
    sign_in
    visit edit_user_path(@user)
    page.should have_xpath("//form[@action='#{user_path(@user)}']")
    fill_in 'user[name]',   :with => 'Foo Bar'
    submit_button.click
    current_path.should == user_path(@user)
      page.should have_css('p.flash')
      page.should have_css('p.notice')
  end
end