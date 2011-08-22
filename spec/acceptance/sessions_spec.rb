require 'spec_helper'

feature "Sessions", %q{
  In order to navigate into application
  User must sign in or register thenselves
} do
  background do
    @user = FactoryGirl.create(:user)
  end
  
  scenario "A registered user that will sign in" do
    visit '/'
    page.should have_selector("form#new_session[action='#{sessions_path}']")
    fill_in :email,     :with => @user.email
    fill_in :password,  :with => @user.password
    find("input[type='submit']").click
    current_path.should == user_path(@user)
  end
  
  scenario "An user that seeking out to register theirself" do
    visit '/'
    find("a[href='#{new_user_path}']").click
    current_path.should == new_user_path
  end
  
  scenario "An already signed in user should get redirects to his own page" do
    pending
  end
end