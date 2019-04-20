require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:keith)
  end
  
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "invalid@",
                                              password:               "wha",
                                              password_confirmation:  "bar" } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation ul li', count: 4
  end
end
