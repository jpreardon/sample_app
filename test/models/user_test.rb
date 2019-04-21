require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: 'Pat Castelli', 
                      email: 'pcastelli@alumni.westin.com',
                      password: 'junkmo',
                      password_confirmation: 'junkmo')
  end
  
  test 'should be valid' do
    assert @user.valid?
  end
  
  test 'name should be present' do
    @user.name = "    "
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = "    "
    assert_not @user.valid?
  end
  
  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end
  
  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end
  
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[frick@frack.com jj.walker99@dyno.mit.es son_of_asdf.lastname@fco.nyc.net.co.uk giz+mo@zing.blog]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid "
    end
  end
  
  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[fu zip,zap@example.com zip@zap user@example. bim.skala@bim+ska.net blam.blam@blam..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'email addresses should always be saved in lowercase' do
    mixed_case_email = 'StiCKY@finGe.RS'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end
