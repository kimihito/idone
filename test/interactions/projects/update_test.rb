require 'test_helper'

class Projects::UpdateTest < ActiveSupport::TestCase
  def setup
    @project = projects(:project_1)
    @owner = @project.owner
  end

  test "should reduce project tag" do
    assert_difference "ProjectTag.count", -1 do
      Projects::Update.run(project: @project, tag_names: [])
    end
  end

  test "should replace project tag" do
    old_tag = @project.tag_names
    outcome = Projects::Update.run(project: @project, title: @project.title, description: @project.description, owner: @owner, tag_names: ['new_tag'])
    assert_equal ['new_tag'], [*outcome.result.tag_names]
  end
end