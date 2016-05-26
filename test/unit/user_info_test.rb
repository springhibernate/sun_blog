require 'test_helper'

class UserInfoTest < ActiveSupport::TestCase
  setup do
    @user=user_infos(:one)
    @rigt_password="123456"
    @wrong_password="123"

    @user3=user_infos(:three)
  end

  test "encrypt" do
    pass=UserInfo.encrypt("123456",@user.salt)
    assert_equal pass,@user.password
  end

  test "check no user" do
    user=UserInfo.check "bill gates","123456"
    assert_equal UserInfo::USER_NOT_EXIST,user.msg
  end

  test "check not available" do
    user=UserInfo.check @user3.user_name,@right_password
    assert_equal UserInfo::USER_NO_AVAILABLE,user.msg
  end

  test "check wrong password" do
    user=UserInfo.check @user.user_name,@wrong_password
    assert_equal UserInfo::USER_NOT_EXIST,user.msg
  end
end
