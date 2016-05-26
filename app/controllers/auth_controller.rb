class AuthController < ApplicationController
  skip_before_filter :check_login
  layout false

  #login page
  def new

  end

  #login action
  def create
    user=UserInfo.check(params[:user_name],params[:password])
    if not user.msg.present?
      session[:user_id]=user.id
      redirect_to new_blog_url
    else
      redirect_to login_url,:notice => user.msg
    end
  end

  #logout
  def destroy
    session[:user_id]=nil
    redirect_to login_url
  end

end
