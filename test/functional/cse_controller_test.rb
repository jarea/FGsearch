require 'test_helper'

class CseControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get forum" do
    get :forum
    assert_response :success
  end

  test "should get product" do
    get :product
    assert_response :success
  end

  test "should get blog" do
    get :blog
    assert_response :success
  end

  test "should get video" do
    get :video
    assert_response :success
  end

  test "should get beautynews" do
    get :beautynews
    assert_response :success
  end

end
