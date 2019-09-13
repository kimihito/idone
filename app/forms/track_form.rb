class TrackForm < Patterns::Form
  param_key "track"
  attribute :raw_body, String
  attribute :owner_id, String
  attribute :project_id, String
  attribute :action_name, String

  validates :raw_body, :owner_id, :project_id, presence: true

  private

  def persist
    update_track and create_activity
  end


  def update_track
    resource.update_attributes(attributes.except(:action_name))
  end

  def create_activity
    resource.create_activity((attributes[:action_name].presence&.to_sym || :create), owner: @form_owner)
  end
end