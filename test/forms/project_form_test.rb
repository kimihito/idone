require 'test_helper'

class ProjectFormTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
  end

  test "should not save title project without title" do
    form = ProjectForm.new(Project.new, { owner_id: @owner.id, title: '' })
    assert_not form.save
  end

  test "should not save title project without owner" do
    form = ProjectForm.new(Project.new, { title: 'タイトル', owner_id: '' })
    assert_not form.save
  end

  test "should save project" do
    assert_difference "Project.count" do
      form = ProjectForm.new(Project.new, { owner_id: @owner.id, title: 'title' })
      form.save
    end

    assert_difference "Project.count" do
      form = ProjectForm.new(Project.new, { owner_id: @owner.id, title: 'title', description: '' })
      form.save
    end
  end
end
