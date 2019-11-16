class Tags::Create < ActiveInteraction::Base
  object :owner, class: User, default: nil
  object :project, default: nil
  string :name, default: nil

  validates :name, presence: true

  def execute
    @tag = Tag.used_by(owner: owner).find_or_initialize_by(name: name)
    already_used? if project?
    errors.merge!(@tag.errors) unless @tag.save
    @tag
  end

  private

  def already_used?
    return unless @tag.project
    errors.add(:name, :already_used) if project != @tag.project
  end
end
