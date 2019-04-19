class ProjectForm < Patterns::Form
  param_key "project"
  attribute :title, String
  attribute :owner_id, String


  validates :title, presence: true
  validates :owner_id, presence: true

  private

  def persist
    resource.update_attributes(attributes)
  end
end