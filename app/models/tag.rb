class Tag < ApplicationRecord
  belongs_to :project, optional: true, inverse_of: :tags
end
