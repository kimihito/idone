class Users::SecuritiesController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    edit_users_security_path
  end

  def update_resource(resource, params)
    binding.pry
    resource.update_without_password(params)
  end
end