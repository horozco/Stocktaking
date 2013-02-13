class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.class != AdminUser
      inventories_path
    else
      admin_root_path
    end
  end
end
