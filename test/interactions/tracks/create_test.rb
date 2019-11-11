require 'test_helper'

class Tracks::CreateTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
  end

  test "should save with project" do
    project = Project.create!(title: 'title', owner: @owner)
    Tag.create!(name: 'hello', project: project)
    assert_difference ["Track.count"] do
      Tracks::Create.run(owner: @owner, raw_body: '#hello world')
    end
  end

  test "should save without project" do
    assert_difference ["Track.count", "Tag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: '#hello world')
    end
  end

  test "should not save without hashtag" do
    assert_no_difference ["Track.count", "Tag.count"] do
      Tracks::Create.run(owner: @owner, raw_body: 'hello world')
    end
  end

  # test "should not save without difference project" do
  #   project = Project.create(title: 'title', owner: users(:idoneman2))
  #   tag = Tag.create(name: 'hello', project: project)
  #   assert_no_difference ["Track.count"] do
  #     Tracks::Create.run(owner: @owner, raw_body: "##{tag.name} world")
  #   end
  # end
end
