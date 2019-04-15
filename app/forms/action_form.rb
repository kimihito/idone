class ActionForm < Patterns::Form
  include Twitter::TwitterText::Extractor

  param_key "action"
  attribute :raw_body, String

  validates :raw_body, presence: true

  private

  def persist
    update_action && update_project
  end

  def update_action
    resource.update_attributes(attributes.slice(:raw_body))
  end

  def update_project
    hashtags = extract_hashtags(raw_body)
    project = Project.find_by(title: hastags)
    resource.update_attributes(project: project)
  end
end