require "test_helper"

class FreetimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @freetime = freetimes(:one)
  end

  test "should get index" do
    get freetimes_url
    assert_response :success
  end

  test "should get new" do
    get new_freetime_url
    assert_response :success
  end

  test "should create freetime" do
    assert_difference('Freetime.count') do
      post freetimes_url, params: { freetime: { barber_id: @freetime.barber_id, from: @freetime.from, permanent: @freetime.permanent, to: @freetime.to } }
    end

    assert_redirected_to freetime_url(Freetime.last)
  end

  test "should show freetime" do
    get freetime_url(@freetime)
    assert_response :success
  end

  test "should get edit" do
    get edit_freetime_url(@freetime)
    assert_response :success
  end

  test "should update freetime" do
    patch freetime_url(@freetime), params: { freetime: { barber_id: @freetime.barber_id, from: @freetime.from, permanent: @freetime.permanent, to: @freetime.to } }
    assert_redirected_to freetime_url(@freetime)
  end

  test "should destroy freetime" do
    assert_difference('Freetime.count', -1) do
      delete freetime_url(@freetime)
    end

    assert_redirected_to freetimes_url
  end
end
