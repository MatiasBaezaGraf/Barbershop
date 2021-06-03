require "application_system_test_case"

class FreetimesTest < ApplicationSystemTestCase
  setup do
    @freetime = freetimes(:one)
  end

  test "visiting the index" do
    visit freetimes_url
    assert_selector "h1", text: "Freetimes"
  end

  test "creating a Freetime" do
    visit freetimes_url
    click_on "New Freetime"

    fill_in "Barber", with: @freetime.barber_id
    fill_in "From", with: @freetime.from
    fill_in "Permanent", with: @freetime.permanent
    fill_in "To", with: @freetime.to
    click_on "Create Freetime"

    assert_text "Freetime was successfully created"
    click_on "Back"
  end

  test "updating a Freetime" do
    visit freetimes_url
    click_on "Edit", match: :first

    fill_in "Barber", with: @freetime.barber_id
    fill_in "From", with: @freetime.from
    fill_in "Permanent", with: @freetime.permanent
    fill_in "To", with: @freetime.to
    click_on "Update Freetime"

    assert_text "Freetime was successfully updated"
    click_on "Back"
  end

  test "destroying a Freetime" do
    visit freetimes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Freetime was successfully destroyed"
  end
end
