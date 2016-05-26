class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_login
  before_filter :set_locale
  PER_PAGE=10#page size

  protected
  # check whether has logined
  def check_login
    if not session[:user_id]
      redirect_to login_url,:notice => 'you must login firstly'
    end
  end
  #fetch the locale from params,and set it
  def set_locale
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale=params[:locale]
      else
        flash.now[:notice]= "there is no such translate file:#{params[:locale]}.yml"
        logger.error flash.now[:notice]
      end
    end
  end
  #when there isn't locale in url,using this
  def default_url_options
    {:locale=>I18n.locale}
  end

end
