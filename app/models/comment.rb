class Comment < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :content
  validates_presence_of :blog_id

  belongs_to :blog

  attr_accessor :created_at_text

  def Comment.count_under_blog(blog_id)
    return count(:conditions => ["blog_id=#{blog_id}"])
  end

  def Comment.comment_list(blog_id)
    return select('email,content,created_at').where('blog_id=?',[blog_id]).order('id desc').all
  end
  def Comment.comment_list_ajax(blog_id)
    comments=comment_list(blog_id)
    arr=[]
    comments.each do |c|
      arr<< {
          :email=>c.email,
          :content=>c.content,
          :created_at=>ActionController::Base.helpers.l(c.created_at)
      }
    end
    return arr.to_json
  end
end
