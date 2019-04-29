require 'test_helper'

class GitCommitTest < ActiveSupport::TestCase
  test "validations" do
    commit = create(:git_commit)

    commit = GitCommit.new
    assert ! commit.valid?
    assert ! commit.errors[:sha].blank?
  end

  test "repo_external_id setter" do
    user1 = create(:user)
    user2 = create(:user)
    repo = create(:repo, :users => [user1])
    commit = build(:git_commit, :user => user2, :repo_external_id => repo.external_id )

    assert_equal repo, commit.repo
    repo.reload
    assert_equal [user1, user2], repo.users
  end
end
