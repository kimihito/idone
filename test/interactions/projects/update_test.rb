require 'test_helper'

class Projects::UpdateTest < ActiveSupport::TestCase
  def setup
    @project = projects(:project_1)
    @owner = @project.owner
  end

  test "should update project attributes" do
    assert @project.title != 'updated title'
    outcome = Projects::Update.run(@project.attributes.merge(tag_names: [*@project.tag_names], title: 'updated title', project: @project))
    assert outcome.result.title == 'updated title'
  end

  test "should detach track with removed project tag" do
    tag = @project.tags.first
    track = Track.create(raw_body: "hi ##{tag.name} !!!", tag: tag, owner: @owner)
    outcome = Projects::Update.run(@project.attributes.merge(project: @project, tag_names: []))
    assert_not outcome.result.tracks.include?(track)
  end

  test "should replace project tag" do
    old_tag = @project.tag_names
    outcome = Projects::Update.run(@project.attributes.merge(project: @project, tag_names: ['new_tag']))
    assert_equal ['new_tag'], [*outcome.result.tag_names]
  end
end