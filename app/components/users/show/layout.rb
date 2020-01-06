class Users::Show::Layout < ActionView::Component::Base
  validates :user, :content, :editable, presence: true

  def initialize(user:, editable:)
    @user = user
    @editable = editable
  end

  private

  attr_reader :user, :editable
end
