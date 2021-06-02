require "application_system_test_case"

class HolidaysTest < ApplicationSystemTestCase
  setup do
    @holiday = holidays(:one)
  end

  test "visiting the index" do
    visit holidays_url
    assert_selector "h1", text: "Holidays"
  end

  test "creating a Holiday" do
    visit holidays_url
    click_on "New Holiday"

    fill_in "Barber", with: @holiday.barber_id
    fill_in "Freeday", with: @holiday.freeday
    fill_in "Permanent", with: @holiday.permanent
    click_on "Create Holiday"

    assert_text "Holiday was successfully created"
    click_on "Back"
  end

  test "updating a Holiday" do
    visit holidays_url
    click_on "Edit", match: :first

    fill_in "Barber", with: @holiday.barber_id
    fill_in "Freeday", with: @holiday.freeday
    fill_in "Permanent", with: @holiday.permanent
    click_on "Update Holiday"

    assert_text "Holiday was successfully updated"
    click_on "Back"
  end

  test "destroying a Holiday" do
    visit holidays_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Holiday was successfully destroyed"
  end
end
