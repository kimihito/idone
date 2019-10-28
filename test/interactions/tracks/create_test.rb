require 'test_helper'

class Tracks::CreateTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
  end

  test "should save with project" do
    project = Project.create(title: 'title', owner: @owner)
    assert_difference ["Track.count", "ProjectTag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: '#hello world', project: project)
    end
  end

  test "should save without project" do
    assert_difference ["Track.count", "TrackTag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: '#hello world')
    end
  end

  test "should not save without hashtag" do
    assert_no_difference ["Track.count", "TrackTag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: 'hello world')
    end
  end

  test "should not save without difference project" do
    project = Project.create(title: 'title', owner: users(:idoneman2))
    assert_no_difference ["Track.count", "ProjectTag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: '#hello world', project: project)
    end
  end
end