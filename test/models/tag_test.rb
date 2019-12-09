require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "Tag.unused returns unused tag" do
    unused_tag = Tag.create(name: 'unused')
    used_tag = Tag.create(name: 'used', track: Track.create(raw_body: "#used tag", owner: users(:idoneman)))
    assert Tag.unused, [unused_tag]
  end
end
