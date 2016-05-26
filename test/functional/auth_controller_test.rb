require 'test_helper'

class AuthControllerTest < ActionController::TestCase

  def show_body
    puts "---------------------"
    puts @response.body
    puts "---------------------"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    user=user_infos(:one)
    puts "user.salt:#{user.salt}"
    post :create,{:user_name=>user.user_name,:password=>"123456"}
    assert_redirected_to new_blog_url
    assert_equal user.id,session[:user_id]
    show_body
  end

  test "should get destroy" do
    delete :destroy
    assert_redirected_to login_url
  end

end
