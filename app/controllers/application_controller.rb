class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # TODO: Remove this crap
  def hello
    render html: "hi"
  end
end
