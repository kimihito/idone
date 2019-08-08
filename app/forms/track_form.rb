class TrackForm < Patterns::Form
  param_key "track"
  attribute :raw_body, String
  attribute :owner_id, String
  attribute :project_id, String

  validates :raw_body, :owner_id, presence: true
  validates :project_id, presence: true

  private

  def persist
    resource.update_attributes(attributes)
  end
end