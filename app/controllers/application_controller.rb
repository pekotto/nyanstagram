class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?


	def after_sign_up_path_for(resource)
    	if customer_signed_in?
      	  posts_path
      	elsif admin_signed_in?
      	  admin_users_path
      	end
	end

	def after_sign_in_path_for(resource)
      if admin_signed_in?
          admin_posts_path
        elsif user_signed_in?
          posts_path
      end
	end

	def after_sign_out_path_for(resource_or_scope)
		if resource_or_scope == :admin
      	 new_admin_session_path
    	else
         root_path
        end
	end


protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:user_name, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :introduction, :plofile_image, :favorite_breed])
    end

end
