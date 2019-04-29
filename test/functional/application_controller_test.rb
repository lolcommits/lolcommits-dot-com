require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  self.controller_class = ReposController

  test "current_user by session" do
    user = create(:user)
    sign_in user
    get :index, format: :json

    assert_response :success
  end

  test "current_user by api key" do
    user = create(:user)
    t = Time.now.to_i.to_s
    get :index, format: :json, params: {
      key: user.api_key,
      t: t,
      token: Digest::SHA1.hexdigest(user.api_secret + t)
    }

    assert_response :success
  end

  test "api credentials not good" do
    user = create(:user)
    get :index, format: :json, params: {
      key: user.api_key,
      t: "OMG",
      token:  Digest::SHA1.hexdigest(user.api_secret + "LOL")
    }

    assert_response :unauthorized
  end

  test "api credentials cannot find user" do
    get :index, format: :json, params: {
      key: "OMG",
      t: "OMG",
      token:  Digest::SHA1.hexdigest("LOL")
    }

    assert_response :unauthorized
  end
end
