class Tracks::Destroy < ActiveInteraction::Base
  object :track, default: nil

  validates :track, presence: true

  def execute
    errors.merge!(track.errors) unless track.destroy
  end
end
