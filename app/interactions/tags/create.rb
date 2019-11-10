class Tags::Create < ActiveInteraction::Base
  object :owner, class: User, default: nil
  string :name, default: nil

  validates :name, presence: true

  def execute
    tag = Tag.used_by(owner: owner).find_or_initialize_by(name: name)
    errors.merge!(tag.errors) unless tag.save
    tag
  end
end