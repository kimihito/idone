class Users::SecuritiesController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    edit_users_security_path
  end
end