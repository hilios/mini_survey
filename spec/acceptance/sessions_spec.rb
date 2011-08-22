require 'spec_helper'

feature "Sessions", %q{
  In order to navigate into application User must sign in or register theirself
} do
  background do
    @user = FactoryGirl.create(:user)
  end
  
  def submit_button
    find(:xpath, "//form[@id='new_session']//input[@type='submit']")
  end
  
  scenario "A registered user that will sign in" do
    visit root_path
    page.should have_xpath("//form[@action='#{sessions_path}']")
    fill_in 'user[email]',     :with => @user.email
    fill_in 'user[password]',  :with => @user.password
    submit_button.click
    current_path.should == user_path(@user)
  end
  
  scenario "An user that seeking out to register theirself" do
    visit root_path
    find(:xpath, "//a[@href='#{new_user_path}']").click
    current_path.should == new_user_path
  end
  
  scenario "An already signed in user should get redirects to his own page" do
    visit root_path
    fill_in 'user[email]',    :with => @user.email
    fill_in 'user[password]', :with => @user.password
    submit_button.click
    visit root_path
    current_path.should == user_path(@user)
  end
  
  scenario "An bad try to sign in should warn users" do
    visit root_path
    fill_in 'user[email]',    :with => 'foo@bar.com'
    fill_in 'user[password]', :with => 'bad'
    submit_button.click
    current_path.should == sessions_path
    page.should have_css('p.flash')
    page.should have_css('p.error')
  end
end