require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  setup do
    @cat=cats(:one)
    @blog=blogs(:one)
  end

  test "pre handle" do
    title="i like ruby"
    content_md=%{#why
1. ruby is amazing
2. ruby is interesting
3. rails is quick
}
    content=Kramdown::Document.new(content_md).to_html
    blog=Blog.new(:title=>title,:content_md=>content_md)
    blog.pre_handle
    assert_equal title,blog.seo_title
    assert_equal title,blog.seo_keyword
    assert_equal title,blog.seo_desc
    #assert_equal content_md,blog.intro
    assert_equal content,blog.content
  end

  test "blog count" do
    assert_equal 1,Blog.blog_count(@cat.id)
  end

  test "comment count" do
    assert_equal 2,@blog.comment_count
  end
end
