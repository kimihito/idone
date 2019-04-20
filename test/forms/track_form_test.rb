require 'test_helper'

class TrackFormTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
    @project = Project.create(title: 'title', owner: @owner)
  end

  test "should not save track without raw_body" do
    form = TrackForm.new(Track.new, { owner_id: @owner.id, raw_body: '' })
    assert_not form.save
  end

  test "should not save track without owner" do
    form = TrackForm.new(Track.new, { raw_body: 'タイトル', owner_id: nil,  })
    assert_not form.save
  end

  test "should save track" do
    assert_difference 'Track.count' do
      form = TrackForm.new(Track.new, {raw_body: "##{@project.title} body", owner_id: @owner.id})
      form.save
    end
  end

  test "should extract track's project from raw_body" do
    form = TrackForm.new(Track.new, { raw_body: "##{@project.title} body", owner_id: @owner.id })
    form.save!
    track = Track.order('created_at DESC').first
    assert track.project, @project
  end

  test "should not save track without project" do
    form = TrackForm.new(Track.new, { raw_body: "#no_project body", owner_id: @owner.id })
    assert_not form.save
  end
end