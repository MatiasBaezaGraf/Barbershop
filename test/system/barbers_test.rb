require "application_system_test_case"

class BarbersTest < ApplicationSystemTestCase
  setup do
    @barber = barbers(:one)
  end

  test "visiting the index" do
    visit barbers_url
    assert_selector "h1", text: "Barbers"
  end

  test "creating a Barber" do
    visit barbers_url
    click_on "New Barber"

    fill_in "Description", with: @barber.description
    fill_in "First name", with: @barber.first_name
    fill_in "Last name", with: @barber.last_name
    click_on "Create Barber"

    assert_text "Barber was successfully created"
    click_on "Back"
  end

  test "updating a Barber" do
    visit barbers_url
    click_on "Edit", match: :first

    fill_in "Description", with: @barber.description
    fill_in "First name", with: @barber.first_name
    fill_in "Last name", with: @barber.last_name
    click_on "Update Barber"

    assert_text "Barber was successfully updated"
    click_on "Back"
  end

  test "destroying a Barber" do
    visit barbers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Barber was successfully destroyed"
  end
end
