require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  setup do
    @blog = blogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post :create, :blog =>{:title=>"ruby is use mainly in rails",
        :content_md=>@blog.content_md,
        :cat_id=>@blog.cat_id,
        :user_id=>@blog.user_id
      }
    end

    assert_redirected_to blogs_url
    assert_equal I18n.t("create_successfully"), flash[:notice]
  end

  test "should show blog" do
    get :show, :id => @blog.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @blog.to_param
    assert_response :success
  end

  test "should update blog" do
    put :update, :id => @blog.to_param, :blog => @blog.attributes
    assert_redirected_to blogs_url
    assert_equal I18n.t("update_successfully"), flash[:notice]
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete :destroy, :id => @blog.to_param
    end

    assert_redirected_to blogs_path
  end
end
