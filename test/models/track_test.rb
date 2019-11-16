require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "should order recently" do
    track1 = Track.create(owner: users(:idoneman), raw_body: 'raw body', tag: projects(:project_1).tags.first, created_at: Time.current.yesterday)
    track2 = Track.create(owner: users(:idoneman), raw_body: 'raw body', tag: projects(:project_1).tags.first, created_at: Time.current)
    assert Track.recent, [track2, track1]
  end
end
