class Tracks::BulkCreate < ActiveInteraction::Base
  string :raw_body, default: nil
  object :owner, class: User, default: nil

  validates :raw_body, presence: true

  def execute
    Track.transaction do
      raw_body.lines(chomp: true).each do |line|
        compose(Tracks::Create, owner: owner, raw_body: line)
      end
    end
  end

  def to_model
    Track.new
  end
end
