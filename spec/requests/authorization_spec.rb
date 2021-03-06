require 'spec_helper'

describe "Authorization Integration Test", integration: true do
  
  describe "Request a page without authorization" do
    it "should restrict access to settings page" do
      visit '/settings'
      expect(page).to have_button 'Login'
    end
  end

  describe "Log in process" do
    include_context 'login'

    it 'should restrict access when wrong credentials' do
      visit root_path
      expect(page).to have_button 'Login'
      fill_in 'name',     :with => 'some name'
      fill_in 'password', :with => 'some password'
      click_button 'Login'
      expect(page).to have_content 'Invalid user/password combination'
    end

    it 'should grant access and log off' do
      @user = FactoryGirl.create(:admin)
      login(@user)
      #page.save_page
      expect(page).to have_content "Welcome, #{@user.name}"
      click_link 'Logout'
      expect(page).to have_content "Logged out"
    end
  end


end
