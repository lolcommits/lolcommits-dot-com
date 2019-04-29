ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
FakeWeb.allow_net_connect = false
require 'mocha/setup'
require 'shoulda'
require 'shoulda/matchers'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  setup do
    AnimatedGif.any_instance.expects(:store_animation).at_least(0)
  end
end

class ActionController::TestCase
  def sign_in(user)
    session[:user_id] = user.id
  end

  def json_resp
    ActiveSupport::JSON.decode(@response.body)
  end
end
