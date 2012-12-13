require 'test_helper'

class TermCountsControllerTest < ActionController::TestCase
  setup do
    @term_count = term_counts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_counts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_count" do
    assert_difference('TermCount.count') do
      post :create, term_count: { count: @term_count.count }
    end

    assert_redirected_to term_count_path(assigns(:term_count))
  end

  test "should show term_count" do
    get :show, id: @term_count
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term_count
    assert_response :success
  end

  test "should update term_count" do
    put :update, id: @term_count, term_count: { count: @term_count.count }
    assert_redirected_to term_count_path(assigns(:term_count))
  end

  test "should destroy term_count" do
    assert_difference('TermCount.count', -1) do
      delete :destroy, id: @term_count
    end

    assert_redirected_to term_counts_path
  end
end
