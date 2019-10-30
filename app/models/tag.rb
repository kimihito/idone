class Tag < ApplicationRecord
  belongs_to :project, optional: true, inverse_of: :tags
  has_one :track, inverse_of: :tag
end
