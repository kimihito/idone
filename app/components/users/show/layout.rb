class Users::Show::Layout < ActionView::Component::Base
  validates :user, :content, :current_path, presence: true
  validates :editable, inclusion: { in: [true, false] }

  def initialize(user:, editable:, current_path:)
    @user = user
    @editable = editable
    @current_path = current_path
  end

  private

  attr_reader :user, :editable, :current_path
end
