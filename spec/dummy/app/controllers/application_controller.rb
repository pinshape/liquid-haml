class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery :with => :exception

  def test; end
  def other_test
    render :file => Rails.root.join('app', 'views', 'application/other_test'), :locals => { :local => 'derp' }
  end
end
