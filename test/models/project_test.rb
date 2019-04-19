require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "should order recently" do
    @project1 = Project.create(title: 'title', owner: users(:idoneman), created_at: Time.current.yesterday)
    @project2 = Project.create(title: 'title', owner: users(:idoneman), created_at: Time.current)
    assert Project.recent, [@project2, @project1]
  end
end
