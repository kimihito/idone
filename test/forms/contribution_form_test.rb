require 'test_helper'

class ContributionFormTest < ActiveSupport::TestCase
  def setup
    @owner = users(:idoneman)
    @project = Project.create(title: 'title', owner: @owner)
  end

  test "should not save contribution without raw_body" do
    form = ContributionForm.new(Contribution.new, { owner_id: @owner.id, raw_body: '' })
    assert_not form.save
  end

  test "should not save contribution without owner" do
    form = ContributionForm.new(Contribution.new, { raw_body: 'タイトル', owner_id: nil,  })
    assert_not form.save
  end

  test "should save contribution" do
    assert_difference 'Contribution.count' do
      form = ContributionForm.new(Contribution.new, {raw_body: "##{@project.title} body", owner_id: @owner.id})
      form.save
    end
  end

  test "should extract contribution's project from raw_body" do
    form = ContributionForm.new(Contribution.new, { raw_body: "##{@project.title} body", owner_id: @owner.id })
    form.save!
    contribution = Contribution.order('created_at DESC').first
    assert contribution.project, @project
  end

  test "should not save contribution without project" do
    form = ContributionForm.new(Contribution.new, { raw_body: "#no_project body", owner_id: @owner.id })
    assert_not form.save
  end
end