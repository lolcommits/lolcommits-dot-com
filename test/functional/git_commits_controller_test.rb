require 'test_helper'

class GitCommitsControllerTest < ActionController::TestCase
  test "new" do
    sign_in create(:user)
    get :new
    assert_response :success
  end

  test "create failure" do
    sign_in create(:user)
    repo = create(:repo, external_id: 'omg')
    assert_no_difference 'GitCommit.count' do
      post :create, params: { git_commit: { sha: ' ', repo_external_id: 'omg' } }
    end
    assert_response :unprocessable_entity
  end

  test "create failure json" do
    sign_in create(:user)
    repo = create(:repo, external_id: 'omg')
    assert_no_difference 'GitCommit.count' do
      post :create, format: :json, params: { git_commit: { sha: ' ', repo_external_id: 'omg' } }
    end
    assert_response :unprocessable_entity
    assert ! ActiveSupport::JSON.decode(@response.body)['errors'].blank?
  end

  test "create success json" do
    user = create(:user)
    sign_in user
    repo = create(:repo, external_id: 'omg')

    assert_difference 'GitCommit.count' do
      post :create, format: :json, params: {
        git_commit: {
          sha: 'sss',
          repo_external_id: 'omg'
        }
      }
    end

    gc = GitCommit.last
    assert_response :success
    assert_equal gc.id, json_resp['id']
    assert_equal user.id, json_resp['user_id']
    assert_equal repo, gc.repo
  end

  test "create success" do
    sign_in create(:user)
    repo = create(:repo, external_id: 'omg')
    assert_difference 'GitCommit.count' do
      post :create, params: {
        git_commit: {
          sha: 'sss',
          repo_external_id: 'omg'
        }
      }
    end

    gc = GitCommit.last
    assert_equal repo, gc.repo
    assert_redirected_to git_commit_path(gc)
  end

  test "create pass invalid repo_id" do
    sign_in create(:user)
    repo = create(:repo, external_id: 'omg')
    assert_no_difference 'GitCommit.count' do
      post :create, params: {
        git_commit: {
          sha: 'sss',
          repo_external_id: 'lol'
        }
      }
    end
    assert_response :not_found
  end

  test "show not found" do
    get :show, params: { id: 'omg' }
    assert_response :not_found
  end

  test "show success" do
    gc = create(:git_commit)
    get :show, params: { id: gc.id }
    assert_response :success
  end

  test "index no sha specified" do
    get :index
    assert_response :bad_request
  end

  test "index" do
    gc1 = create(:git_commit)
    gc2 = create(:git_commit)
    gc3 = create(:git_commit)

    get :index, params: { shas: [gc1.sha, gc2.sha].join(',') }
    assert_equal [gc1.id, gc2.id].sort, ActiveSupport::JSON.decode(@response.body).collect{|gc| gc['id'] }.sort
  end

  test "latest_commits" do
    gc = []
    10.times do |x|
      gc[x] = create(:git_commit, created_at: Time.now + x.day)
    end

    get :latest_commits
    response = ActiveSupport::JSON.decode(@response.body)
    assert_equal 5, response.length
    assert response.collect{|x| x['id']}.include?(gc[5].id)
    assert response.collect{|x| x['id']}.include?(gc[9].id)

    get :latest_commits, params: { limit: 3 }
    response = ActiveSupport::JSON.decode(@response.body)
    assert_equal 3, response.length
    assert response.collect{|x| x['id']}.include?(gc[7].id)
    assert response.collect{|x| x['id']}.include?(gc[9].id)
  end

  test "user filtered latest_commits" do
    gc = []
    user_1 = create(:user)
    user_2 = create(:user)
    10.times do |x|
      gc[x] = create(:git_commit, user_id: [user_1.id, user_2.id].sample, created_at: Time.now + x.day)
    end

    get :latest_commits, params: { user_ids: [user_1.id] }

    response = ActiveSupport::JSON.decode(@response.body)

    assert_equal user_1.git_commits.count, response.length
    assert response.collect{ |x| x['user_id'] }.all? do |gc_user_id|
      gc_user_id = user1.id
    end
  end
end
