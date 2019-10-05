class TrackForm2
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string, default: nil
  attribute :raw_body, :string, default: nil
  attribute :owner_id, :string, default: nil
  attribute :project_id, :string, default: nil
  attribute :action_name, :string, default: "create"

  validates :raw_body, :owner_id, :project_id, presence: true

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      track.update(attributes.except(:action_name, :resource))
      track.create_activity(attributes.except(:resource)[:action_name].presence.to_sym, owner_id: attributes[:owner_id])
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def persisted?
    track.persisted?
  end

  private

  def track
    Track.find_or_initialize_by(id: self.id)
  end

  def persist
  end
end