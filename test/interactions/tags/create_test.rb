require 'test_helper'

class Tags::CreateTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
    @project = Project.create(owner: @owner, title: 'project title')
  end

  test "should find tag from connecting by project" do
    tag_name = 'tag'
    project_tag = Tag.create(name: tag_name, project: @project)
    track_tag = Tag.create(name: tag_name, track: Track.create(raw_body: 'raw_body'))
    assert_no_difference "Tag.count" do
      Tags::Create.run(name: tag_name, owner: @owner)
    end
    outcome = Tags::Create.run(name: tag_name, owner: @owner)
    assert outcome.result == project_tag
    assert_not outcome.result == track_tag
  end

  test 'should not save with empty name' do
    assert_no_difference 'Tag.count' do
      Tags::Create.run(name: '', owner: @owner)
    end
  end

  test 'should not save using other project' do
    tag_name = 'same_tag'
    other_project = Project.create(owner: @owner, title: 'other project title')
    project_tag = Tag.create(name: tag_name, project: other_project)

    assert_no_difference 'Tag.count' do
     Tags::Create.run(name: tag_name, owner: @owner, project: @project)
    end
  end
end
