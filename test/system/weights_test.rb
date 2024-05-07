require "application_system_test_case"

class WeightsTest < ApplicationSystemTestCase
  setup do
    @weight = weights(:one)
  end

  test "visiting the index" do
    visit weights_url
    assert_selector "h1", text: "Weights"
  end

  test "should create weight" do
    visit weights_url
    click_on "New weight"

    fill_in "Date", with: @weight.date
    fill_in "Unit", with: @weight.unit
    fill_in "User", with: @weight.user_id
    fill_in "Value", with: @weight.value
    click_on "Create Weight"

    assert_text "Weight was successfully created"
    click_on "Back"
  end

  test "should update Weight" do
    visit weight_url(@weight)
    click_on "Edit this weight", match: :first

    fill_in "Date", with: @weight.date
    fill_in "Unit", with: @weight.unit
    fill_in "User", with: @weight.user_id
    fill_in "Value", with: @weight.value
    click_on "Update Weight"

    assert_text "Weight was successfully updated"
    click_on "Back"
  end

  test "should destroy Weight" do
    visit weight_url(@weight)
    click_on "Destroy this weight", match: :first

    assert_text "Weight was successfully destroyed"
  end
end
