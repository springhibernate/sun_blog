#for the foreground
class ForeController < ApplicationController
  skip_before_filter :check_login
  layout 'fore'

  def index
    redirect_to :action => :blog_list
  end
  #list all the blog on index page
  def blog_list
    @blogs = Blog.paginate :page=>params[:page],:order=>"id desc",:per_page=>PER_PAGE
    respond_to do |format|
      format.html
      format.xml  { render :xml => @blogs }
    end
  end
  #show the detail of blog
  def blog_detail
    @blog=Blog.find(params[:id])
    #todo the same client only plus 1 though he read for many times
    @blog.plus_read_count
    @comment=Comment.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @blog }
    end
  end

  #post a comment via jquery ajax
  def comment_create
    @comment=Comment.new(:blog_id=>params[:blog_id],:email=>params[:email],:content=>params[:content])
    @comment.save
    #logger.info "errors:#{ActionController::Base.helpers.error_for_boostrap_style(@comment)}"
  end

  #list all comment on given blog via jquery ajax when show the detail of blog
  def comment_list
    #render :json => Comment.comment_list_ajax(params[:blog_id])
    @comments=Comment.comment_list(params[:blog_id])
  end
end
