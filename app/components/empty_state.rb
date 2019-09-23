class EmptyState < ActionView::Component::Base
  validates :type, presence: true

  def initialize(type:)
    @type = type
  end

  private

  attr_reader :type
end