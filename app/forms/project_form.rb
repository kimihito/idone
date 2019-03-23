class ProjectForm < Patterns::Form
  param_key "project"
  attribute :title, String
  attribute :owner_id, Integer

  validates :title, presence: true

  private

  def persist
    resource.update_attributes(attributes)
  end
end