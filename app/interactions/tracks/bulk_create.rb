class Tracks::BulkCreate < ActiveInteraction::Base
  string :raw_body, default: nil
  object :owner, class: User, default: nil

  validates :raw_body, presence: true

  def execute
    Track.transaction do
      @tracks = raw_body.lines(chomp: true).map do |line|
        compose(Tracks::Create, owner: owner, raw_body: line)
      end
    end

    @tracks
  end

  def to_model
    Track.new
  end
end