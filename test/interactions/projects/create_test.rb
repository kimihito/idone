require 'test_helper'

class Projects::CreateTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
  end

  test "should not save project without title" do
    assert_no_difference "Project.count" do
      Projects::Create.run(title: '', description: 'description', owner: @owner)
    end
  end

  test "should not save project without owner" do
    assert_no_difference "Project.count" do
      Projects::Create.run(title: 'title', owner: nil)
    end
  end

  test "should not save project over description" do
    assert_no_difference "Project.count" do
      Projects::Create.run(title: 'title', owner: @owner, description: "a" * (Project::DESCRIPTION_MAXIMUM + 1))
    end
  end

  test "should save project" do
    assert_difference "Project.count" do
      Projects::Create.run(owner: @owner, title: 'title', description: '')
    end
  end

  test "should save project and project_tags" do
    assert_difference ["Project.count", "ProjectTag.count"] do
      Projects::Create.run(owner: @owner, title: 'title', tag_names: ['tag_one'], description: '')
    end
  end
end