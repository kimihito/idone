class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include PublicActivity::StoreController

  include Pagy::Backend

  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :icon, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
