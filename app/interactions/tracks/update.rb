class Tracks::Update < ActiveInteraction::Base
  include Twitter::TwitterText::Extractor

  string :raw_body, default: nil
  object :owner, class: User, default: nil
  object :project, :track, default: nil

  validates :raw_body, :owner, :track, presence: true
  validate :membership?, if: :project?

  def execute
    track.raw_body = raw_body if raw_body?
    track.tag = compose(Tags::Create, name: tag_name, owner: owner, project: project)
    if track.save
      touch_project
      track.create_activity(:update, owner: track.owner)
    else
      errors.merge!(track.errors)
    end
    track
  end

  def to_model
    track
  end

  def persisted?
    true
  end

  private

  def membership?
    errors.add(:project, :mismatch) unless project.owner == owner
  end

  def touch_project
    track.project.touch(time: track.updated_at) if track.project
  end

  def tag_name
    extract_hashtags(raw_body)[0]
  end
end
