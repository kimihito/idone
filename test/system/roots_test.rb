require "application_system_test_case"

class RootsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit '/'

    assert_selector "h1", text: "Root"
  end
end
