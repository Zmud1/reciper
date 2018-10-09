class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception

  def hello
    render html: "hello, world!"
    link_to 'About', about_path
  end
    
end
