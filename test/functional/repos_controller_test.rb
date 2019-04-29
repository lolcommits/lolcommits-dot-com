require 'test_helper'

class ReposControllerTest < ActionController::TestCase

  test "new not logged in" do
    get :new
    assert_redirected_to auth_github_url
  end

  test "new logged in" do
    sign_in create(:user)
    get :new
    assert_response :success
  end

  test "create validation error" do
    sign_in create(:user)
    assert_no_difference 'Repo.count' do
      post :create, params: { repo: { name: ' ' } }
    end

    assert_response :unprocessable_entity
  end

  test "create success" do
    user = create(:user)
    sign_in user

    assert_difference 'Repo.count' do
      post :create, params: { repo: { name: 'lolcommits' } }
    end

    repo = Repo.last
    assert_redirected_to repo_path(repo)
    assert_equal 'lolcommits', repo.name
    assert_equal [user], repo.users
    assert_not_nil repo.external_id
  end

  test "show not found" do
    sign_in create(:user)
    get :show, params: { id: 'omg' }
    assert_response :not_found
  end

  test "show success" do
    sign_in create(:user)
    repo = create(:repo)
    get :show, params: { id: repo.id }
    assert_response :success
  end

  test "show works logged out too" do
    repo = create(:repo)
    get :show, params: { id: repo.id }
    assert_response :success
  end

  test "show index" do
    sign_in create(:user)
    repo = create(:repo)
    create(:git_commit, :repo=> repo)

    get :index, format: :json

    assert_response :success
    assert_equal repo.external_id, json_resp.first['external_id']
    assert_equal repo.id, json_resp.first['id']
    assert_equal repo.name, json_resp.first['name']
  end

  test "show index with filter" do
    sign_in create(:user)
    repo_a = create(:repo, :name => 'a')
    repo_b = create(:repo, :name => 'b')
    repo_c = create(:repo, :name => 'c')

    get :index, format: :json, params: { repos: ['a', 'c'] }

    assert_response :success
    assert_equal 2, json_resp.length

    assert_equal repo_a.external_id, json_resp.first['external_id']
    assert_equal repo_a.id, json_resp.first['id']
    assert_equal repo_a.name, json_resp.first['name']

    assert_equal repo_c.external_id, json_resp.last['external_id']
    assert_equal repo_c.id, json_resp.last['id']
    assert_equal repo_c.name, json_resp.last['name']
  end
end
