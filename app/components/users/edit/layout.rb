class Users::Edit::Layout < ActionView::Component::Base
  validates :content, :current_path, presence: true

  def initialize(current_path:)
    @current_path = current_path
  end

  private

  attr_reader :content, :current_path
end