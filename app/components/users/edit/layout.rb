class Users::Edit::Layout < ActionView::Component::Base
  validates :content, presence: true

  def initialize(*)
  end

  private

  attr_reader :content
end