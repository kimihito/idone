class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication, :only => [:edit, :update]

  # we need to override the update, too.
  # After a password is reset, all outstanding sessions are gone.
  # When already logged in, sign_in is a no op, so the session will expire, too.
  # The solution is to logout and then re-login which will make the session right.
  def update
    super
    if resource.errors.empty?
      sign_out(resource_name)
      sign_in(resource_name, resource)
    end
  end
end