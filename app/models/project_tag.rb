class ProjectTag < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :track
end
