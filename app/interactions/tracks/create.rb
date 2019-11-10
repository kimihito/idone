class Tracks::Create < ActiveInteraction::Base
  include Twitter::TwitterText::Extractor

  string :raw_body, default: nil
  object :owner, class: User, default: nil
  object :project, default: nil

  validates :raw_body, :owner, presence: true
  validate :membership?, if: :project?

  def execute
    @track = Track.new(inputs)
    @track.tag = compose(Tags::Create, name: tag_name, owner: owner)
    if @track.save
      touch_project
      @track.create_activity(:create, owner: @track.owner)
    else
      errors.merge!(@track.errors)
    end
    @track
  end

  def to_model
    Track.new
  end

  private

  def membership?
    errors.add(:project, :mismatch) unless project.owner == owner
  end

  def touch_project
    @track.project.touch(time: @track.updated_at) if @track.project
  end

  def tag_name
    extract_hashtags(raw_body)[0]
  end
end