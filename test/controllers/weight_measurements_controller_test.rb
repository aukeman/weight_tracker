require 'test_helper'

class WeightMeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @one = weight_measurements(:one)
    @two = weight_measurements(:two)
    @other = weight_measurements(:three)
    @auth_headers=@one.user.create_new_auth_token
    @bad_headers=@auth_headers.merge('access-token' => 'XXX')
  end

  test "should get index" do
    get weight_measurements_url, headers: @auth_headers, as: :json
    assert_response :success
    assert_equal([{"day" => @one.day, "weight" => @one.weight}, {"day" => @two.day, "weight" => @two.weight}], JSON.parse(response.body))
  end

  test "should not get index if not authorized" do
    get weight_measurements_url, headers: @bad_headers, as: :json
    assert_response :unauthorized
  end 

  test "create not create if not authorized" do
    assert_no_difference('WeightMeasurement.count') do
      post weight_measurements_url, headers: @bad_headers, params: { weight_measurement: {day: 1, weight: 1} }, as: :json
    end

    assert_response :unauthorized
  end 

  test "should create weight_measurement" do
    assert_difference('WeightMeasurement.count') do
      post weight_measurements_url, headers: @auth_headers, params: { weight_measurement: {day: 1, weight: 1} }, as: :json
    end

    assert_response 201
  end

  test "should update weight_measurement" do
    patch weight_measurement_url(@one), headers: @auth_headers, params: { weight_measurement: {  } }, as: :json
    assert_response :success
  end

  test "should not weight_measurement if not authorized" do
    patch weight_measurement_url(@one), headers: @bad_headers, params: { weight_measurement: {  } }, as: :json
    assert_response :unauthorized
  end

  test "should destroy weight_measurement" do
    assert_difference('WeightMeasurement.count', -1) do
      delete weight_measurement_url(@one), headers: @auth_headers, as: :json
    end

    assert_response 204
  end

  test "should not destroy weight_measurement if not authorized" do
    assert_no_difference('WeightMeasurement.count') do
      delete weight_measurement_url(@one), headers: @bad_headers, as: :json
    end

    assert_response :unauthorized
  end

end
