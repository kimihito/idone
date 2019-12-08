class UserOptions::Update < ActiveInteraction::Base
  object :user_option
  string :email_privacy, default: nil

  validates :email_privacy, inclusion: { in: UserOption.email_privacies.keys }

  def execute
    user_option.email_privacy = email_privacy if email_privacy?
    unless user_option.save
      errors.merge!(user_option.errors)
    end

    user_option
  end

  def to_model
    user_option
  end

  def persisted?
    true
  end
end