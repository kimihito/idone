require 'test_helper'

class TrackDecoratorTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  def setup
    @track = Track.new.extend TrackDecorator
    @project = projects(:project_1)
  end

  test 'should link to project name in raw_body' do
    @track.raw_body = "track for ##{@project.title}"
    assert_equal @track.body, "track for <a href='#{project_path(@project)}'>#{@project.title}</a>"
  end
end
