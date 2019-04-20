class TrackForm < Patterns::Form
  include Twitter::TwitterText::Extractor

  param_key "track"
  attribute :raw_body, String
  attribute :owner_id, String

  validates :raw_body, :owner_id, presence: true

  private

  def persist
    project = project_from_raw_body
    resource.update_attributes(attributes.merge(project_id: project&.id))
  end

  def project_from_raw_body
    project_titles = extract_hashtags(raw_body)
    Project.find_by(title: project_titles)
  end
end