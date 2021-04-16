require "test_helper"

class BarbersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @barber = barbers(:one)
  end

  test "should get index" do
    get barbers_url
    assert_response :success
  end

  test "should get new" do
    get new_barber_url
    assert_response :success
  end

  test "should create barber" do
    assert_difference('Barber.count') do
      post barbers_url, params: { barber: { description: @barber.description, first_name: @barber.first_name, last_name: @barber.last_name } }
    end

    assert_redirected_to barber_url(Barber.last)
  end

  test "should show barber" do
    get barber_url(@barber)
    assert_response :success
  end

  test "should get edit" do
    get edit_barber_url(@barber)
    assert_response :success
  end

  test "should update barber" do
    patch barber_url(@barber), params: { barber: { description: @barber.description, first_name: @barber.first_name, last_name: @barber.last_name } }
    assert_redirected_to barber_url(@barber)
  end

  test "should destroy barber" do
    assert_difference('Barber.count', -1) do
      delete barber_url(@barber)
    end

    assert_redirected_to barbers_url
  end
end
