require "application_system_test_case"

class TaggingsTest < ApplicationSystemTestCase
  setup do
    @tagging = taggings(:one)
  end

  test "visiting the index" do
    visit taggings_url
    assert_selector "h1", text: "Taggings"
  end

  test "should create tagging" do
    visit taggings_url
    click_on "New tagging"

    fill_in "Post", with: @tagging.post_id
    fill_in "Tag", with: @tagging.tag_id
    click_on "Create Tagging"

    assert_text "Tagging was successfully created"
    click_on "Back"
  end

  test "should update Tagging" do
    visit tagging_url(@tagging)
    click_on "Edit this tagging", match: :first

    fill_in "Post", with: @tagging.post_id
    fill_in "Tag", with: @tagging.tag_id
    click_on "Update Tagging"

    assert_text "Tagging was successfully updated"
    click_on "Back"
  end

  test "should destroy Tagging" do
    visit tagging_url(@tagging)
    click_on "Destroy this tagging", match: :first

    assert_text "Tagging was successfully destroyed"
  end
end
