require 'test_helper'

class TrackFormTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
    @project = Project.create(title: 'title', owner: @owner)
  end

  test "should not save track without raw_body" do
    form = TrackForm.new(Track.new, { owner_id: @owner.id, raw_body: '', project_id: @project.id })
    assert_not form.save
  end

  test "should not save track without owner" do
    form = TrackForm.new(Track.new, { raw_body: 'タイトル', owner_id: nil,  project_id: @project.id })
    assert_not form.save
  end

  test "should not save track without project" do
    form = TrackForm.new(Track.new, { raw_body: 'タイトル', owner_id: nil,  project_id: @project.id })
    assert_not form.save
  end

  test "should save track" do
    assert_difference 'Track.count' do
      form = TrackForm.new(Track.new, {raw_body: "##{@project.title} body", owner_id: @owner.id, project_id: @project.id })
      form.save
    end
  end

  test "should update project updated_at when track is created" do
    travel_to Time.current.yesterday do
      @project = Project.create(title: 'title title', owner: @owner)
    end
    old_project_updated_at = @project.updated_at
    form = TrackForm.new(Track.new, {raw_body: "##{@project.title} body", owner_id: @owner.id, project_id: @project.id })
    form.save
    track_updated_at = form.send(:resource).updated_at
    new_project_updated_at = @project.reload.updated_at
    assert_not_equal old_project_updated_at.to_s, new_project_updated_at.to_s
    assert_equal track_updated_at.to_s, new_project_updated_at.to_s
  end

  test "should not update project updated_at when track is updated" do
    travel_to Time.current.yesterday do
      @project = Project.create(title: 'new_project', owner: @owner)
      @track = Track.create(raw_body: "##{@project.title} exists", owner: @owner, project: @project)
    end
    old_project_updated_at = @project.updated_at
    form = TrackForm.new(@track, {raw_body: "##{@project.title} body", owner_id: @owner.id, project_id: @project.id })
    form.save
    track_updated_at = form.send(:resource).updated_at
    new_project_updated_at = @project.reload.updated_at
    assert_equal old_project_updated_at.to_s, new_project_updated_at.to_s
    assert_not_equal track_updated_at.to_s, new_project_updated_at.to_s
  end
end