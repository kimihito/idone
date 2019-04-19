class Track < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :project

  scope :recent, -> { order('created_at DESC') }
end
