require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:keith)
  end
  
  test 'layout links (logged out)' do
    # Home, Help, Login
    get root_path
    assert_template 'static_pages/home'
    assert_select 'nav a[href=?]', root_path
    assert_select 'nav a[href=?]', help_path
    assert_select 'nav a[href=?]', login_path
  end
  
  test 'layout links (logged in)' do
    # Home, Help, Users, Profile, Settings, Logout
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'nav a[href=?]', root_path
    assert_select 'nav a[href=?]', help_path
    assert_select 'nav a[href=?]', users_path
    assert_select 'nav a[href=?]', user_path(@user)
    assert_select 'nav a[href=?]', edit_user_path(@user)
    assert_select 'nav a[href=?]', logout_path
  end
  
  # Test common links on the home page (both logged in and logged out)
  test 'Common links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', 'http://news.railstutorial.org/'
  end
  
  test 'help page' do
    get help_path
    assert_select 'title', full_title('Help')
  end
  
  test 'about page' do
    get about_path
    assert_select 'title', full_title('About')
  end
  
  test 'contact page' do
    get contact_path
    assert_select 'title', full_title('Contact')
  end
  
  test 'signup page' do
    get signup_path
    assert_template 'users/new'
    assert_select 'title', full_title('Sign up')
  end
    
end
