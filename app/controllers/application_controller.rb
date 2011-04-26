class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller 

  helper :all
  protect_from_forgery

  def ensure_authenticated
	if current_facebook_user.nil?
           redirect_to url_for(:controller=>'login')
        else
           User.find_or_create_by_facebook_id(current_facebook_user.id)
	end
  end

end
