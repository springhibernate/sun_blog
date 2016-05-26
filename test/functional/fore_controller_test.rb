require 'test_helper'

class ForeControllerTest < ActionController::TestCase
  setup do
    @blog=blogs(:one)
    @comment=comments(:one)
    comments_size
  end

  test "should get index" do
    get :blog_list
    assert_response :success
    assert_not_nil assigns(:blogs)
    assert_select ".blog-post" do
      puts "blog.title: #{@blog.title}"
      assert_select ".blog-post-title a",@blog.title
      assert_select ".blog-post-intro",@blog.intro
    end
  end

  test "should get detail" do
    assert_equal 0,@blog.read_count

    get :blog_detail,{:id=>@blog.id}
    assert_response :success
    assert_not_nil assigns(:blog)

    assert_equal 1,assigns(:blog).read_count
    assert_select ".blog-post" do
      assert_select "h2",@blog.title
      assert_select "#blog-post-content",@blog.content
    end
  end

  def show_body
    puts "---------------------"
    puts @response.body
    puts "---------------------"
  end

  def comments_size
    puts "comments' size is:#{@blog.comments.size}"
  end

  test "get comment list via ajax" do
    comments_size
    xhr :get,:comment_list,{:blog_id=>@blog.id}
    assert_response :success
    show_body
=begin
    assert_select_jquery :html,".cmt-list" do
      assert_select ".cmt-one .cmt-author",@comment.email
      assert_select ".cmt-one .cmt-content",@comment.content
    end
=end
    assert_match Regexp.new('<span class="cmt-author">'+@comment.email+'<\/span>'),@response.body
    assert_match Regexp.new('<div class="cmt-content">'+@comment.content+'<\/div>'),@response.body
  end

  test "post a comment via ajax" do
    comment2=Comment.new(:blog_id=>@blog.id,:email=>"test@google.com",:content=>"ruby also use in test")
    xhr :post,:comment_create,{:blog_id=>comment2.blog_id,:email=>comment2.email,:content=>comment2.content}
    assert_response :success
    show_body
=begin
    assert_select_jquery :prepend,".cmt-list" do
      assert_select ".cmt-author",comment2.email
      assert_select ".cmt-content",comment2.content
    end
=end
    assert_match Regexp.new('<span class="cmt-author">'+comment2.email+'<\/span>'),@response.body
    assert_match Regexp.new('<div class="cmt-content">'+comment2.content+'<\/div>'),@response.body
  end
end
