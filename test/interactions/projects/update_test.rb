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

  test "should reduce project tag" do
    assert_difference "ProjectTag.count", -1 do
      Projects::Update.run(@project.attributes.merge(project: @project, tag_names: []))
    end
  end

  test "should replace project tag" do
    old_tag = @project.tag_names
    outcome = Projects::Update.run(@project.attributes.merge(project: @project, tag_names: ['new_tag']))
    assert ['new_tag'] == [*outcome.result.tag_names]
    assert [*old_tag] != [*outcome.result.tag_names]
  end
end