class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?


	def after_sign_up_path_for(resource)
    user_signed_in?
    if current_user.admin == true
          rails_admin_path
    else
          posts_path
    end
	end

	def after_sign_in_path_for(resource)
    user_signed_in?
    if current_user.admin == true
          rails_admin_path
    else
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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:user_name, :email, :favorite_breed_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :introduction, :plofile_image, :favorite_breed_id])
    end

end
