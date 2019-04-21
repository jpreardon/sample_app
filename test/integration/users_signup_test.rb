require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'Should not allow invalid signups' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                          email: 'user@invalid',
                                          password: 'foo',
                                          password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', 8
  end
  
  test 'Should allow valid signups' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: 'Example Guy',
                                          email: 'example@guy.com',
                                          password: 'password',
                                          password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'div.alert-info'
  end
end
