class Tags::Create < ActiveInteraction::Base
  object :project, :track, default: nil
  string :name, default: nil

  validates :name, presence: true

  def execute
    query = { project: project, track: track }.compact
    tag = Tag.find_or_initialize_by(query.merge(name: name))
    errors.merge!(tag.errors) unless tag.save
    tag
  end
end