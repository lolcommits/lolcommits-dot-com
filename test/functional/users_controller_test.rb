require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "account" do
    sign_in create(:user)
    get :account
    assert_response :success
  end

  test "show html" do
    sign_in create(:user)
    user2 = create(:user)
    get :show, params: { id: user2.id }
    assert_response :success
  end

  test "show json" do
    sign_in create(:user)
    user2 = create(:user)
    get :show, format: :json, params: { id: user2.id }
    assert_response :success
  end

  test "show json by handle" do
    sign_in create(:user)
    user2 = create(:user, name: 'yologuy')
    get :show, format: :json, params: { id: user2.name }
    assert_response :success
  end

  test "show not found" do
    sign_in create(:user)
    get :show, params: { id: 'omgomg' }
    assert_response :not_found
  end
end
