require 'test_helper'

class Tracks::BulkCreateTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
  end

  test "should save multi tracks with lines" do
    lines = ["#hello world", "#idone today"]
    assert_difference "Track.count", lines.length do
      Tracks::BulkCreate.run(owner: @owner, raw_body: lines.join("\n"))
    end
  end

  test "should not save and rollback multi tracks" do
    assert_no_difference "Track.count" do
      Tracks::BulkCreate.run(owner: @owner, raw_body: "#hello world\n idone today")
    end
  end
end