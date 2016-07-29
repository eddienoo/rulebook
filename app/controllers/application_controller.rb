class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :sidebar
  before_action :require_login
  
  def sidebar
    @cat = Category.all.order("name ASC")
    @com = Committee.all.order("name ASC")
  end  

  
end
